$configuration = $env:BUILD_CONFIGURATION
if (-not $configuration) {
    $configuration = 'Debug'
}

foreach ($framework in 'net472', 'net6.0') {
    Write-Host "Compiling for $framework"

    dotnet publish `
        --configuration $configuration `
        --framework $framework `
        src/MyAssembly/MyAssembly.csproj
}
