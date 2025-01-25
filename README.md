# Windows Sandbox Pre-Installed Programs

A Microsoft Windows Sandbox with .WSB file for auto install of programs on boot of sandbox. Including but adjustable to any applications.

Not the quickest due to sequencial install of applications post boot of system.

Current install time ~3min, System Dependent.

## Prerequisites

Using a Windows system with the sandbox enabled.
If you are unsure if you have this please check:
[Setup Windows Sandbox](https://learn.microsoft.com/en-us/windows/security/application-security/application-isolation/windows-sandbox/windows-sandbox-install#installation)

System Requirements from learn.microsoft.com:
```
Arm64 (for Windows 11, version 22H2 and later) or AMD64 architecture
Virtualization capabilities enabled in BIOS
At least 4 GB of RAM (8 GB recommended)
At least 1 GB of free disk space (SSD recommended)
At least two CPU cores (four cores with hyper-threading recommended)
```

If you already have Windows Sandbox working on your computer now please follow the below steps exactly to ensure the provided files will work.

## Setup
The provided files will install the below programs on startup from fastest to slowest:
```
Winrar (701), 0.46s
Sublime Text (4192), 1.27s
DB Browser for SQLite (3.13.1), 4.33s
Chrome, 11.54s
Git (2.47.1.2), 28.06s
VS Code (1.96.4), 36.86s
Python (3.12.8), 40.62s
Java 1.8 (JRE 8u441), 45.94s
```

1. Create a new folder at the base of your ```C:\``` drive which should then follow this tree:
```
C:\windows-sandbox\default-setup
```

2. Inside of the above specified path please download the installers from this below list, and place them all in the path.

- [Chrome](https://dl.google.com/tag/s/appguid%3D%7B8A69D345-D564-463C-AFF1-A69D9E530F96%7D%26iid%3D%7BC4348067-C07A-AB3A-24D4-49A0F069B2DC%7D%26lang%3Den%26browser%3D3%26usagestats%3D0%26appname%3DGoogle%2520Chrome%26needsadmin%3Dprefers%26ap%3Dx64-stable-statsdef_1%26installdataindex%3Dempty/chrome/install/ChromeStandaloneSetup64.exe)
- [Winrar](https://www.win-rar.com/fileadmin/winrar-versions/winrar/winrar-x64-701.exe)
- [Sublime Text](https://www.sublimetext.com/download_thanks?target=win-x64#direct-downloads)
- [VS Code](https://code.visualstudio.com/sha/download?build=stable&os=win32-x64-user)
- [DB Browser for SQLite](https://download.sqlitebrowser.org/DB.Browser.for.SQLite-v3.13.1-win64.msi)
- [Git](https://github.com/git-for-windows/git/releases/download/v2.47.1.windows.2/Git-2.47.1.2-64-bit.exe)
- [Python 3.12.8](https://www.python.org/ftp/python/3.12.8/python-3.12.8-amd64.exe)
- [Java JRE 8u441](https://javadl.oracle.com/webapps/download/AutoDL?BundleId=251656_7ed26d28139143f38c58992680c214a5)

3. Download the ```install.bat``` and place it in the **same directory** as the installers (```C:\windows-sandbox\default-setup```)

4. Download ```sandbox-pre-setup-1.0.wsb```, This can go **anywhere** and will be what you use to run the sandbox with the programs to auto-install.

5. Please note the default ```sandbox-pre-setup-1.0.wsb``` will use **8GB** of ram, and **6 Cores** of your CPU. Please **ensure** your system meets these requirements, otherwise reduce the runtime confuration as applicable. Beware of the base requirements in Prerequisites:

6. When running you can check the install progress of the applications by going to ```C:\Temp\install_log.txt``` inside of the sandbox.

**Reminder** The install process will take ~3 minutes, they cannot seemingly be ran in parallel, hence the /wait in the install.bat, to view progress please refresh the ```install_log.txt```

## Adjusting the Script
**To adjust the programs, or locations of any files please check below:**

### Using other applications:
1. Find and download the installers to your desired applications,
2. Place the new installers placed in the directory ```C:\windows-sandbox\default-setup```
3. **Optional**, Open the ```install.bat``` and remove any unwanted application installs.
4. In the ```install.bat``` remove any lines for unwanted applications.
5. Add the new lines for installing following the below method.

**For .exe**
```
echo Starting <Application Name> installation at %date% %time% >> "%LOG_FILE%"
start /wait "" "%INSTALLER_DIR%\\<installer_full_name>.exe" <silent arguments> >> "%LOG_FILE%" 2>&1
echo Finished <Application Name> installation at %date% %time% >> "%LOG_FILE%"
```
**For .msi**
```
echo Starting <Application Name> installation at %date% %time% >> "%LOG_FILE%"
start /wait "" msiexec /i "%INSTALLER_DIR%\\<installer_full_name>.msi" <silent arguments> >> "%LOG_FILE%" 2>&1
echo Finished <Application Name> at %date% %time% >> "%LOG_FILE%"
```
Please remember to update the below parts:
1. <Application Name> Replace this with the human readable name of the application, 
2. <installer_full_name> Update with the full name of the installer in the directory, 
3. <silent arguments> **Consider** that different applications installers may require different arguments, here are some from the current applications:
``` 
WinRar = /s
Sublime Text = /verysilent
Chrome = /silent /install
Git = /verysilent
Vs Code = /verysilent --no-welcome --no-update --user-data-dir "%TEMP%"
Python = quiet InstallAllUsers=1 PrependPath=1
Java = /s
```

### Moving the location of the installers and .bat:
- Adjust the ```sandbox-pre-setup-1.0.wsb``` file's ```<HostFolder>/full/path/to/installers/</HostFolder>``` to match your alternative directory (previously ```C:\windows-sandbox\default-setup```). Please ensure that the install.bat remains in the same location as the installers.

### Adjusting Resources used by the sandbox:
1. To adjust the RAM, go to the ```sandbox-pre-setup-1.0.wsb``` and adjust the ```<MemoryInMB>8192</MemoryInMB>``` line,
2. To adjust the CPU Cores, go to the ```sandbox-pre-setup-1.0.wsb``` and adjust the ```<ProcessorCount>6</ProcessorCount>```

### Changing the internal Sandbox Folder Location: ***Not Recommended***
1. Go to the ```sandbox-pre-setup-1.0.wsb``` and adjust the ```<SandboxFolder>C:\Users\WDAGUtilityAccount\default- setup</SandboxFolder>``` to be the new path
2. Go to the ```install.bat``` and adjust the ```"INSTALLER_DIR=C:\Users\WDAGUtilityAccount\default-setup"``` to be the new path

### Changing the name of ```install.bat```:
1. Update the name of the ```install.bat```,
2. Go to the ```sandbox-pre-setup-1.0.wsb``` and adjust the ```<Command>C:\Users\WDAGUtilityAccount\default-setup\install.bat</Command>``` to reflect the new ```install.bat``` name

## Contributing

Please feel free to adjust this as you want, if you know any faster methods for parallel installs, or for auto-installing on Windows Sandbox, please let me know.

## License

[Apache 2.0](./LICENSE)
