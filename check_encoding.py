import chardet

# Check the encoding of the JSON file
with open('infomodule\data\info.json', 'rb') as f:
    result = chardet.detect(f.read())
    print(f"Current encoding: {result['encoding']}")

# If the encoding is not UTF-8, convert it to UTF-8
if result['encoding'].lower() != 'utf-8':
    with open('infomodule\data\info.json', 'r', encoding=result['encoding']) as f:
        content = f.read()

    with open('infomodule\data\info.json', 'w', encoding='utf-8') as f:
        f.write(content)
    print("File encoding converted to UTF-8")
else:
    print("File is already in UTF-8 encoding")