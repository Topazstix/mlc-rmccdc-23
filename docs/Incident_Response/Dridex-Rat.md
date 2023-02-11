# Dridex Rat

Created: 2023-02-05 14:37:33 -0700

Modified: 2023-02-05 17:49:05 -0700

---

Dridex is commonly distributed through malicious spam (malspam). Waves of this malspam usually occur at least two or three times a week. Some emails delivering Dridex contain Microsoft Office documents attached, while other emails contain links to download a malicious file.



The initial malicious file can be a Microsoft Office document with a malicious macro, or it could be a Windows executable (EXE) disguised as some sort of document. Either way, potential victims need to click their way to an infection from this initial file. The initial file retrieves a Dridex installer, although sometimes the initial file is itself a Dridex installer. The Dridex installer **[retrieves 64-bit Dridex DLL files over encrypted command and control (C2) network traffic]{.underline}**. Figures 5 and 6 show what we commonly see for infection chains of recent Dridex activity.





![](../media/Incident_Response-Dridex-Rat-image1.png){width="5.75in" height="7.75in"}



![](../media/Incident_Response-Dridex-Rat-image2.png){width="5.96875in" height="4.427083333333333in"}

Malware developers often use self-signed certificates for their C2 servers. Why? Because self-signed certificates are quick, easy and free to create. Furthermore, HTTPS C2 traffic for malware does not involve a web browser, so the encrypted traffic works without any errors or warnings.



Generating self-signed certificate involves entering values for the following fields (some of these are often left blank):



Country name (2 letter code).

State or province name.

Locality name (usually a city name).

Organization name.

Organizational unit name.

Common name (for example, fully qualified host name).

Email address.



These fields are used for subject data that identifies the website, but the same fields and values are also used for the issuer, since the certificate was generated locally on the web server itself.





id-at-countryName=Vu

id-at-stateOrProvinceName=Uererarnk4

id-at-localityName=Port Vila

id-at-organizationName=Whensean Imegdtc SICAV

id-at-organizationUnitName=6Tbuthinalq

id-at-commonName=1andfhtittbly.fan



Dridex certificate issuer fields frequently has random strings with a number or two sometimes thrown in. However, values for the country name and city or locality often match. In the above example, Vu is the 2-letter country code for Vanuatu, and Port Vila is the capital city of Vanuatu.



Do the same thing for HTTPS traffic to 212.95.153[.]36 and you should find:



id-at-countryName=AO

id-at-localityName=Luanda

id-at-organizationName=Msorest KGaA

id-at-organizationUnitName=aghat@yongd

id-at-commonName=arashrinwearc.Ourontizes.ly



We find the locality Luanda is the capital of Angola, which is country code AO. But the other fields appear to have random values. This type of certificate issuer data is a strong indicator of Dridex C2 traffic.







PREVENTATIVE MEASURES

values for the country name and city or locality often match:





Signatures:

truepenesonga[.]com

vardhmanproducts[.]com

Will have country name two letter and the capital of the country in locality name, or provinceName













References:

<https://www.malwarebytes.com/blog/news/2018/03/hancitor-fileless-attack-with-a-copy-trick>

*From <<https://unit42.paloaltonetworks.com/wireshark-tutorial-dridex-infection-traffic/>>*



NOTICE CONTAINS MALWARE:

<https://github.com/pan-unit42/wireshark-tutorial-Hancitor-traffic>

<https://github.com/pan-unit42/wireshark-tutorial-Dridex-traffic>


