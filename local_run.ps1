& "$PSScriptRoot/build.ps1"

if (Test-Path -Path $PSScriptRoot/bin) {
    Remove-Item -Path $PSScriptRoot/bin -Force -Recurse
}
Copy-Item $PSScriptRoot/src/MyAssembly/bin/Debug/net6.0/* -Destination $PSScriptRoot/bin

& "$PSScriptRoot/test.ps1"
