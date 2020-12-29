function Start-StretchReminder {
    <#
    .SYNOPSIS
        Starts the StretchReminder module
    
    .DESCRIPTION
        The Start-StretchReminder function starts the timer that sleeps for x minutes (interval) and then displays a notification with a countdown in y seconds (duration).
    
    .PARAMETER Interval
        The interval between each notification.
    
    .PARAMETER Duration
        The duration of the countdown on the notification.
    
    .EXAMPLE
        PS C:\> Start-StretchReminder -Interval 15 -Duration 15
        Starts the StretchReminder module with a 15 minutes interval and 15 seconds countdown.
    
    .LINK
        https://github.com/madsaune/StretchReminder/blob/main/Public/Start-StretchReminder.ps1
    #>

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

            Start-StretchReminderCountdown -DataBinding $DataBinding -UniqueId $uniqueId -Duration $Duration
        }
    }

}
