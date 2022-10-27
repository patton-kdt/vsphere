## https://developer.vmware.com/docs/powercli/latest/vmware.vimautomation.core/commands/new-vm/#CloneVm 
## https://vdc-repo.vmware.com/vmwb-repository/dcr-public/d402b7ed-b345-4fda-880d-a48e8885e910/b6ff10a7-3769-4346-8a83-d92d99d6caf3/doc/New-VM.html 

Get-ExecutionPolicy -List
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Get-ExecutionPolicy -List


Install-Module -Name VMware.PowerCLI
Get-Module -Name VMware.PowerCLI -ListAvailable

Set-PowerCLIConfiguration -InvalidCertificateAction Ignore -Confirm:$false
Connect-VIServer -Server 172.0.10.10 -Protocol https -User administrator@vsphere.local -Password VMware1!


$ParentFolder = "Students"
$TemplateVM = "Temp-KH-IaC"
## $LinkedSnapshot = "IaC"
$datastores =  'Local-172.0.10.13', 'Local-172.0.10.11', 'Local-172.0.10.12'
$hosts = '172.0.10.13', '172.0.10.11', '172.0.10.12'


$count=0..11
foreach ($i in $count)
{ 
  $StudentID="S" + "{0:d2}" -f $i
  $rotate_order = $i % $hosts.count
  New-Folder -Name $StudentID -Location $ParentFolder
  New-VM -Name $StudentID"-IaC" -VM $TemplateVM -Location $StudentID -Datastore $datastores[$rotate_order] -VMHost $hosts[$rotate_order]
 }
