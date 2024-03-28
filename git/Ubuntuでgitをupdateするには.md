---
bibliography: 
  - https://git-scm.com/download/linux
repositoryUrl:
draft: false
---

# Ubuntuでgitをupdateするには

https://gist.github.com/YuMS/6d7639480b17523f6f01490f285da509

インストール前のバージョン。

```bash
git --version
# git version 2.34.1
```

Ubuntu の公式リポジトリは Git の最新版をサポートしていないので、アップデートできない。

```bash
sudo apt-get update
sudo apt-get install git -y
# ...
# git is already the newest version (1:2.34.1-1ubuntu1.10).
# ...
# 0 upgraded, 0 newly installed, 0 to remove and 165 not upgraded.
```

Personal Package Archives for Ubuntu (PPA) をリポジトリに追加する。

https://launchpad.net/ubuntu/+ppas

```bash
sudo add-apt-repository -y ppa:git-core/ppa
# PPA publishes dbgsym, you may need to include 'main/debug' component
# Repository: 'deb https://ppa.launchpadcontent.net/git-core/ppa/ubuntu/ jammy main'
# Description:
# The most current stable version of Git for Ubuntu.

# For release candidates, go to https://launchpad.net/~git-core/+archive/candidate .
# More info: https://launchpad.net/~git-core/+archive/ubuntu/ppa
# Adding repository.
# Adding deb entry to /etc/apt/sources.list.d/git-core-ubuntu-ppa-jammy.list
# Adding disabled deb-src entry to /etc/apt/sources.list.d/git-core-ubuntu-ppa-jammy.list
# Adding key to /etc/apt/trusted.gpg.d/git-core-ubuntu-ppa.gpg with fingerprint E1DD270288B4E6030699E45FA1715D88E1DF1F24
# Hit:1 https://packages.microsoft.com/ubuntu/22.04/prod jammy InRelease
# Get:2 https://deb.nodesource.com/node_20.x jammy InRelease [4,563 B]                           
# Hit:3 http://security.ubuntu.com/ubuntu jammy-security InRelease                                            
# Hit:4 http://archive.ubuntu.com/ubuntu jammy InRelease                                 
# Hit:5 http://archive.ubuntu.com/ubuntu jammy-updates InRelease                    
# Hit:6 http://archive.ubuntu.com/ubuntu jammy-backports InRelease                  
# Get:7 https://ppa.launchpadcontent.net/git-core/ppa/ubuntu jammy InRelease [23.8 kB]
# Get:8 https://ppa.launchpadcontent.net/git-core/ppa/ubuntu jammy/main amd64 Packages [2,840 B]
# Get:9 https://ppa.launchpadcontent.net/git-core/ppa/ubuntu jammy/main Translation-en [2,088 B]
# Fetched 33.3 kB in 3s (12.0 kB/s)           
# Reading package lists... Done
```

パッケージのリストを更新する。

```bash
sudo apt-get update
# Hit:1 https://packages.microsoft.com/ubuntu/22.04/prod jammy InRelease
# Get:2 https://deb.nodesource.com/node_20.x jammy InRelease [4,563 B]                                                                                                                       
# Hit:3 http://security.ubuntu.com/ubuntu jammy-security InRelease                                                                                                                                       
# Hit:4 http://archive.ubuntu.com/ubuntu jammy InRelease                                                                                                               
# Hit:5 http://archive.ubuntu.com/ubuntu jammy-updates InRelease                   
# Hit:6 http://archive.ubuntu.com/ubuntu jammy-backports InRelease
# Hit:7 https://ppa.launchpadcontent.net/git-core/ppa/ubuntu jammy InRelease
# Fetched 4,563 B in 1s (3,677 B/s)
# Reading package lists... Done
```

Git をインストールする。

```bash
sudo apt-get install git -y
# ...
# 2 upgraded, 0 newly installed, 0 to remove and 165 not upgraded.
# ...
```

アップデートされた。

```bash
git --version
# git version 2.43.2
```
