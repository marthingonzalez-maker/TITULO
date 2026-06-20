$Root = Split-Path -Parent $MyInvocation.MyCommand.Path
$Web = Join-Path $Root 'agromec-web\web'
$Php = Join-Path $Root 'tools\php\php.exe'

if (-not (Test-Path $Php)) {
    Write-Host "No se encontro PHP portable en: $Php"
    exit 1
}

Start-Process powershell.exe -ArgumentList @(
    '-NoExit',
    '-ExecutionPolicy', 'Bypass',
    '-Command',
    "Set-Location '$Web'; & '$Php' artisan serve --host=127.0.0.1 --port=8001"
)

Start-Process powershell.exe -ArgumentList @(
    '-NoExit',
    '-ExecutionPolicy', 'Bypass',
    '-Command',
    "Set-Location '$Web'; npm.cmd run dev -- --host 127.0.0.1"
)

Start-Sleep -Seconds 2
Write-Host "Abre la pagina en: http://127.0.0.1:8001"
