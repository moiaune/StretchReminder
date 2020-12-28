function Start-TimeOut {
    [CmdletBinding()]
    param (
        [Parameter()]
        [double]
        $Interval = 15,

        [Parameter()]
        [int]
        $StretchTime = 15
    )

    begin {
        $uniqueId = New-Guid
    }

    process {
        while ($true) {
            Start-Sleep -Seconds ($Interval * 60)

            $DataBinding = @{
                'ProgressBarValue'        = 0
                'ProgressBarValueDisplay' = "0 seconds"
            }

            $Progress = New-BTProgressBar -Status "Stretch, stretch, stretch!" -Value 'ProgressBarValue'  -ValueDisplay 'ProgressBarValueDisplay'

            New-BurntToastNotification -UniqueIdentifier $uniqueId -ProgressBar $Progress -DataBinding $DataBinding
            
            Start-TimeOutCountdown -DataBinding $DataBinding -UniqueId $uniqueId -Duration $StretchTime
        }
    }

}
