Import-Module GotoDir

Set-PSReadlineOption -BellStyle None

$DOCUMENTS=[Environment]::GetFolderPath('MyDocuments')

$env:VIRTUAL_ENV_DISABLE_PROMPT = 1

oh-my-posh init pwsh --config $DOCUMENTS\PowerShell\atomicBitEdit.omp.json | Invoke-Expression

function Get-ChildItemColor {
    $regex_opts = ([System.Text.RegularExpressions.RegexOptions]::IgnoreCase `
    -bor [System.Text.RegularExpressions.RegexOptions]::Compiled)
     
    $fore = $Host.UI.RawUI.ForegroundColor
    $compressed = New-Object System.Text.RegularExpressions.Regex('\.(zip|tar|gz|rar)$', $regex_opts)
    $executable = New-Object System.Text.RegularExpressions.Regex('\.(exe|bat|cmd|py|pl|ps1|psm1|vbs|rb|reg|fsx)$', $regex_opts)
    $dll_pdb = New-Object System.Text.RegularExpressions.Regex('\.(dll|pdb)$', $regex_opts)
    $configs = New-Object System.Text.RegularExpressions.Regex('\.(config|conf|ini)$', $regex_opts)
    $text_files = New-Object System.Text.RegularExpressions.Regex('\.(txt|cfg|conf|ini|csv|log)$', $regex_opts)
     
    Invoke-Expression ("Get-ChildItem $args") |
    ForEach-Object{
        $c = $fore
        if ($_.GetType().Name -eq 'DirectoryInfo') {
            $c = 'DarkCyan'
        } elseif ($compressed.IsMatch($_.Name)) {
            $c = 'Yellow'
        } elseif ($executable.IsMatch($_.Name)) {
            $c = 'Green'
        } elseif ($text_files.IsMatch($_.Name)) {
            $c = 'Cyan'
        } elseif ($dll_pdb.IsMatch($_.Name)) {
            $c = 'DarkGreen'
        } elseif ($configs.IsMatch($_.Name)) {
            $c = 'Yellow'
        }
        $Host.UI.RawUI.ForegroundColor = $c
        Write-Output $_
        $Host.UI.RawUI.ForegroundColor = $fore
    }
}

set-alias ls Get-ChildItemColor -force -option allscope
function Get-ChildItem-Force { ls -Force }
set-alias la Get-ChildItem-Force -option allscope

# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

$now=Get-Date
$end=$now.Date.AddDays(1)

if ($end-$now -gt [timespan]"12:00:00") {
    Write-Host " __  __              _                _                   "
    Write-Host "|  \/  |___ _ _ _ _ (_)_ _  __ _   _ | |__ _ ___ ___ _ _  "
    Write-Host "| |\/| / _ \ '_| ' \| | ' \/ _' | | || / _' (_-</ _ \ ' \ "
    Write-Host "|_|  |_\___/_| |_||_|_|_||_\__, |  \__/\__,_/__/\___/_||_|"
    Write-Host "                           |___/                          "
} elseif ($end-$now -lt [timespan]"7:00:00") {
    Write-Host " ___              _                _                   "
    Write-Host "| __|_ _____ _ _ (_)_ _  __ _   _ | |__ _ ___ ___ _ _  "
    Write-Host "| _|\ V / -_) ' \| | ' \/ _' | | || / _' (_-</ _ \ ' \ "
    Write-Host "|___|\_/\___|_||_|_|_||_\__, |  \__/\__,_/__/\___/_||_|"
    Write-Host "                        |___/                          "
} else {
    Write-Host "   _    __ _                                   _                   "
    Write-Host "  /_\  / _| |_ ___ _ _ _ _  ___  ___ _ _    _ | |__ _ ___ ___ _ _  "
    Write-Host " / _ \|  _|  _/ -_) '_| ' \/ _ \/ _ \ ' \  | || / _' (_-</ _ \ ' \ "
    Write-Host "/_/ \_\_|  \__\___|_| |_||_\___/\___/_||_|  \__/\__,_/__/\___/_||_|"
    Write-Host "                                                                   "
}