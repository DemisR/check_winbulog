$returnStateOK = 0
$returnStateWarning = 1
$returnStateCritical = 2
$returnStateUnknown = 3

$date = (Get-Date).AddDays(-1)

try
{
    $CritEvents = Get-WinEvent @{Path = "C:\Windows\System32\winevt\Logs\Microsoft-Windows-Backup.evtx" ; StartTime = $date; Level = 2,1} -ErrorAction SilentlyContinue
    $CritNbEv = $CritEvents.Count
}
catch
{
}

try
{
    $WarnEvents = Get-WinEvent @{Path = "C:\Windows\System32\winevt\Logs\Microsoft-Windows-Backup.evtx" ; StartTime = $date; Level = 3} -ErrorAction SilentlyContinue
    $WarnNbEv = $WarnEvents.Count
}
catch
{
}

try
{
    $OkEvents = Get-WinEvent @{Path = "C:\Windows\System32\winevt\Logs\Microsoft-Windows-Backup.evtx" ; StartTime = $date; ID = 4 } -ErrorAction SilentlyContinue
    $OkNbEv = $OkEvents.Count
}
catch
{
}




if ($CritNbEv -eq $Null -and $CritEvents -eq $Null )
{
    $CritNbEv = 0
}
else
{
    $CritNbEv = 1
}

if ($WarnNbEv -eq $Null -and $WarnEvents -eq $Null )
{
    $WarnNbEv = 0
}
else
{
    $WarnNbEv = 1
}

if ($OkNbEv -eq $Null -and $OkEvents -eq $Null )
{
    $OkNbEv = 0
}
else
{
    $OkNbEv = 1
}





if ($WarnNbEv -ne 0) {
    $message = "WARNING - Found {0} warning in Microsoft-Windows-Backup event log" -f $WarnNbEv
    Write-Host $message
    exit $returnStateWarning
}

if ($OkNbEv -ne 0 ) {
    $message = "OK - No errors in Microsoft-Windows-Backup log "
    Write-Host $message
    exit $returnStateOK
}

if ($CritNbEv -ne 0 ) {
    $message = "CRITICAL - Found {0} errors in Microsoft-Windows-Backup event log" -f $CritNbEv
    Write-Host $message
    exit $returnStateCritical
}

Write-Host "UNKNOW - Not found backups events"
exit $returnStateUnknown
