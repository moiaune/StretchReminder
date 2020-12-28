function Start-TimeOutCountdown {
    [CmdletBinding()]
    param (
        [Parameter()]
        [pscustomobject]
        $DataBinding,

        [Parameter()]
        [string]
        $UniqueId,

        [Parameter()]
        [int]
        $Duration
    )

    process {
        $startTime = Get-Date
        $endTime = $startTime.AddSeconds($Duration)
        $totalSeconds = (New-TimeSpan -Start $startTime -End $endTime).TotalSeconds

        do {
            $now = Get-Date
            $secondsElapsed = (New-TimeSpan -Start $startTime -End $now).TotalSeconds
            $secondsRemaining = $totalSeconds - $secondsElapsed
            $percentDone = ($secondsElapsed / $totalSeconds)

            if ($percentDone -le 1) {
                $DataBinding['ProgressBarValueDisplay'] = '{0:n0} seconds remaining' -f $secondsRemaining
            }
            else {
                $DataBinding['ProgressBarValueDisplay'] = 'Done'
            }

            $DataBinding['ProgressBarValue'] = $percentDone

            $null = Update-BTNotification -UniqueIdentifier $UniqueId -DataBinding $DataBinding -ErrorAction SilentlyContinue

            Start-Sleep -Seconds 1
        } until ($now -ge $endTime)
    }
}
