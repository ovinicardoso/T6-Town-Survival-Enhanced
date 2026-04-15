# bank_watchdog.ps1
# Watchdog do banco - Plutonium T6 Zombies
# Abra ANTES de criar o servidor. Feche quando terminar de jogar.

$configPath = "$env:LOCALAPPDATA\Plutonium\storage\t6\players\plutonium_zm.cfg"
$logPath    = "$env:LOCALAPPDATA\Plutonium\storage\t6\main\games_mp.log"

Clear-Host
Write-Host ""
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "  Bank Watchdog - Plutonium T6 Zombies    " -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "  Config : $configPath" -ForegroundColor Gray
Write-Host "  Log    : $logPath" -ForegroundColor Gray
Write-Host ""
Write-Host "  Monitorando... (deixe aberto enquanto joga)" -ForegroundColor Yellow
Write-Host "------------------------------------------" -ForegroundColor DarkGray

# Atualiza ou adiciona a linha "seta bank_GUID VALUE" no config
function Update-BankConfig {
    param ([string]$Guid, [int]$Balance)

    $key  = "bank_$Guid"
    $line = "seta $key `"$Balance`""

    $lines = @()
    if (Test-Path $configPath) {
        $lines = [System.IO.File]::ReadAllLines($configPath)
    }

    $found   = $false
    $changed = $false

    $newLines = for ($i = 0; $i -lt $lines.Count; $i++) {
        if ($lines[$i] -match "^\s*seta\s+$([regex]::Escape($key))\b") {
            if ($lines[$i] -ne $line) { $changed = $true }
            $line
            $found = $true
        } else {
            $lines[$i]
        }
    }

    if (-not $found) {
        $newLines = @($newLines) + $line
        $changed  = $true
    }

    if ($changed) {
        [System.IO.File]::WriteAllLines($configPath, $newLines, [System.Text.Encoding]::UTF8)
    }

    return $found
}

# Guarda o ultimo saldo salvo por GUID (evita salvar duas vezes o mesmo valor)
$lastSaved = @{}

while ($true) {
    Start-Sleep -Seconds 1

    if (-not (Test-Path $logPath)) {
        continue
    }

    try {
        # Le o log inteiro usando stream compartilhado (funciona com o jogo aberto)
        $fs     = [System.IO.File]::Open($logPath, 'Open', 'Read', 'ReadWrite')
        $reader = [System.IO.StreamReader]::new($fs)
        $text   = $reader.ReadToEnd()
        $reader.Close()
        $fs.Close()

        if (-not $text) { continue }

        # Encontra o ultimo saldo de cada GUID no log atual
        $latestPerGuid = @{}
        foreach ($line in ($text -split "`n")) {
            if ($line -match '\[BANK_SAVE\]\s+([^,\s]+),(\d+)') {
                $latestPerGuid[$Matches[1].Trim()] = [int]$Matches[2]
            }
        }

        # Salva no config se o valor mudou desde o ultimo save
        foreach ($guid in $latestPerGuid.Keys) {
            $balance = $latestPerGuid[$guid]

            if (-not $lastSaved.ContainsKey($guid) -or $lastSaved[$guid] -ne $balance) {
                $wasUpdate    = Update-BankConfig -Guid $guid -Balance $balance
                $lastSaved[$guid] = $balance

                $tag = if ($wasUpdate) { "Atualizado" } else { "Novo player" }
                Write-Host "  [$(Get-Date -f 'HH:mm:ss')] $tag | GUID: $guid | Saldo: $balance pts" -ForegroundColor Green
            }
        }
    }
    catch {
        Write-Host "  [$(Get-Date -f 'HH:mm:ss')] Erro: $_" -ForegroundColor Red
    }
}
