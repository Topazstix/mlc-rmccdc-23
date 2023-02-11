# Configuration Notes

Created: 2023-02-09 16:13:50 -0700

Modified: 2023-02-09 16:14:07 -0700

---

Since the acquisition, some administrator accounts exist in LDAP, and other accounts exist in RADIUS.

With administrator accounts in these two different systems, you need to configure the firewall so that

it can check both external databases when an administrator attempts to log in.

In this section, you will accomplish this by creating an Authentication Sequence. The sequence will

instruct the firewall to check an account against LDAP first and then against RADIUS if the account does

not exist in LDAP (or if the LDAP server is unavailable).
