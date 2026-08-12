//
//  NetworkService.swift
//  NFT Marketplace
//
//  Created by Samuel Sajeev on 12/08/26.
//

import Foundation

// MARK: - NetworkError

/// Errors that can be produced by the network layer.
enum NetworkError: Error, LocalizedError {
    case invalidURL
    case noData
    case decodingFailed(Error)
    case serverError(statusCode: Int)
    case unknown(Error)

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The request URL is invalid."
        case .noData:
            return "No data was received from the server."
        case .decodingFailed(let error):
            return "Failed to decode response: \(error.localizedDescription)"
        case .serverError(let code):
            return "Server returned an error with status code \(code)."
        case .unknown(let error):
            return error.localizedDescription
        }
    }
}

// MARK: - NetworkServiceProtocol

/// Contract for the network layer.
///
/// Conforming to a protocol allows `NetworkService` to be replaced with a
/// mock implementation during unit testing without touching any ViewModel or
/// Repository code.
///
/// Note: `Sendable` is intentionally omitted from both the protocol and the
/// generic constraint. The project-wide `SWIFT_DEFAULT_ACTOR_ISOLATION = MainActor`
/// build setting means every type in this module is implicitly `@MainActor`-isolated
/// — there is no cross-actor boundary, so `Sendable` enforcement on `T` is
/// unnecessary and causes spurious conformance errors on model types whose
/// `Decodable` conformance is also `@MainActor`-isolated.
protocol NetworkServiceProtocol {

    /// Performs a network request for the given endpoint and decodes the
    /// response body into the expected `Decodable` type.
    func request<T: Decodable>(
        endpoint: NFTEndpoint,
        responseType: T.Type
    ) async throws -> T
}

// MARK: - NetworkService

/// Concrete implementation of `NetworkServiceProtocol` using `URLSession`.
///
/// Authentication headers, retry logic, and request signing should be added
/// here when the API integration phase begins.
final class NetworkService: NetworkServiceProtocol {

    // MARK: - Properties

    private let session: URLSession
    private let decoder: JSONDecoder
    private let baseURL: String

    // MARK: - Init

    init(
        session: URLSession = .shared,
        baseURL: String = AppConstants.API.baseURL
    ) {
        self.session = session
        self.baseURL = baseURL

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        self.decoder = decoder
    }

    // MARK: - NetworkServiceProtocol

    func request<T: Decodable>(
        endpoint: NFTEndpoint,
        responseType: T.Type
    ) async throws -> T {
        guard var components = URLComponents(string: baseURL + endpoint.path) else {
            throw NetworkError.invalidURL
        }

        if let queryItems = endpoint.queryItems {
            components.queryItems = queryItems
        }

        guard let url = components.url else {
            throw NetworkError.invalidURL
        }

        var urlRequest = URLRequest(
            url: url,
            timeoutInterval: AppConstants.API.timeoutInterval
        )
        urlRequest.httpMethod = endpoint.httpMethod
        urlRequest.setValue(AppConstants.API.apiKey, forHTTPHeaderField: "x-api-key")

        do {
            let (data, response) = try await session.data(for: urlRequest)

            if let httpResponse = response as? HTTPURLResponse,
               !(200..<300).contains(httpResponse.statusCode) {
                throw NetworkError.serverError(statusCode: httpResponse.statusCode)
            }

            guard !data.isEmpty else {
                throw NetworkError.noData
            }

            return try decoder.decode(T.self, from: data)
        } catch let error as NetworkError {
            throw error
        } catch let error as DecodingError {
            throw NetworkError.decodingFailed(error)
        } catch {
            throw NetworkError.unknown(error)
        }
    }
}
