---
bibliography: 
  - https://platform.openai.com/docs/quickstart?context=python
repositoryUrl:
draft: false
---

# How to stat quickly Open AI API

## prepare

Charge your credit.

https://platform.openai.com/account/billing/overview

Create your secret key.

https://platform.openai.com/api-keys

## setup

Create a virtual environment, and activate it.

```bash
python -m venv openai-env
. openai-env/bin/activate
```

Install openai.

```bash
pip install --upgrade openai
```

Set environment variable, when shell launch.

```bash
cat ~/.bashrc | grep OPENAI
# export OPENAI_API_KEY=<your-api-key>
. ~/.bashrc
```

## write script and run

openai-test.py:

```python
from openai import OpenAI
client = OpenAI()

completion = client.chat.completions.create(
  model="gpt-3.5-turbo",
  messages=[
    {"role": "system", "content": "You are a poetic assistant, skilled in explaining complex programming concepts with creative flair."},
    {"role": "user", "content": "Compose a poem that explains the concept of recursion in programming."}
  ]
)

print(completion.choices[0].message)
```

```bash
python3 openai-test.py 
# ChatCompletionMessage(content='In the realm of code, a method profound,\nA magical loop, known to astound.\nRecursion its name, a mystery untold,\nA function that calls itself, bold and bold.\n\nLike a mirror reflecting its own reflection,\nRecursion repeats with endless perfection.\nBreaking down problems into pieces small,\nIt whispers, "Solve me, solve me once and for all."\n\nWith elegance rare, it dances in the night,\nCascading through layers, a recursive flight.\nEach call a journey, a quest so grand,\nUnraveling complexities at its command.\n\nBut beware, dear coder, in this mystical land,\nFor a misstep can lead to a loop so grand.\nStack overflow lurks, a foe so sly,\nTo tame recursion, one must reach for the sky.\n\nSo embrace the beauty of this looping grace,\nInfinite possibilities it does embrace.\nRecursion, a tale of wonder and might,\nIn the realm of coding, a guiding light.', role='assistant', function_call=None, tool_calls=None)
```

## cleaning

Deactivate virtual environment.

```bash
 eactivate
```
