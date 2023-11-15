Import-Module Microsoft.Graph.Users.Actions
$Subject = "Test Mail Subject"
$Body = @{
  ContentType = "HTML"
  Content = "Test Mail Body"
}
$ToRecipients = @(
	@{ EmailAddress = @{ address = "ChristieC@M365x39551604.OnMicrosoft.com" }}
  @{ EmailAddress = @{ address = "GradyA@M365x39551604.OnMicrosoft.com" }}
  @{ EmailAddress = @{ address = "jan.rezab@seyfor.com" }}
)
$CcRecipients = @(
  @{ EmailAddress = @{ address = "IsaiahL@M365x39551604.OnMicrosoft.com"}}
)
#Attachments
# If over ~3MB: https://docs.microsoft.com/en-us/graph/outlook-large-attachments?tabs=http
$AttachmentPath = 'test.docx'
$AttachmentContent = Get-Content $AttachmentPath -AsByteStream -Raw
$EncodedAttachment = [convert]::ToBase64String($AttachmentContent) 
$Attachments = @(
    @{
      "@odata.type"= "#microsoft.graph.fileAttachment"
      name = ($AttachmentPath -split '\\')[-1]
      ContentType = "text/plain"
      contentBytes = $EncodedAttachment
    }
)

$params = @{
	message = @{
		Subject = $Subject
		Body = $Body
		ToRecipients = $ToRecipients
		CcRecipients = $CcRecipients
    Attachments = $Attachments
	}
	SaveToSentItems = "true"
}
# A UPN can also be used as -UserId.
Send-MgUserMail -UserId "admin@M365x39551604.OnMicrosoft.com" -BodyParameter $params

$M = New-MgUserMessage -UserId "admin@M365x39551604.OnMicrosoft.com" -Attachments $Attachments -Body $Body -CcRecipients $CcRecipients -ToRecipients $ToRecipients -Subject "TEST2"
Send-MgUserMessage -UserId "admin@M365x39551604.OnMicrosoft.com" -MessageId $M.Id