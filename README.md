# Monitoring Microsoft Windows Backup Status from Nagios with NRPE and NSClient++

## For Windows 2012

Copy script check_backup.ps1 in NSClient++  scripts folder on  Windows Server Client

Edit NSC.ini  (config file for NSclient++) and add in section [External Scripts]
```
check_backup=cmd /c echo scripts\check_backup_win2012.ps1; exit($LastExitCode) | powershell.exe -command -
```

Authorize remote scripts execution

In powershell (_Run as Admin_)  execute this command
```
Set-ExecutionPolicy remotesigned
```

Restart service NSClient++

_On powershell_
```
Restart-Service nscp
```

Enable feature .NET Framework
```
DISM /Online /Enable-Feature /FeatureName:NetFx3
```

## For Windows Server 2008

Copy script check_backup.ps1 in NSClient++  scripts folder on  Windows Server Client

Edit NSC.ini  (config file for NSclient++) and add in section [External Scripts]
```
check_backup=cmd /c echo scripts\check_backup.ps1; exit($LastExitCode) | powershell.exe -command -
```


Authorize remote scripts execution

In powershell (_Run as Admin_)  execute this command
```
Set-ExecutionPolicy remotesigned
```

Restart service NSClient++

_On powershell_
```
Restart-Service NSClientpp
```

Enable feature .NET Framework
```
DISM /Online /Enable-Feature /FeatureName:NetFx3
```


## Debug

To view events logs in powershell you can use command
```
Get-WinEvent @{Path = "C:\Windows\System32\winevt\Logs\Microsoft-Windows-Backup.evtx" }
```

For only view specific events add `Level` parameter:
Example for warning events
```
Get-WinEvent @{Path = "C:\Windows\System32\winevt\Logs\Microsoft-Windows-Backup.evtx" ; Level = 3}
```
Levels:
* 1,2 : Critical
* 3 : Warnings
* For success status use parameter `ID = 4`

On Windows server 2012 simply use command :
```
get-wbjob -previous 1
```
