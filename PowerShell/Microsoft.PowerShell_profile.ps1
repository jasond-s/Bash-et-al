
# Load posh-git example profile
#. 'C:\Users\jdryh\Documents\WindowsPowerShell\Modules\posh-git\profile.example.ps1'

#First in your powershell profile in
#C:\Users\<<username>>\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1
 
#Then in:
#C:\Users\<<username>>\Documents\WindowsPowerShell\Get-ChildItemColor.ps1

# function prompt {
#     "$(split-path "$pwd" -leaf -resolve) $lastexitcode $Global:GitStatus #>"
# } 

try {
    Import-Module posh-git
}
catch [System.Exception] {
    cd $env:temp
    git clone https://github.com/dahlbyk/posh-git.git    
    .\install.ps1

    Import-Module posh-git
}

# Set up a simple prompt, adding the git prompt parts inside git repos
function global:prompt {
    $realLASTEXITCODE = $LASTEXITCODE

    # Reset color, which can be messed up by Enable-GitColors
    $Host.UI.RawUI.ForegroundColor = $GitPromptSettings.DefaultForegroundColor

    Write-Host($(split-path "$pwd" -leaf -resolve)) -nonewline

    $fore = $Host.UI.RawUI.ForegroundColor
    if (get-job){        
        $Host.UI.RawUI.ForegroundColor = 'Green'
        Write-Host " (⌐■_■)" -nonewline
    } else {        
        $Host.UI.RawUI.ForegroundColor = 'Cyan'
        Write-Host " ( •_•)" -nonewline
    }
    $Host.UI.RawUI.ForegroundColor = $fore

    Write-VcsStatus

    $global:LASTEXITCODE = $realLASTEXITCODE
    return " #> "
}

Enable-GitColors

Pop-Location

function Get-ChildItemColor {
    <#
    .Synopsis
    Returns childitems with colors by type.
    From http://poshcode.org/?show=878
    .Description
    This function wraps Get-ChildItem and tries to output the results
    color-coded by type:
    Compressed - Yellow
    Directories - Dark Cyan
    Executables - Green
    Text Files - Cyan
    Others - Default
    .ReturnValue
    All objects returned by Get-ChildItem are passed down the pipeline
    unmodified.
    .Notes
    NAME: Get-ChildItemColor
    AUTHOR: Tojo2000 <tojo2000@tojo2000.com>
    #>
    $regex_opts = ([System.Text.RegularExpressions.RegexOptions]::IgnoreCase `
    -bor [System.Text.RegularExpressions.RegexOptions]::Compiled)
     
    $fore = $Host.UI.RawUI.ForegroundColor
    $compressed = New-Object System.Text.RegularExpressions.Regex('\.(zip|tar|gz|rar)$', $regex_opts)
    $executable = New-Object System.Text.RegularExpressions.Regex('\.(exe|bat|cmd|py|pl|ps1|psm1|vbs|rb|reg|fsx)$', $regex_opts)
    $dll_pdb = New-Object System.Text.RegularExpressions.Regex('\.(dll|pdb)$', $regex_opts)
    $configs = New-Object System.Text.RegularExpressions.Regex('\.(config|conf|ini)$', $regex_opts)
    $text_files = New-Object System.Text.RegularExpressions.Regex('\.(txt|cfg|conf|ini|csv|log)$', $regex_opts)
     
    Invoke-Expression ("Get-ChildItem $args") |
    %{
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
        echo $_
        $Host.UI.RawUI.ForegroundColor = $fore
    }
}

# set-location D:\code
# . "C:\Users\<<username>>\Documents\WindowsPowerShell\Get-ChildItemColor.ps1" # read the colourized ls
set-alias ls Get-ChildItemColor -force -option allscope
function Get-ChildItem-Force { ls -Force }
set-alias la Get-ChildItem-Force -option allscope
 
