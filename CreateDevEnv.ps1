
# Updatehosts may require administrator permissions

$mylicense = "c:\Navision\DC Nav 2018 withISV rights.flf"
$imageName = "microsoft/dynamics-nav:2018"
$sourceFolder = Join-Path $PSScriptRoot "Source"
$containerName = Split-Path $PSScriptRoot -Leaf

New-NavContainer -accept_eula `
                 -containerName $containerName `
                 -imageName $imageName `
                 -memoryLimit 3G `
                 -auth Windows `
                 -licensefile $mylicense `
                 -updateHosts `
                 -includeCSide `
                 -additionalParameters @("--volume ${sourceFolder}:c:\source",
                                         #"--volume ${addInsFolder}:c:\run\Add-Ins",
                                         #"--env CustomNavSettings=EnableTaskScheduler=true"
                                         "-e locale=en-GB") 

Import-DeltasToNavContainer -containerName $containerName -deltaFolder $sourceFolder -compile

