& "$PSScriptRoot/build.ps1"

if (Test-Path -Path $PSScriptRoot/bin) {
    Remove-Item -Path $PSScriptRoot/bin -Force -Recurse
}
Copy-Item $PSScriptRoot/src/MyAssembly/bin/Debug/net6.0/* -Destination $PSScriptRoot/bin

$tempPath = Join-Path (Split-Path -Path $PSScriptRoot -Parent) "CoverletTesting-Temp"
Move-Item -Path $PSScriptRoot -Destination $tempPath
try {
    Push-Location -Path $tempPath

    & "$tempPath/test.ps1"
}
finally {
    Pop-Location
    Move-Item -Path $tempPath -Destination $PSScriptRoot
}
