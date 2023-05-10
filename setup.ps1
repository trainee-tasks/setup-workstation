# Install Winget (if not already installed) with the latest version
if (!(Get-Command winget -ErrorAction SilentlyContinue)) {
    Write-Host "Winget is not installed. Installing Winget..."
    Invoke-WebRequest -Uri "https://github.com/microsoft/winget-cli/releases/latest/download/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle" -OutFile "$env:TEMP\winget.msixbundle"
    Add-AppPackage -Path "$env:TEMP\winget.msixbundle" -ForceApplicationShutdown
    Write-Host "Winget installed successfully!"
}
else {
    Write-Host "Winget is already installed."
}

# Install Visual Studio Code using Winget
Write-Host "Installing Visual Studio Code..."
winget install --exact --id Microsoft.VisualStudioCode
Write-Host "Visual Studio Code installed successfully!"

Write-Host "Installing Git..."
winget install --exact --id Git.Git
Write-Host "Git installed successfully!"

# Array of extensions to install
$extensions = @(
    "ritwickdey.liveserver"
)

# Install each extension using the VSCode command-line interface
$vscode_path = (Get-ItemProperty HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\* |
    Where-Object { $_.DisplayName -eq "Visual Studio Code" }).InstallLocation
$vscode_exe = Join-Path $vscode_path "bin\code.cmd"

foreach ($extension in $extensions) {
    & $vscode_exe --install-extension $extension
}

# Define the folder to clone the repositories into
$destination_folder = "C:\repos"

# Define an array of repository URLs to clone
$repository_urls = @(
    "https://github.com/trainee-tasks/calculator-js.git"
    "https://github.com/trainee-tasks/ToDoList-js.git"
)

# Clone each repository into the destination folder
foreach ($url in $repository_urls) {
    $folder_name = $url.Split("/")[-1].Replace(".git", "")
    $folder_path = Join-Path $destination_folder $folder_name
    if (Test-Path $folder_path) {
        Write-Host "Folder '$folder_path' already exists, skipping clone."
    }
    else {
        Write-Host "Cloning repository '$url' into folder '$folder_path'."
        git clone $url $folder_path
    }
}

# Opens VS Code from the repos folder
code "C:\repos"