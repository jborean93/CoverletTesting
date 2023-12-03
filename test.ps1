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

coverlet `
    "$PSScriptRoot/bin" `
    --target $exe `
    --targetargs "-EncodedCommand $encCommand"
