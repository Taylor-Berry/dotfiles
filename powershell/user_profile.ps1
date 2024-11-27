# Check if running in an interactive session
if ($Host.Name -match 'ConsoleHost') {
    # Commands to run in interactive sessions can go here
}

### ENVIRONMENT VARIABLES ###
# Suppress greeting message
$null = $null

### SCOOP ENVIRONMENT ###
# Ensure Scoop is installed and initialize it
if (!(Get-Command scoop -ErrorAction SilentlyContinue)) {
    iwr -useb get.scoop.sh | iex
}
# Initialize Scoop
$scoopPath = (scoop which scoop) -replace '\\scoop.exe$', ''
$env:PATH = "$scoopPath;$env:PATH"

# Automatically load all scoop-installed executables in the PATH
$global:ScoopApps = "$HOME\scoop\apps"
if (Test-Path $global:ScoopApps) {
    Get-ChildItem $global:ScoopApps | ForEach-Object {
        $env:PATH += ";$($_.FullName)"
    }
}

### ALIASES ###
# General
Set-Alias config nvim
# This is the path I set for my work setup
$obsidianPath = "$HOME/Documents/Taylor's Vault"
# Obsidian
Function oo {
    Set-Location $obsidianPath 
}
Function on {
    nvim "$obsidianPath/Fleeting Notes/$(Get-Date -Format 'yyyyMMddHHmmss').md"
}
Function of {
    $noteDir = "$obsidianPath/Fleeting Notes"
    if (!(Test-Path $noteDir)) {
        Write-Host "Directory $noteDir does not exist. Please check the path."
        return
    }
    $timestamp = Get-Date -Format 'yyyyMMddHHmmss'
    $fileName = "$noteDir\$timestamp.md"
    $templateFile = "$obsidianPath/Templates/FleetingNote.md"

    if (!(Test-Path $templateFile)) {
        Write-Host "Template file $templateFile does not exist."
        return
    }

    Copy-Item $templateFile $fileName

    # Replace placeholders in the template
    (Get-Content $fileName) -replace '{{title}}', $timestamp -replace '{{date}}', (Get-Date -Format 'yyyy-MM-dd HH:mm:ss') | Set-Content $fileName

    nvim $fileName
}

# Neovim
Set-Alias nvc 'nvim $HOME\.config\nvim\init.vim'
Set-Alias v nvim
Set-Alias vi nvim
Set-Alias vim nvim
