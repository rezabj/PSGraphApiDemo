# Get all users
$AllUsers = Get-MgUser -All

# Get specific user
$User = Get-MgUser -UserId "e870951b-d2ce-41e8-b908-810a175e3110"
$User | Format-List

# Get specific user with specific properties
$User = Get-MgUser -UserId "e870951b-d2ce-41e8-b908-810a175e3110" -Property "UserPrincipalName,jobTitle"
$User | Format-List

# Create user
# Change permission to Directory.ReadWrite.All
$PasswordProfile = @{
  Password = 'HighlySecurePassword@35'
}

$Property = @{
  UserPrincipalName = "test.testovic@M365x39551604.OnMicrosoft.com"
  DisplayName = "Test Testovič"
  PasswordProfile = $PasswordProfile
  AccountEnabled = $true
  mailNickname = "test.testovic"
}
$User = New-MgUser @Property

# Update user
$Body = @{
  DisplayName = "Test Testovič 2"
  OfficeLocation = "Prague"
}
$Property = @{
  UserId = $User.Id
  Body = $Body
}
Update-MgUser @Property