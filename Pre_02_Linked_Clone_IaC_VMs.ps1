## https://developer.vmware.com/docs/powercli/latest/vmware.vimautomation.core/commands/new-vm/#CloneVm
## https://vdc-repo.vmware.com/vmwb-repository/dcr-public/d402b7ed-b345-4fda-880d-a48e8885e910/b6ff10a7-3769-4346-8a83-d92d99d6caf3/doc/New-VM.html

Get-ExecutionPolicy -List
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Get-ExecutionPolicy -List


Install-Module -Name VMware.PowerCLI
Get-Module -Name VMware.PowerCLI -ListAvailable

Set-PowerCLIConfiguration -InvalidCertificateAction Ignore -Confirm:$false
Connect-VIServer -Server 200.200.200.251 -Protocol https -User administrator@vsphere.kh -Password VMware1!


## VM목록 파일에서 변수로 읽어오고자 한다면? 
## https://stackoverflow.com/questions/33511772/read-file-line-by-line-in-powershell 



$ParentFolder = "Students"
$TemplateVM = "Temp-Win2019"
$LinkedSnapshot = "IaC"
## $datastores =  'Local-250', 'Local-246', 'Local-247', 'Local-248', 'Local-249'
$hosts = '200.200.200.250', '200.200.200.246', '200.200.200.247', '200.200.200.248', '200.200.200.249' 


$count=0..26
foreach ($i in $count)
{ 
  $StudentID="S" + "{0:d2}" -f $i
  $rotate_order = $i % $hosts.count
  New-Folder -Name $StudentID -Location $ParentFolder
  New-VM -Name $StudentID"-IaC" -VM $TemplateVM -LinkedClone -ReferenceSnapshot $LinkedSnapshot -Location $StudentID -Datastore "vsanDatastore" -VMHost $hosts[$rotate_order]
 }
