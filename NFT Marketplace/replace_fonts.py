import os
import re

base_dir = "Features"

# Regex pattern to match `.font(.system(size: <size>[, weight: <weight>][, design: <design>]))`
pattern = re.compile(r'\.font\(\.system\(size:\s*([0-9.]+)(?:,\s*weight:\s*\.([a-zA-Z]+))?(?:,\s*design:\s*\.[a-zA-Z]+)?\)\)')

def get_font_name(weight):
    if not weight or weight == "regular":
        return "Poppins-Regular"
    elif weight == "medium":
        return "Poppins-Medium"
    else:
        return "Poppins-SemiBold"

def replace_font(match):
    size = match.group(1)
    weight = match.group(2)
    font_name = get_font_name(weight)
    return f'.font(.custom("{font_name}", size: {size}))'

for root, _, files in os.walk(base_dir):
    for file in files:
        if file.endswith(".swift"):
            filepath = os.path.join(root, file)
            with open(filepath, 'r') as f:
                content = f.read()
            
            new_content, count = pattern.subn(replace_font, content)
            
            if count > 0:
                with open(filepath, 'w') as f:
                    f.write(new_content)
                print(f"Updated {count} fonts in {filepath}")

# Also check Components
components_dir = "Components"
for root, _, files in os.walk(components_dir):
    for file in files:
        if file.endswith(".swift"):
            filepath = os.path.join(root, file)
            if os.path.exists(filepath):
                with open(filepath, 'r') as f:
                    content = f.read()
                new_content, count = pattern.subn(replace_font, content)
                if count > 0:
                    with open(filepath, 'w') as f:
                        f.write(new_content)
                    print(f"Updated {count} fonts in {filepath}")
