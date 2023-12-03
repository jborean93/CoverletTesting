$test = {
    $PSVersionTable | Out-Host

    Add-Type -Path ./bin/MyAssembly.dll

    $expected = 'Method1'
    $actual = [MyAssembly.MyClass]::Method1()

    Write-Host "Actual: '$actual'`nExpected: '$expected'"

    if ($actual -ne $expected) {
        throw "Assertion error"
    }
}
$encCommand = [Convert]::ToBase64String([Text.Encoding]::Unicode.GetBytes($test))

$exe = $env:TEST_EXE
if (-not $exe) {
    $exe = [Environment]::GetCommandLineArgs()[0] -replace '\.dll$', ''
}

$tempPath = Join-Path (Split-Path -Path $PSScriptRoot -Parent) "CoverletTesting-Temp"
Move-Item -Path $PSScriptRoot -Destination $tempPath
try {
    Push-Location -Path $tempPath

    coverlet `
        "$tempPath/bin" `
        --target $exe `
        --targetargs "-EncodedCommand $encCommand"
}
finally {
    Pop-Location
    Move-Item -Path $tempPath -Destination $PSScriptRoot
}
