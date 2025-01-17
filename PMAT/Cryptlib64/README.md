<picture align="center">
  <source media="(prefers-color-scheme: dark)" srcset="https://github.com/Erzeng3l/Malware-Research/blob/main/Logo-dark.png">
  <source media="(prefers-color-scheme: light)" srcset="https://github.com/Erzeng3l/Malware-Research/blob/main/Logo-light.png">
  <img alt="logo" src="Logo-light.png" height="350">
</picture>

# Cryptlib64
Nov. 30 2023 | 3rzeng3l | v1.0

### Table of Contents
- [Table of Contents](#table-of-contents)
  - [Executive Summary](#executive-summary)
  - [High-Level Summary](#high-level-summary)
  - [Malware Compromise](#malware-compromise)
    - [embed.xml](#embedxml)
    - [embed.vbs](#embedvbs)
  - [Basic Static Analysis](#basic-static-analysis)
    - [Mitre Att&ck](#mitre-attck)
  - [Basic Dynamic Analysis](#basic-dynamic-analysis)
  - [Advanced Static Analysis](#advanced-static-analysis)
  - [Advanced Dynamic Analysis](#advanced-dynamic-analysis)
  - [Indicators of Compromise](#indicators-of-compromise)
    - [Network Indicators](#network-indicators)
    - [Host-based Indicators](#host-based-indicators)
  - [Rules \& Signatures](#rules--signatures)
  - [Appendices](#appendices)
    <ol type="A">
    <li>
    <a href="#a-yara-rules">
    <span class="title">YARA Rules</span>
    </a>
    </li>
    <li>
    <a href="#b-callback-urls">
    <span class="title">Callback URLs</span>
       </a>
    </li>
    <li>
    <a href="#c-decompiled-code-snippets">
    <span class="title">Decompiled Code Snippets</span>
       </a>
    </li>
    </ol>

### Executive Summary
<table>
  <tr>
  <td>SHA256</td><td>732F235784CD2A40C82847B4700FB73175221C6AE6C5F7200A3F43F209989387</td></td>
  </tr>
</table>

<p>EmbedDLL is composed of a 64-bit script that sets up two payloads. The sample our team was able to recover was titled 'embed.xml' and 'embed.vbs,' which were then executed when interacting with the DLL.Upon execution, EmbedDLL loads itself into the system's memory, initiating the deployment of two distinct payloads. Notable symptoms of infection include sporadic beaconing activities to various URLs outlined in Appendix B. Additionally, indicators of compromise involve data theft, alongside the creation of "embed.vbs" and "embed.xml" files within the C:/Users/Public directory.</p>
<p>YARA signature rules are attached in Appendix A. Malware sample and hashes have been submitted to VirusTotal for further examination.</p>

### High-Level Summary

<p>EmbedDLL consists of one component: an encrypted dropper that loads a VBS script into the registry. Upon login, it establishes communication with its callback DNS server (src[.]masterchiefsgruntemporium[.]local)</p>
<img src="./Pics/diagram.png" align="center">

### Malware Compromise


<table>
  <tr><th>File Name</th><th>SHA256 Hash</th></tr>
  <tr><td>embed.xml</td><td>F1548CD02784606C8ABAC865ABF5ED6220D34EEA88C7A5715E0183D7F050F4AB</td></tr>
  <tr><td>embed.vbs</td><td>66FD543F31545082CF8FCC45A6AB1094BC118C45634F2BE450F84F4E5745B291</td></tr>
</table>

#### embed.xml

<img src="./Pics/embedxmlcompromise.png" align="center">

*Fig 1: Embed.xml*

#### embed.vbs

<img src="./Pics/embedvbscompromise.png" align="center">

*Fig 2: Embed.vbs*

### Basic Static Analysis

<img src="./Pics/DIE.png" align="center">

At this time of this report, 11 security vendors has flagged this as malicious.

<img src="./Pics/virustotal.png" align="center">

*Virus Total*

Original File name of this is EmbedDLL.dll, copyrighted in 2021 in Unicode UTF-16 little endian. 

<img src="./Pics/PEStudio.png" align="center">

*PEStudio View*

<img src="./Pics/PEStudio-indicators.png" align="center">

There's 3 groups that has been found reconnaissance, memory and cryptography.

<img src="./Pics/pestudio-imports.png" align="center">

*PEStudio Imports*

<img src="./Pics/pestudio-imports.png" align="center">

<img src="./Pics/PEStudio-net1.png" align="center">

<img src="./Pics/PEStudio-net2.png" align="center">

#### Mitre Att&ck
These attack pattern can be mapped on MITRE ATT&CK framework as,

- Defense Evasion
<p>Technique: Obfuscated Files or Information (T1027)</p>
<p>Description: Adversaries may attempt to make an executable or file difficult to discover or analyze by encrypting, encoding, or otherwise obfuscating its contents on the system or in transit. This is common behavior that can be used across different platforms and the network to evade defenses.</p>

- Discovery
<p>Technique: System Information Discovery (T1082)</p>
<p>Description: An adversary may attempt to get detailed information about the operating system and hardware, including version, patches, hotfixes, service packs, and architecture. Adversaries may use the information from System Information Discovery during automated discovery to shape follow-on behaviors, including whether or not the adversary fully infects the target and/or attempts specific actions.</p>

### Basic Dynamic Analysis

<p>Writes Files on to disk, the first payload setups up a .vbs and a .xml files.</p>

<img src="./Pics/embedfilecreate.png" align="center">

*File create*

<p>Incorporating a degree of persistence ensures that the system automatically restarts even in the event of a computer reboot.</p>

<img src="./Pics/persistenthandler.png" align="center">

*persistent handler*

<p>With all the gathered information of the system, it saves a config file of the system. Then enables FipsAlgorithomPolicy.</p>

<img src="./Pics/machineconfig.png" align="center">

*machine.conf file created*

<p>Caught and IP Address try to send and receive data from the system.</p>

<img src="./Pics/sendandreceive.png" align="center">

*ssdp UDP traffic*


### Advanced Static Analysis

<p>The process involves embedding the DLL file 'EmbedDLL.dll,' reading its content to a string, converting it from Base64 encoding using 'FromBase64String,' retrieving environment variables with 'GetEnvironmentVariable,' and subsequently writing the content to a file using 'WriteAllText.</p>

<img src="./Pics/advstatic1.png" align="center">

*Writes everything to string*

### Advanced Dynamic Analysis

<img src="./Pics/advdynamic1.png" align="center">

<img src="./Pics/getwindowsdirectoryw.png" align="center">

### Indicators of Compromise
A full set of IOCs can be found in the Appendix. 

#### Network Indicators
<img src="./Pics/networktraffic.png" align="center">
*Master Chiefs Grunt Emporium*

 <p>It sets up a session with getting /en-us/doc.html</p>
 
<img src="./Pics/dochtml.png" align="center">

*request docs.html*

<img src="./Pics/wireshark1.png" align="center">

*ssdp: discover*

#### Host-based Indicators
A trademark of this infection is the 'embed.xml' and 'embed.vbs' file located in C:\\Users\\Public

<img src="./Pics/embedxml.png" align="center">

<p>*Fig 3: embed.xml*</p>

<img src="./Pics/embedvbs.png" align="center">

<p>*fig 4: embed.vbs*</p>

### Rules & Signatures
A full set of YARA rules is included in Appendix A.

### Appendices

#### A. Yara Rules
```yara
rule EmbedDLL_C2 {

    meta:
        last_updated = "2023-10-06"
        author = "3rzeng3l"
        description = "EmbedDLL is a C2 grunt agent dll to gather information from the system and sends it to a server"

    strings:
        //Fill out identifying strings and other criteria
        $string1 = "EmbedDLL" ascii
        $string2 = "mscoree.dll"
        $string3 = "p0w3r0verwh3lm1ng!"
        $PE_magic_byte = "MZ"
        $sus_guid_string = "2eab5b3e-db27-4823-8690-150bb182b16b"
    condition:
        // Fill out the conditions that must be met to identify the binary
        $PE_magic_byte at 0 and
        ($string1 and $string2 and $string3) or
        
        $sus_guid_string

}
```
#### B. Callback URLs
<table>
  <tr><th>Domain</th><th>Port</th></tr>
  <tr><td>src[.]masterchiefsgruntemporium[.]local</td><td>53, 80</td></tr>
  <tr><td>239[.]255[.]255[.]250</td><td>1900</td></tr>
</table>

#### C. Decompiled Code Snippets
<img src="./Pics/gruntemporiumlocal.png" align="center">

