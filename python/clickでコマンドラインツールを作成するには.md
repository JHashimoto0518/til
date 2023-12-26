# clickでコマンドラインツールを作成するには

https://palletsprojects.com/p/click/

インストールする。

```bash
pip install click
```

モジュール (hello.py) を記述する。

```python
import click

@click.command()
@click.option("--count", default=1, help="Number of greetings.")
@click.option("--name", prompt="Your name",
              help="The person to greet.")
def hello(count, name):
    """Simple program that greets NAME for a total of COUNT times."""
    for _ in range(count):
        click.echo("Hello, %s!" % name)

if __name__ == '__main__':
    hello()
```

ヘルプを出力。

```bash
python hello.py --help
# Usage: hello.py [OPTIONS]
# 
#   Simple program that greets NAME for a total of COUNT times.
# 
# Options:
#   --count INTEGER  Number of greetings.
#   --name TEXT      The person to greet.
#   --help           Show this message and exit.
```

プロンプトを使用して、モジュールを実行する。

```bash
python hello.py --count 3
# Your name: jhashimoto
# Hello, jhashimoto!
# Hello, jhashimoto!
# Hello, jhashimoto!
```

プロンプトを使用しない。

```bash
python hello.py --count 3 --name jhashimoto
# Hello, jhashimoto!
# Hello, jhashimoto!
# Hello, jhashimoto!
```

デフォルト値を使用する。

```bash
python hello.py --name jhashimoto
# Hello, jhashimoto!
```
