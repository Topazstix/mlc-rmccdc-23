# Hardening Checklist & Steps

Created: 2023-02-04 17:33:55 -0700

Modified: 2023-02-09 03:12:32 -0700

---

[Create New Admin Account:]{.underline}


-   Create new admin based off default admin -> then disable default Admin and guest



[Reset Default Passwords for AD users Accounts:]{.underline}


-   



[Reset Local Admin Passwords:]{.underline}


-   Net user <user> <pass>



[Enable Host Based Firewalls:]{.underline}


-   Wf.msc > Rclick Windows Defender Firewall with Advanced Security on Local Computer > properties > on



[Disable SMB v1:]{.underline}


-   [Disable-WindowsOptionalFeature -Online -FeatureNameSMB1Protocol]{.mark}
    -   [Is the above a plain pwsh cmd or is it a `dism` command?]{.mark}
-   Or in AD feature install thing



[Configure Audit Policy:]{.underline}
-   Search Group Policy Management


-   Domains -> Server -> Group Policy Objects -> edit Default Domain Policy
    -   Computer Configuration -> Policies -> Windows Settings -> security Settings -> Advanced Audit Policy Configuration -> Audit Policies


-   Account Logon
    -   Audit Credential Validation Properties -> failure
    -   Audit Other Account Logon Events Properties -> success & failure


-   Account Management
    -   Audit other account management Events Properties -> success & failure
    -   Audit security group management properties -> success & failure
    -   Audit User Account Management Properties -> success & failure


-   Logon/logoff
    -   Audit Account Lockout -> success & failure
    -   Audit logoff -> success & failure
    -   Audit logon -> Failure
        -   [This definitely should be both S&F so we know when]{.mark}
    -   Audit other logon/log off events -> success & failure
    -   Audit special logon properties -> success and failure
        -   Iirc the above two policies can both produce a *lot* of events


-   Object Access
    -   Audit kernel object -> success and failure
    -   Audit other object access events -> success and failure
        -   I'm not currently at my laptop, but iirc, the "explanation" for this policy says that it can produce a *lot* of events... I don't remember them being particularly important either, so I'm wondering if we need to audit successes here
    -   Audit registry -> success and failure
    -   [Audit SAM -> Failure]{.mark}
        -   [I'd suggest auditing both Fails and Success b/c mimikatz works primarily on the SAM and we need to know it has been successfully accessed]{.mark}


-   Policy Change
    -   Audit audit policy change -> success and failure
    -   Audit authentication policy change -> success and failure
    -   Audit authorization policy change properties -> success and failure
    -   Audit other policy change events -> success & failure
        -   We want to audit all policy change @s&f, but preferably configure this last given that it will make a lot of even


-   Privilege Use
    -   Audit non sensitive privilege use -> success and failure
        -   This produces an imense volume of events
    -   Audit other privilege use events -> success and failure
    -   Audit sensitive privilege use properties -> success and failure


-   System
    -   Audit other system events properties -> success and failure
    -   Audit security system extension properties -> success and failure
    -   Audit system integrity properties -> failure



Useful Commands:


-   Netstat -nao
    -   Show all TCP & UDP port usage and PID
    -   I also like
-   Netstat --s --p [TCP|UDP|IP|ICMP]
    -   Dump detailed protocol statistics


-   Lusrmgr.msc (opens GUI view for local users)
    -   Net user
    -   Net user localgroup administrators


-   Net session
    -   Shows who has an open session with the machine



![](../media/Windows-Hardening-Checklist-&-Steps-image1.png){width="0.22916666666666666in" height="0.25in"}

