# Monitoring Microsoft Windows Backup Status from Nagios with NRPE and NSClient++

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
````
Restart-Service NSClientpp
```
