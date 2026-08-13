require 'xcodeproj'

project_path = 'NFT Marketplace.xcodeproj'
project = Xcodeproj::Project.open(project_path)
target = project.targets.find { |t| t.name == 'NFT Marketplace' }

fonts_group = project.main_group.find_subpath('NFT Marketplace/Resources/Fonts', true)

Dir.glob('NFT Marketplace/Resources/Fonts/*.ttf').each do |file|
  basename = File.basename(file)
  next if fonts_group.files.any? { |f| f.path == basename }
  
  file_ref = fonts_group.new_file(basename)
  target.resources_build_phase.add_file_reference(file_ref, true)
end

project.save
puts "Added fonts to Xcode project."
