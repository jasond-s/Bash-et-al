# Fetch and prune
git fetch -p

# Get remote branches
$remoteBranches = git branch -r | ForEach-Object { $_.Trim() }

# Get local branches that track origin
$localBranchesWithOrigin = git branch -vv | Where-Object { $_ -match 'origin' } | 
    ForEach-Object { ($_ -split '\s+')[1] }

# Find branches to delete (local branches with origin that don't exist in remote)
$branchesToDelete = $localBranchesWithOrigin | Where-Object {
    $localBranch = $_
    -not ($remoteBranches | Where-Object { $_ -match "$localBranch$" })
}

# Delete the branches
$branchesToDelete | ForEach-Object {
    Write-Host "Deleting branch: $_"
    git branch -d $_
}