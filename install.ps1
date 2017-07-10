
Function Reload-Env {
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User") 
}

Function AddTo-SystemPath {            
    Param(
        [string]$PathToAdd
    )

    $VerifiedPathToAdd = $null

    if ($env:Path -like "*$PathToAdd*") {
        Write-Host "$PathToAdd already exists in Path statement" 
    } else { 
        $VerifiedPathToAdd = ";$PathToAdd"
    }            

    if ($VerifiedPathToAdd -ne $null) {
        Write-Host "Adding $Path to Path statement now..."
        [Environment]::SetEnvironmentVariable("Path", $env:Path + "$VerifiedPathToAdd", [EnvironmentVariableTarget]::Machine)
    }
}

Function Get-CurrentPath {
    (Get-Item -Path ".\" -Verbose).FullName
}


# Do all the installation stuff.
$currentPath = Get-CurrentPath
AddTo-SystemPath ";$currentPath\PowerShell\Tools"
Reload-Env
