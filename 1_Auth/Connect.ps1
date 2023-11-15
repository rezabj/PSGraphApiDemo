Import-Module -Module Microsoft.Graph.Authentication

# Connect as delegated user (interactive) / use standard enterprise app
Connect-MgGraph -Scopes Mail.Send

# Connect as delegated user (interactive) / use custom registred app
# Set redirect URI to http://localhost (default) 
# https://learn.microsoft.com/en-us/powershell/microsoftgraph/authentication-commands?view=graph-powershell-1.0#use-delegated-access-with-a-custom-application-for-microsoft-graph-powershell
Connect-MgGraph -Scopes "User.Read" -ClientId "bf573f00-fb26-440d-8f9e-62b7c32cdb51" -TenantId "4d8f7ec8-7ebb-46e5-b7ee-ed2cac927374" -

# Connect as delegated user (interactive) / use device code authentication
# Usefull for Windows Core or Linux
Connect-MgGraph -Scopes "User.Read" -UseDeviceCode

# Connect as application (non-interactive) / use client secret
# Add secret to app registration
$Credential = Get-Credential -Credential "93cf2199-a118-4d82-ba63-dd6de764b665"
Connect-MgGraph -TenantId "4d8f7ec8-7ebb-46e5-b7ee-ed2cac927374" -ClientSecretCredential $Credential

# Connect as application (non-interactive) / use certificate
# Create certificate
$Cert = New-SelfSignedCertificate -Type Custom -Subject "CN=Script account" -TextExtension @("2.5.29.37={text}1.3.6.1.5.5.7.3.2,1.3.6.1.5.5.7.3.1") -CertStoreLocation "Cert:\CurrentUser\My\" -HashAlgorithm sha256 -KeySpec Signature
$CertPassword = ConvertTo-SecureString -String "MyPassword" -Force -AsPlainText
$thumbprint = $Cert.Thumbprint
$Cert | Export-PfxCertificate -FilePath .\cert.pfx -Password $CertPassword
Get-ChildItem -Path .\cert.pfx | Import-PfxCertificate -CertStoreLocation "Cert:\CurrentUser\My\" -Password $CertPassword 
$Cert | Export-Certificate -FilePath cert.cer
# Add certificate to app registration
Connect-MgGraph -TenantId "4d8f7ec8-7ebb-46e5-b7ee-ed2cac927374" -ClientId "93cf2199-a118-4d82-ba63-dd6de764b665" -CertificateThumbprint $thumbprint
