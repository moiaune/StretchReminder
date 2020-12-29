function Start-StretchReminderCountdown {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [int]
        $Duration,

        [Parameter(Mandatory)]
        [hashtable]
        $DataBinding,

        [Parameter(Mandatory)]
        [string]
        $UniqueId
    )

    process {
        $startTime = Get-Date
        $endTime = $startTime.AddSeconds($Duration)
        $totalSeconds = (New-TimeSpan -Start $startTime -End $endTime).TotalSeconds

        Write-Verbose "StartTime: $($startTime)"
        Write-Verbose "EndTime: $($endTime)"
        Write-Verbose "TotalSeconds: $($totalSeconds)"
        Write-Verbose ''

        do {
            $now = Get-Date
            $secondsElapsed = (New-TimeSpan -Start $startTime -End $now).TotalSeconds
            $secondsRemaining = $totalSeconds - $secondsElapsed
            $percentDone = ($secondsElapsed / $totalSeconds)

            Write-Verbose "Now: $($now)"
            Write-Verbose "SecondsElapsed: $($secondsElapsed)"
            Write-Verbose "SecondsRemaining: $($secondsRemaining)"
            Write-Verbose "PercentDone: $($percentDone)"

            if ($percentDone -le 1) {
                $DataBinding['ProgressBarValueDisplay'] = '{0:n0} seconds remaining' -f $secondsRemaining
            } else {
                $DataBinding['ProgressBarValueDisplay'] = 'Done'
            }

            $DataBinding['ProgressBarValue'] = $percentDone

            $UpdateToastSplat = @{
                UniqueIdentifier = $UniqueId
                DataBinding      = $DataBinding
                ErrorAction      = 'SilentlyContinue'
            }

            Write-Verbose 'Updating notification'
            Update-BTNotification @UpdateToastSplat | Out-Null

            Write-Verbose 'Sleeping for 1 second'
            Write-Verbose "------------------------"
            Start-Sleep -Seconds 1
        } until ($now -ge $endTime)

        Write-Verbose ''

    }
}
