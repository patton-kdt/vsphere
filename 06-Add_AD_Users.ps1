## 파일을 다운로드하여 실행할 경우, Powershell의 실행 정책 설정을 확인해 주시길 바랍니다. 
## Get-ExecutionPolicy
## Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
## Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope LocalMachine


## AD 모듈 설치 
Import-Module ActiveDirectory

## 주요 변수 설정 
$dcpath="DC=vclass,DC=local"
$ou="Student"
$groupname="Students"
$oupath="OU=" + $ou + "," + $dcpath

## OU 만들기 
New-ADOrganizationalUnit -Name $ou -Path $dcpath

## 생성된 OU를 삭제하고자 할 경우, 삭제 방지설정을 해제해야 함. 
## Get-ADOrganizationalUnit -Identity $oupath | Set-ADObject -ProtectedFromAccidentalDeletion:$false -PassThru | Remove-ADOrganizationalUnit -Confirm:$false 

## 생성된 OU내에 보안그룹 생성 
New-ADGroup -Name $groupname -GroupCategory Security -GroupScope Global -DisplayName $groupname -Path $oupath 

## AD 사용자를, OU내에 생성 + 그룹에 등록 
$count=0..10
foreach ($i in $count)
{ 
  $username="S" + "{0:d2}" -f $i
  New-AdUser -Name $username -Path $oupath -Enabled $True -AccountPassword (ConvertTo-SecureString "VMware1!" -AsPlainText -force) -passThru  -PasswordNeverExpires 1 
  Add-ADGroupMember -Identity $groupname -Members $username
 }