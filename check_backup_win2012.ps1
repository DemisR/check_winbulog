
$returnStateOK = 0
$returnStateWarning = 1
$returnStateCritical = 2
$returnStateUnknown = 3

$status = get-wbjob -previous 1
$hresult=$status.errordescription


if ($status.hresult -eq "0" -and !$hresult)
    {
        $message = "OK - Last backup success at {0} " -f $status.endtime
        Write-Host $message
        exit $returnStateOK
    }
elseif ($hresult.Contains("warnings"))
    {
        $message = "WARNING - {0} " -f $status.endtime
        Write-Host $message
        exit $returnStateWarning
    }
else
    {
        $message = "CRITICAL - Last backup failed {0} " -f $status.endtime
        Write-Host $message
        exit $returnStateCritical
    }
if ($runningstatus.CurrentOperation)
    {$message = $runningstatus.CurrentOperation}

$message = "UNKNOW - Not found backups events"
exit $returnStateUnknown
