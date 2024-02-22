---
bibliography: 
repositoryUrl:
draft: false
---

# grepで周辺行もマッチさせるには

```bash
grep --help
# ...
# Context control:
#   -B, --before-context=NUM  print NUM lines of leading context
#   -A, --after-context=NUM   print NUM lines of trailing context
#   -C, --context=NUM         print NUM lines of output context
# ...
```

前後 2 行を含める。

```bash
cat ~/.bashrc | grep "# enable color" -C 2
# esac
# 
## enable color support of ls and also add handy aliases
# if [ -x /usr/bin/dircolors ]; then
#     test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
```

後 2 行を含める。

```bash
cat ~/.bashrc | grep "# enable color" -A 2
## enable color support of ls and also add handy aliases
# if [ -x /usr/bin/dircolors ]; then
#     test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
```
