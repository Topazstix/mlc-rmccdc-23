# Hardening Checklist & Steps

Created: 2023-02-04 18:25:19 -0700

Modified: 2023-02-05 13:10:36 -0700

---

1.  Keep the system and software up to date:
    -   Regularly check for available updates and upgrades, both for the operating system and any installed applications.
    -   Use a package manager or repository to automatically apply security patches and bug fixes.
    -   Consider using a tool like yum-cron or apticron to automate the process of checking and applying updates.

```{=html}
<!-- -->
```
2.  Use strong passwords:
    -   Set strong, complex passwords for all user accounts, including the root account.
    -   Enable password aging policies to encourage users to change their passwords regularly.
    -   Consider using a tool like pam_cracklib to enforce password policies, such as length and complexity requirements.

3.  Disable unnecessary services:
    -   Identify any services that are not required for your system, such as unused network protocols, and disable or remove them.
    -   For services that are required, ensure that they are properly secured and configured to minimize attack surfaces.
    -   Consider using a tool like chkconfig to manage the startup status of services.

4.  Configure firewall rules:
    -   Use a firewall, such as iptables or firewalld, to restrict incoming and outgoing network traffic to only what is necessary.
    -   Configure the firewall to block incoming traffic to any services that are not required.
    -   Enable logging of firewall activity to assist with intrusion detection and response.

5.  Enable logging:
    -   Enable logging for critical system components, such as the Linux kernel, system services, and applications.
    -   Configure log rotation policies to ensure that logs do not consume too much disk space.
    -   Use a centralized log management tool, such as rsyslog or syslog-ng, to collect and analyze logs from multiple sources.

6.  Use SSL/TLS certificates:
    -   Use SSL/TLS certificates to encrypt network communications for sensitive services, such as web servers, email servers, and database servers.
    -   Consider using a certificate authority (CA) to issue and manage SSL/TLS certificates, or use a tool like Let's Encrypt to obtain free, automated SSL/TLS certificates.
    -   Regularly check SSL/TLS certificates to ensure that they are valid and have not been revoked.

7.  Configure SELinux or AppArmor:
    -   Use SELinux or AppArmor to enforce security policies and prevent unauthorized access to system resources.
    -   Configure policies to restrict the permissions of applications and services, and define what actions they are allowed to perform.
    -   Regularly review SELinux or AppArmor logs to detect and respond to policy violations.

8.  Limit user privileges:
    -   Limit the privileges of individual users to the minimum necessary to perform their tasks.
    -   Use tools like sudo or pfexec to allow users to temporarily escalate their privileges for specific tasks.
    -   Consider using role-based access control (RBAC) to manage the permissions of large groups of users.

9.  Use intrusion detection and prevention systems:
    -   Implement an intrusion detection and prevention system (IDS/IPS) to monitor network traffic and detect malicious activity.
    -   Consider using a host-based IDS/IPS, such as OSSEC, to detect and respond to intrusions on individual systems.
    -   Use network-based IDS/IPS, such as Snort, to detect and respond to intrusions at the network level.

10. Regularly backup data:
    -   Regularly back up critical



The magi named Beans


