function Get-AllSites {
  $AllSite = Get-MgAllSite

  $i = 1
  $done = $false
  while ($done -ne $true) {

    if ($i -eq 1) {
      $SubSites = $AllSite
    } else {
      $SubSites = $SubSiteLevel
      Remove-Variable -Name SubSiteLevel -ErrorAction SilentlyContinue
    }

    $i++
    $SubSiteLevel = @()
    foreach ($site in $SubSites) {
      $SubSiteLevel += Get-MgSubSite -SiteId $site.Id -All
    }

    if ($SubSiteLevel.Count -eq 0) {
      $done = $true
    } else {
      $AllSite += $SubSiteLevel
    }
  }
  return $AllSite
}


$AllSites = Get-AllSites