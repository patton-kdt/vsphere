## https://docs.microsoft.com/en-us/powershell/module/activedirectory/?view=windowsserver2022-ps 
Import-Module ActiveDirectory

## https://docs.microsoft.com/en-us/powershell/module/activedirectory/new-aduser?view=windowsserver2022-ps 

$dcpath="DC=vclass,DC=kh"
$ou="Student"
New-ADOrganizationalUnit -Name $ou -Path $dcpath

$oupath="OU=Student,DC=vclass,DC=kh"
## Get-ADOrganizationalUnit -Identity $oupath | Set-ADObject -ProtectedFromAccidentalDeletion:$false -PassThru | Remove-ADOrganizationalUnit -Confirm:$false

$groupname="Students"
New-ADGroup -Name $groupname -GroupCategory Security -GroupScope Global -DisplayName "Students" -Path $oupath

$count=0..26
foreach ($i in $count)
{ 
  $username="S" + "{0:d2}" -f $i
  New-AdUser -Name $username -Path $oupath -Enabled $True -AccountPassword (ConvertTo-SecureString "VMware1!" -AsPlainText -force) -passThru -PasswordNeverExpires 1
  Add-ADGroupMember -Identity $groupname -Members $username
 }
