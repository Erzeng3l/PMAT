<picture align="center">
  <source media="(prefers-color-scheme: dark)" srcset="https://github.com/Erzeng3l/Malware-Research/blob/main/Logo-dark.png">
  <source media="(prefers-color-scheme: light)" srcset="https://github.com/Erzeng3l/Malware-Research/blob/main/Logo-light.png">
  <img alt="logo" src="Logo-light.png" height="350">
</picture>

# WannaCry
Date | 3rzeng3l | v1.0

### Table of Contents
- [Table of Contents](#table-of-contents)
  - [Executive Summary](#executive-summary)
  - [High-Level Summary](#high-level-summary)
  - [Malware Compromise](#malware-compromise)
    - [](#)
  - [Basic Static Analysis](#basic-static-analysis)
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
  <td>SHA256</td><td></td></td>
  </tr>
</table>

### High-Level Summary


### Malware Compromise
<table>
  <tr><th>File Name</th><th>SHA256 Hash</th></tr>
  <tr><td>cell</td><td>cell</td></tr>
</table>

### Basic Static Analysis


### Basic Dynamic Analysis


### Advanced Static Analysis


### Advanced Dynamic Analysis


### Indicators of Compromise
A full set of IOCs can be found in the Appendix. 

#### Network Indicators


#### Host-based Indicators


### Rules & Signatures
A full set of YARA rules is included in Appendix A.

### Appendices


#### A. Yara Rules
```yara
rule Yara_example {

    meta:
        last_updated =
        author =
        description =

    strings:
        //Fill out identifying strings and other criteria
        $string1 = ""
    ascii
        $string2 = ""
        $PE_magic_byte = ""
        $sus_hex_string = ""
    condition:
        // Fill out the conditions that must be met to identify the binary
        $PE_magic_byte at 0 and
        ($string1 and $string2) or
        
        $sus_hex_string


}
```
#### B. Callback URLs
<table>
  <tr><th>Domain</th><th>Port</th></tr>
  <tr><td>callback</td><td>Port number</td></tr>
</table>

#### C. Decompiled Code Snippets
