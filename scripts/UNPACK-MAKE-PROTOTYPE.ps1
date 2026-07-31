$ErrorActionPreference = "Stop"

$repoRoot = Split-Path -Parent $PSScriptRoot
$archiveFile = Join-Path $repoRoot "reference\archive\make-prototype-source.zip.b64"
$outputDir = Join-Path $repoRoot "reference\make-prototype"
$tempZip = Join-Path $env:TEMP "retailos-make-prototype-source.zip"

if (-not (Test-Path $archiveFile)) {
    throw "Missing prototype archive: $archiveFile"
}

$base64 = Get-Content $archiveFile -Raw
[System.IO.File]::WriteAllBytes($tempZip, [System.Convert]::FromBase64String($base64))

if (Test-Path $outputDir) {
    Remove-Item $outputDir -Recurse -Force
}

New-Item -ItemType Directory -Path $outputDir -Force | Out-Null
Expand-Archive -Path $tempZip -DestinationPath $outputDir -Force
Remove-Item $tempZip -Force

Write-Host "Make prototype extracted to: $outputDir"
Write-Host "Keep this folder immutable. Cursor builds only in apps\pos-web."
