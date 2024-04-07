---
bibliography: 
repositoryUrl:
draft: false
---

# jqで親と子要素をCSVにするには

https://teratail.com/questions/03x1lej2zo5oaz

input.json:

```json
[
  {
    "name": "a1",
    "children": [
      {
        "name": "c11"
      },
      {
        "name": "c12"
      }
    ]
  },
  {
    "name": "a2",
    "children": [
      {
        "name": "c21"
      }
    ]
  }
]
```

```bash
jq -r < input.json '.[] | .children[] as $c | [.name, $c.name] | @csv'
# "a1","c11"
# "a1","c12"
# "a2","c21"
```

run interactive.

https://jqterm.com/4edea93cd61f81b76a025fba55c09303?query=.%5B%5D%20%7C%20.children%5B%5D%20as%20%24c%20%7C%20%5B.name%2C%20%24c.name%5D%20%7C%20%40csv&raw=true
