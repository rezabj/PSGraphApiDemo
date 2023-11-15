$Drive = Get-MgUserDefaultDrive -UserId "admin@M365x39551604.OnMicrosoft.com"

$Drive = Get-MgUserDrive -UserId "admin@M365x39551604.OnMicrosoft.com"
$Root = Get-MgDriveRoot -DriveId $Drive.Id

$Children = Get-MgDriveItemChild -DriveId $Drive.Id -DriveItemId $Root.Id

$Item = Get-MgDriveItem -DriveId $Drive.Id -DriveItemId $Children[0].Id

$Permissions = Get-MgDriveItemPermission -DriveId $Drive.Id -DriveItemId $Children[0].Id