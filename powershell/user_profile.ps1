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
    nvim "$obsidianPath/Quick Notes/$(Get-Date -Format 'yyyyMMddHHmmss').md"
}
Function of {
    $noteDir = "$obsidianPath/Zettelkasten/Fleeting Notes"
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
Function oz {
    $noteDir = "$obsidianPath/Zettelkasten/Literature Notes"
    if (!(Test-Path $noteDir)) {
        Write-Host "Directory $noteDir does not exist. Please check the path."
        return
    }
    $timestamp = Get-Date -Format 'yyyyMMddHHmmss'
    $fileName = "$noteDir\$timestamp.md"
    $templateFile = "$obsidianPath/Templates/LiteratureNote.md"

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
Function nvc {
  nvim "$HOME/AppData/Local/nvim/init.vim"
}
Set-Alias v nvim
Set-Alias vi nvim
Set-Alias vim nvim

### LEETCODE ###
Function leetcode {
    param(
        [Parameter(Mandatory=$true)]
        [string]$Url
    )

    # Define directories
    $noteDir = "$obsidianPath/leetcode"
    $scriptsDir = "$HOME/dotfiles/scripts/leetcode"

    # Ensure directories exist
    if (!(Test-Path $noteDir)) {
        New-Item -ItemType Directory -Path $noteDir -Force
    }

    if (!(Test-Path $scriptsDir)) {
        Write-Host "Scripts directory $scriptsDir does not exist. Please check your dotfiles setup."
        return
    }

    # Extract problem name from URL and format it
    $problemName = $Url -replace '.*problems/([^/]*)/.*', '$1'
    
    # Convert kebab-case to Title Case
    $formattedName = (Get-Culture).TextInfo.ToTitleCase(
        ($problemName -replace '-', ' ')
    )
    
    # Generate filename
    $timestamp = Get-Date -Format 'yyyyMMddHHmmss'
    $filename = "$noteDir\$formattedName.md"

    # Call the JavaScript script
    node "$scriptsDir/leetcode_scraper.js" $Url $filename

    # Open the new note in Neovim
    nvim $filename
}
