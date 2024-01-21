---
bibliography: 
    - https://stackoverflow.com/questions/1871524/how-can-i-convert-json-to-csv
    - https://blog.enterprisedna.co/python-convert-json-to-csv/
repositoryUrl:
    - https://github.com/JHashimoto0518/python-exercise/tree/main/json2csv
draft: false
---

# jsonをcsvに変換するには

```python
import json
import csv


def convert_json_to_csv(json_file_path, csv_file_path):
    try:
        with open(json_file_path, "r") as json_file:
            data = json.load(json_file)

        headers = ["id", "component", "fill", "stroke", "shape", "refs"]

        with open(csv_file_path, "w", newline="") as csv_file:
            writer = csv.writer(csv_file)
            writer.writerow(headers)

            for resource in data["resources"]:
                row = [
                    resource["id"],
                    resource["component"],
                    resource["fill"],
                    resource["stroke"],
                    resource["shape"],
                    ",".join(str(ref) for ref in resource["refs"]),
                ]
                writer.writerow(row)

        print(
            f"JSON file '{json_file_path}' has been converted to CSV file '{csv_file_path}'."
        )
    except Exception as e:
        print(f"An error occurred: {e}")


if __name__ == "__main__":
    json_file_path = "./source.json"
    csv_file_path = "./dest.csv"
    convert_json_to_csv(json_file_path, csv_file_path)
```

```bash
python3 json2csv.py 
# JSON file './source.json' has been converted to CSV file './dest.csv'.
```
