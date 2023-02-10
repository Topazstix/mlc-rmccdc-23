# Active Directory Management

* Powershell commands are not case sensitive!

## View all active directory commands
```powershell
Get-Command -Module ActiveDirectory
```

## Disable SMB
```powershell
Disable-WindowsOptionalFeature -Online -FeatureNameSMB1Protocol
```

## Display basic domain information
```powershell
Get-ADDomain
```

## Get all domain controllers by hostname and operating system
```powershell
Get-ADDomainController -filter * | select hostname,operatingsystem
```

## Get all fine grained password policies
```powershell
Get-ADFineGrainedPasswordPolicy -filter *
```

## Get domain default password policy
##### Gets the password policy from the domain you are logged into
```powershell
Get-ADDefaultDomainPasswordPolicy
```

## Backup active directory system state remotely
##### This will back up the domain controllers system state data. Change DC-Name to your server name and change the Backup-Path. The backup path can be a local disk or a UNC path

```powershell
invoke-command -ComputerName DC-Name -scriptblock {wbadmin start systemstateback up -backupTarget:"Backup-Path" -quiet}
```

---

<br><br>

# Active Directory User Management

## Get user and list all properties (attributes)
```powershell
Get-ADUser username -Properties *
```

## Get user and list specific properties
```powershell
Get-ADUser username -Properties * | Select name, department, title
```

## Get all active directory users in domain
```powershell
Get-ADUser -Filter *
```

## Get all users from a specific OU (Organizational Unit)
##### "OU=" is the distinguished path of the OU
##### * Change the "OU=,DC=,DC=" values to the relevant values for your search
```powershell
Get-ADUser -SearchBase "OU=ADPRO Users,DC=ad,DC=activedirectorypro.com" -Filter *
```

## Get AD users by name
##### This accepts wildcard's as "*"
```powershell
Get-ADUser -Filter {name -like "*robert*"}
```

## Get all disabled user accounts
```powershell
Search-ADAccount -AccountDisabled | select name
```

## Disable user account
```powershell
Disable-ADAccount -Identity rallen
```

## Enable user account
```powershell
Enable-ADAccount -Identity rallen
```

## Get all accounts with password set to never expire
```powershell
get-aduser -filter * -properties Name, PasswordNeverExpires | where {$_.passwordNeverExpires -eq "true" } | Select-Object DistinguishedName,Name,Enabled
```

## Find all locked user accounts
```powershell
Search-ADAccount -LockedOut
```

## Unlock user account
```powershell
Unlock-ADAccount -Identity john.smith
```

## List all disabled user accounts
```powershell
Search-ADAccount -AccountDisabled
```

## Force password change at next login for user
```powershell
Set-ADUser -Identity username -ChangePasswordAtLogon $true
```

## Move a user to a new OU
##### You will need the distinguished name of the user and the target OU
```powershell
Move-ADObject -Identity "CN=Test User (0001),OU=ADPRO Users,DC=ad,DC=activedirectorypro,DC=com" -TargetPath "OU=HR,OU=ADPRO Users,DC=ad,DC=activedirectorypro,DC=com"
```
<!-- This section requires more detail -->
## Move users to an OU from a CSV
##### Setup a CSV with a name field and a list of the users SAM Account Names, then change the target OU path
```powershell
# Specify target OU. $TargetOU = "OU=HR,OU=ADPRO Users,DC=ad,DC=activedirectorypro,DC=com" # Read user sAMAccountNames from csv file (field labeled "Name"). Import-Csv -Path Users.csv | ForEach-Object { # Retrieve DN of User. $UserDN = (Get-ADUser -Identity $_.Name).distinguishedName # Move user to target OU. Move-ADObject -Identity $UserDN -TargetPath $TargetOU }
```

### view an active session with a machine
```powershell
net session
```

---

<br><br>

# Active Directory Group Management

## Get all members of a security group
```powershell
Get-ADGroupMember -Identity "HR Full"
```

## Get all security groups
```powershell
Get-ADGroup -Filter *
```

## Add user to a group
##### Change "group-name" to the group you'd like to add users to
```powershell
Add-ADGroupMember -Identity group-name -Members User1, User2
```

## Export users from a group
##### This will export group members to a CSV file
```powershell
Get-ADGroupMember -identity “Group-name” | select name | Export-csv -path "C:\OutputGroupmembers.csv" -NoTypeInformation
```

## Get groups by keyword
##### Helpful if you are not sure the group name
```powershell
get-adgroup -filter * | Where-Object {$_.name -like "*group-name*"}
```

## Import a list of users to a group
##### Change the "C:\" path to match the path to the csv file
```powershell
$members = Import-CSV "C:\Path\to\CSVfile.csv" | Select-Object -ExpandProperty samaccountname Add-ADGroupMember -Identity hr-n-drive-rw -Members $members
```

---

<br><br>

# Active Directory Computer Management

## Get all computers in domain
```powershell
Get-ADComputer -Filter *
```

## Get all computers by name
```powershell
Get-ADComputer -Filter * | select name
```

## Get all computers from an OU
```powershell
Get-ADComputer -SearchBase "OU=DN" -Filter *
```

## Get a count of all computers
```powershell
Get-ADComputer -filter * | measure
```

## Get all windows 10 computers
##### This can be changed to search for any operating systems within the domain, simply change "Windows 10" to "Linux" or other systems
```powershell
Get-ADComputer -filter {OperatingSystem -Like '*Windows 10*'} -property * | select name, operatingsystem
```

## Get a count of all computers by operating system
##### This will provide a count of all computers and group them by the operating system. A great command to give you a quick inventory of computers in AD.
```powershell
Get-ADComputer -Filter "name -like '*'" -Properties operatingSystem | group -Property operatingSystem | Select Name,Count
```

## Delete a single computer
```powershell
Remove-ADComputer -Identity "USER04-SRV4"
```

## Delete a list of computer accounts
##### Add computer hostnames to a text file and change the path to the location of that file
```powershell
Get-Content -Path "C:\Path\to\ComputerList.txt" | Remove-ADComputer
```

## Delete computers from an OU
```powershell
Get-ADComputer -SearchBase "OU=DN" -Filter * | Remote-ADComputer
```

---

<br><br>

# Active Directory Group Policy Management

## Get all GPO (Group Policy Object) related commads
```powershell
Get-Command -Module grouppolicy
```

## Get all GPOs by status
```powershell
Get-GPO -all | select DisplayName, gpostatus
```

## Backup all GPOs in the domain
```powershell
Backup-GPO -All -Path "D:\path\to\GPObackup"
```

---

<br><br>

# Office 365 Powershell Commands

## Connect to exchange online
##### This will produce a popup asking for credentials to Microsoft Account services
```powershell
$UserCredential = Get-Credential $Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.outlook.com/powershell/ -Credential $LiveCred -Authentication Basic -AllowRedirection Import-PSSession $Session
```

## Force Azure sync
```powershell
Start-ADSyncSyncCycle -PolicyType Initial
```
#### Force Azure delta sync (only changes since last)
```powershell
Start-ADSyncSyncCycle -PolicyType Delta
```

## Get a list of all Office 365 users
```powershell
Get-MsolUser | Select DisplayName, City, Department, ObjectID
```
<!-- Needs clarification -->
## Get full mailbox details
```powershell
Get-Mailbox email-address | fl
```

## Get calendar permissions
```powershell
Get-MailboxFolderPermission username:calendar
```

## Enable remote mailbox (hybrid environment)
##### Use this command if you have an existing on-premise user that needs an Office 365 mailbox. This creates all the appropriate attributes in the AD tree
##### * Replace username and tenant fields
```powershell
Enable-RemoteMailbox username -RemoteRoutingAddress "username@tenant.mail.onmicrosoft.com"
```

---
<br><br>

# Windows Server & Client Commands

## Get all services
```powershell
Get-Service
```

## Get all processes
```powershell
Get-Process
```

## Display network adapters
```powershell
Get-NetAdapter
```

## Restart remote computers
```powershell
Restart-Computer -ComputerName "Server01", "Server02", "localhost"
```
<!-- Needs clarification, states multiple lines, was only one line. this was condensed to what i believe was the intended commands -->
## Get last boot time
```powershell
$os = Get-WmiObject win32_operatingsystem 
$uptime = (Get-Date) - $os.ConvertToDateTime($os.LastBootUpTime) 
Write-Output ("Last boot: " + $os.ConvertToDateTime($os.LastBootUpTime))
```

#### OR
```powershell
systeminfo | more
```
<!-- Needs clarification on the computername field -->
## Start a remote powershell sessions
```powershell
Enter-PSSession -ComputerName "USER01-WIN"
```

## Read the content of a file (Similar to cat in linux)
```powershell
Get-Content -Path "c:\windows\system32\logfiles\firewallp\firewall.log"
```

## Copy files and folders
##### The options shown are for recursive directory copy, change to a singular file and destination for moving one item, can use wildcard to match patterns and copy based from that
```powershell
Copy-Item "E:\WindowsImageBackup\exchange" -destination \\server1\Backups\Exchange -recurse -verbose
```

---

<br><br>

# Basic Powershell Commands

## Get execution policy
```powershell
Get-ExecutionPolicy
```

## Set execution policy to unrestricted
##### Requires administrator rights
```powershell
Set-ExecutionPolicy unrestricted
```

## Show powershell version
```powershell
$PSVersionTable
```

## Get help for a specific command
```powershell
Get-Help command-name
```

#### Searching the help menu
```powershell
Get-Help *keyword*
```

## Get installed modules
```powershell
Get-InstalledModule
```

## List all available modules
```powershell
Get-Module -ListAvailable
```

## Export results of any command to a CSV file
```powershell
Get-ADUser username -Properties * | Select name, department, title | export-csv "c:\users.csv"
```

## Display available commands
```powershell
Get-Command
```

## Find new modules
```powershell
Find-Module *ntfs*
```

## Install a new modules
##### [Modules can be found here](https://www.powershellgallery.com/)
```powershell
Install-Module ModuleName
```
