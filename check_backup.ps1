$returnStateOK = 0
$returnStateWarning = 1
$returnStateCritical = 2
$returnStateUnknown = 3

$date = (Get-Date).AddDays(-1)
try
{
$Events = Get-WinEvent @{Path = "C:\Windows\System32\winevt\Logs\Microsoft-Windows-Backup.evtx" ; StartTime = $date; Level = 3,2,1} -ErrorAction SilentlyContinue
}
catch
{
}

$NbEv = $Events.Count

if ($NbEv -eq $Null) {
  Write-Host "OK - No errors in Microsoft-Windows-Backup log "
  exit $returnStateOK
 }
else
{
Write-Host "CRITICAL - Found multiple errors in Microsoft-Windows-Backup event log"
exit $returnStateCritical
}
