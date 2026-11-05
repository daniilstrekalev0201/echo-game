# Упаковывает папку в ZIP с путями через «/» (Compress-Archive в Windows PowerShell пишет «\»,
# и на серверах игровых площадок такие файлы не находятся).
param([string]$Source, [string]$Destination)
Add-Type -AssemblyName System.IO.Compression
Add-Type -AssemblyName System.IO.Compression.FileSystem
$src = (Resolve-Path $Source).Path.TrimEnd('\')
if (Test-Path $Destination) { Remove-Item $Destination -Force }
$zip = [System.IO.Compression.ZipFile]::Open($Destination, [System.IO.Compression.ZipArchiveMode]::Create)
try {
  Get-ChildItem -Path $src -Recurse -File | ForEach-Object {
    $name = $_.FullName.Substring($src.Length + 1).Replace('\', '/')
    [System.IO.Compression.ZipFileExtensions]::CreateEntryFromFile($zip, $_.FullName, $name, [System.IO.Compression.CompressionLevel]::Optimal) | Out-Null
  }
} finally { $zip.Dispose() }
