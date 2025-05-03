# Description: Boxstarter Script  
# Author: Laurent Kempé
# Dev settings for my app development

Disable-UAC

# Get the base URI path from the ScriptToCall value
$bstrappackage = "-bootstrapPackage"
$helperUri = $Boxstarter['ScriptToCall']
$strpos = $helperUri.IndexOf($bstrappackage)
$helperUri = $helperUri.Substring($strpos + $bstrappackage.Length)
$helperUri = $helperUri.TrimStart("'", " ")
$helperUri = $helperUri.TrimEnd("'", " ")
$helperUri = $helperUri.Substring(0, $helperUri.LastIndexOf("/"))
$helperUri += "/scripts"
write-host "helper script base URI is $helperUri"

function executeScript {
    Param ([string]$script)
    write-host "executing $helperUri/$script ..."
    iex ((new-object net.webclient).DownloadString("$helperUri/$script"))
}

#--- Setting up Windows ---
executeScript "SystemConfiguration.ps1";
executeScript "FileExplorerSettings.ps1";
# executeScript "RemoveDefaultApps.ps1";
executeScript "CommonDevTools.ps1";
executeScript "Browsers.ps1";
executeScript "WindowsTools.ps1";

# Create PowerToys backup directory and copy settings file
$powerToysBackupDir = "$HOME\Documents\PowerToys\Backup"
if (-not (Test-Path -Path $powerToysBackupDir)) {
    New-Item -Path $powerToysBackupDir -ItemType Directory -Force | Out-Null
}
Copy-Item -Path "files\powertoys\settings_133904335811162613.ptb" -Destination $powerToysBackupDir -Force

RefreshEnv
executeScript "WSL.ps1"; # TODO WSL2
RefreshEnv
executeScript "Docker.ps1";

#--- create dev folder ---
executeScript "SetupDevFolder.ps1";

# Install Java
executeScript "JavaVersions.ps1";

#--- Configure Windows environment .gitconfig, PowerShell ---
executeScript "ConfigureWindowsEnvironment.ps1";

Enable-UAC
Enable-MicrosoftUpdate
Install-WindowsUpdate -acceptEula
