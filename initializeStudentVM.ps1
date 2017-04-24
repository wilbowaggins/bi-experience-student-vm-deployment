$AdminKey = "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A7-37EF-4b3f-8CFC-4F3A74704073}"
$UserKey = "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A8-37EF-4b3f-8CFC-4F3A74704073}"
Set-ItemProperty -Path $AdminKey -Name "IsInstalled" -Value 0
Set-ItemProperty -Path $UserKey -Name "IsInstalled" -Value 0
Rundll32 iesetup.dll, IEHardenLMSettings,1,True
Rundll32 iesetup.dll, IEHardenUser,1,True
Rundll32 iesetup.dll, IEHardenAdmin,1,True

REG ADD "HKLM\Software\Microsoft\ServerManager" /v DoNotOpenServerManagerAtLogon /t REG_DWORD /d 00000001 /f

$HomepageKey = "HKCU:\Software\Microsoft\Internet Explorer\Main"
Set-ItemProperty -Path $HomepageKey -Name "Start Page" -Value "http://powerbi.com"

mkdir \DIAD

$Url = "http://aka.ms/diad"
$LocalPath = "C:\DIAD\DIADMaterials.zip"
$Wget = New-Object System.Net.WebClient
$Wget.DownloadFile($Url, $LocalPath)

$shell = new-object -com shell.application
$zip = $shell.NameSpace("C:\DIAD\DIADMaterials.zip")
foreach($item in $zip.items())
{
$shell.Namespace("C:\DIAD").copyhere($item)
}

#set-executionpolicy remotesigned
#save below as install.ps1

function Download-Json {
param ([string] $url)
  $downloader = new-object System.Net.WebClient
  , $downloader.DownloadString($url) | ConvertFrom-Json
}
 
function Download-File {
param ([string] $url, [string] $file)
  $downloader = new-object System.Net.WebClient
  , $downloader.DownloadFile($url, $file)
}

$PBIExe = "C:\Program Files\Microsoft Power BI Desktop\bin\PBIDesktop.exe"
$install = $false
$PBIConfig = Download-Json "http://download.microsoft.com/download/9/B/A/9BAEFFEF-1A68-4102-8CDF-5D28BFFE6A61/PBIDesignerConfig.json"

if (test-path $PBIExe) {
    $installedVersion = [version]$(gi $PBIExe).VersionInfo.FileVersion
 
    $currentVersion = [version]$($PBIConfig.release.x64 | where {$_.key -eq "ClientUpdateVersion"}).value
    if ($currentVersion.Major -gt $installedVersion.Major -or $currentVersion.Minor -gt $installedVersion.Minor -or $currentVersion.Build -gt $installedVersion.Build) {$install=$true}
}
else{$install=$true}
 
if ($install) {
    $msiPath = "$env:temp\PowerBI.msi";
  
    $download=$true
 
    if ($download){Download-File 'http://go.microsoft.com/fwlink/?LinkID=521662' $msiPath}
   
    msiexec /i $msiPath ACCEPT_EULA=1 /passive /quiet /lv PBI_log.txt
}

$LocalTempDir = $env:TEMP; $ChromeInstaller = "ChromeInstaller.exe"; (new-object System.Net.WebClient).DownloadFile('http://dl.google.com/chrome/install/375.126/chrome_installer.exe', "$LocalTempDir\$ChromeInstaller"); & "$LocalTempDir\$ChromeInstaller" /silent /install
