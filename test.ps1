Add-Type -Path ./output/MyAssembly.dll

$expected = 'Method1'
$actual = [MyAssembly.MyClass]::Method1()

Write-Host "Actual: '$actual'`nExpected: '$expected'"

if ($actual -ne $expected) {
    throw "Assertion error"
}
