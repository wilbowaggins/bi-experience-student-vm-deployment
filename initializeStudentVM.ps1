REG ADD "HKLM\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A7-37EF-4b3f-8CFC-4F3A74704073}" /v IsInstalled /t REG_DWORD /d 00000000 /f
REG ADD "HKLM\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A8-37EF-4b3f-8CFC-4F3A74704073}" /v IsInstalled /t REG_DWORD /d 00000000 /f


REG ADD "HKLM\Software\Microsoft\ServerManager" /v DoNotOpenServerManagerAtLogon /t REG_DWORD /d 00000001 /f

mkdir \DIAD

$Url = "https://biexperencestd.blob.core.windows.net/resources/DIADMaterials.zip"
$LocalPath = "C:\DIAD\DIADMaterials.zip"
$Wget = New-Object System.Net.WebClient
$Wget.DownloadFile($Url, $LocalPath)

$shell = new-object -com shell.application
$zip = $shell.NameSpace(“C:\DIAD\DIADMaterials.zip”)
foreach($item in $zip.items())
{
$shell.Namespace(“C:\DIAD”).copyhere($item)
}
