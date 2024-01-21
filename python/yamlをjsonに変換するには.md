---
bibliography: 
repositoryUrl:
    - https://github.com/JHashimoto0518/python-exercise/tree/main/yaml2json
draft: false
---

# yamlをjsonに変換するには

```python
import yaml
import json


def convert_yaml_to_json(yaml_file_path, json_file_path):
    try:
        with open(yaml_file_path, "r") as yaml_file:
            yaml_content = yaml.safe_load(yaml_file)

        with open(json_file_path, "w") as json_file:
            json.dump(yaml_content, json_file, indent=4)

        print(
            f"YAML file '{yaml_file_path}' has been converted to JSON file '{json_file_path}'."
        )
    except Exception as e:
        print(f"An error occurred: {e}")


if __name__ == "__main__":
    yaml_file_path = "./source.yaml"
    json_file_path = "./dest.json"
    convert_yaml_to_json(yaml_file_path, json_file_path)
```

```bash
python3 yaml2json.py
# YAML file './source.yaml' has been converted to JSON file './dest.json'.
```
