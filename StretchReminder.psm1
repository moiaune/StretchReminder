$script:moduleRoot = $PSScriptRoot

# Import everything in these folders
foreach ($folder in @('private', 'public')) {
    $f = Join-Path -Path $PSScriptRoot -ChildPath $folder
    if (Test-Path -Path $f) {
        Write-Verbose "processing folder $f"
        $files = Get-ChildItem -Path $f -Filter *.ps1

        # dot source each file
        $files | where-Object { $_.name -NotLike '*.Tests.ps1' } |
        ForEach-Object { Write-Verbose $_.name; . $_.FullName }
    }
}

if (Get-Command -Name New-BurntToastNotification -Module BurntToast -ErrorAction SilentlyContinue) {
    $script:hasBurntToast = $true
}
