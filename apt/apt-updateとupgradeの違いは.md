---
bibliography: 
repositoryUrl:
draft: true
---

# apt-updateとupgradeの違いは

パッケージリストを更新するのが `update` 。パッケージのインストールは行わない。パッケージを更新するのは`upgrede` 。

```bash
apt -h
# ...
#   update - update list of available packages
#   upgrade - upgrade the system by installing/upgrading packages
```
