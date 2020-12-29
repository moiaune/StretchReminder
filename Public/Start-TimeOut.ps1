function Start-TimeOut {
    [CmdletBinding()]
    param (
        [Parameter()]
        [double]
        $Interval = 15,

        [Parameter()]
        [int]
        $Duration = 15
    )

    begin {
        $uniqueId = New-Guid
        Write-Verbose "UniqueId: $($uniqueId)"
    }

    process {
        while ($true) {
            Write-Verbose "Sleeping for $($Interval * 60) seconds"
            Start-Sleep -Seconds ($Interval * 60)

            $DataBinding = @{
                'ProgressBarValue'        = 0
                'ProgressBarValueDisplay' = '0 seconds'
            }

            $ProgressBarSplat = @{
                Status       = 'Stretch aaand stretch..'
                Value        = 'ProgressBarValue'
                ValueDisplay = 'ProgressBarValueDisplay'
            }

            $Progress = New-BTProgressBar @ProgressBarSplat
            
            $ToastSplat = @{
                Text             = 'TIME TO STRETCH!', 'Remove your hands from the keyboard and stretch your arms and neck!'
                UniqueIdentifier = $uniqueId
                ProgressBar      = $Progress
                DataBinding      = $DataBinding
                HeroImage        = Join-Path -Path $script:ModuleRoot -ChildPath 'stretch.gif'
            }
            
            Write-Verbose 'Showing notification'
            New-BurntToastNotification @ToastSplat

            Start-TimeOutCountdown -DataBinding $DataBinding -UniqueId $uniqueId -Duration $Duration
        }
    }

}
