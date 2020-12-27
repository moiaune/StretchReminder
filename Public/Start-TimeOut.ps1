function Start-TimeOut {
    [CmdletBinding()]
    param (
        [Parameter()]
        [Int]
        $Interval
    )

    begin {

    }

    process {
        # 1. Start new job with a script block
        # 2. while $true: Sleep $Interval, then display toast notification and start over.
        # Extra: Maybe get a 10 second countdown bar in the notification?
    }

    end {
        
    }

}
