---
bibliography: 
repositoryUrl:
draft: true
---

# WSLのディスクサイズを縮小するには

以下を試したが、サイズは変わらなかった。

Powershellターミナルで、コマンドを実行する。Powershellは管理者権限で起動すること。

```ps
wsl --shutdown
```

```ps
Get-AppxPackage -Name "*ubuntu*"


Name              : CanonicalGroupLimited.Ubuntu22.04LTS
Publisher         : CN=23596F84-C3EA-4CD8-A7DF-550DCE37BCD0
Architecture      : X64
ResourceId        :
Version           : 2204.3.63.0
PackageFullName   : CanonicalGroupLimited.Ubuntu22.04LTS_2204.3.63.0_x64__79rhkp1fndgsc
InstallLocation   : C:\Program Files\WindowsApps\CanonicalGroupLimited.Ubuntu22.04LTS_2204.3.63.0_x64__79rhkp1fndgsc
IsFramework       : False
PackageFamilyName : CanonicalGroupLimited.Ubuntu22.04LTS_79rhkp1fndgsc
PublisherId       : 79rhkp1fndgsc
IsResourcePackage : False
IsBundle          : False
IsDevelopmentMode : False
NonRemovable      : False
Dependencies      : {CanonicalGroupLimited.Ubuntu22.04LTS_2204.3.63.0_neutral_split.scale-100_79rhkp1fndgsc, CanonicalGroupLimited.U
                    buntu22.04LTS_2204.3.63.0_neutral_split.scale-150_79rhkp1fndgsc}
IsPartiallyStaged : False
SignatureKind     : Store
Status            : Ok
```

```ps
optimize-vhd -Path "<replace-user-dir>\AppData\Local\Packages\CanonicalGroupLimited.Ubuntu22.04LTS_79rhkp1fndgsc\LocalState\ext4.vhdx" -Mode full
```

以下はパスとして不正になる。

```ps
$package_fullname = "CanonicalGroupLimited.Ubuntu22.04LTS_2204.3.63.0_x64__79rhkp1fndgsc"
```

```ps
optimize-vhd -Path "%USERPROFILE%\AppData\Local\Packages\$package_fullname\LocalState\ext4.vhdx" -Mode full
```
