import os
import json

base_path = "Assets.xcassets/coinsIcons"
target_path = "Assets.xcassets"

coins = ["bnb", "btc", "eth", "usdt"]

for coin in coins:
    imageset_name = f"{coin.upper()}.imageset"
    imageset_path = os.path.join(target_path, imageset_name)
    os.makedirs(imageset_path, exist_ok=True)
    
    src = os.path.join(base_path, f"{coin}.png")
    dst = os.path.join(imageset_path, f"{coin}.png")
    
    if os.path.exists(src):
        os.rename(src, dst)
        
    contents = {
        "images": [
            {
                "filename": f"{coin}.png",
                "idiom": "universal"
            }
        ],
        "info": {
            "author": "xcode",
            "version": 1
        }
    }
    
    with open(os.path.join(imageset_path, "Contents.json"), "w") as f:
        json.dump(contents, f, indent=2)

print("Done structuring assets.")
