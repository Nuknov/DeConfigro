# **DeConfigro -- WordPress Vulnerability Scanner**

[![Version](https://img.shields.io/badge/version-2.0-blue.svg)]()
[![License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)
[![Built by Nuknov](https://img.shields.io/badge/Built%20by-Nuknov-000000?logo=github&logoColor=white)](https://github.com/Nuknov)
[![Built by AnonKryptiQuz](https://img.shields.io/badge/Built%20by-AnonKryptiQuz-000000?logo=github&logoColor=white)](https://github.com/AnonKryptiQuz)

**DeConfigro** is a lightweight and powerful tool designed to scan websites for a common WordPress vulnerabilities involving the `wp-admin/setup-config.php?step=1` page.

This page is part of the WordPress installation process and, if left exposed, can be a security risk. The tool checks if the page is accessible, indicating an incomplete WordPress installation that could be exploited.

**Bash-Based. Fast. Efficient.**  
Built for **security researchers, penetration testers, and bug bounty hunters** who need to identify WordPress misconfigurations at scale.

---

## 🧩 **What DeConfigro Does**

- Detects **exposed WordPress setup configuration** pages
- Scans **single URLs** or **bulk targets** from file
- Provides **color-coded feedback** for vulnerable endpoints
- Saves **vulnerable URLs** to output file
- Features **auto-completion** for file paths
- Runs entirely in **bash** with minimal dependencies
- Performs **HTTP status checks** to confirm vulnerabilities

Designed for **efficient reconnaissance and vulnerability assessment** in authorized security testing.

> \* *This tool is for educational and authorized testing purposes only. See disclaimer below.*

---

## 🛰️ **Tech Stack**

- **Bash Shell** – Cross-platform shell scripting
- **Curl** – HTTP request handling
- **Auto-Completion** – Enhanced user experience
- **Color-Coded Output** – Clear visual feedback
- **File-Based Scanning** – Bulk target processing

---

## ⚡ **Features**

| Feature                     | Details                                                     |
|----------------------------|-------------------------------------------------------------|
| Vulnerability Detection    | Identifies exposed WordPress setup configuration pages       |
| Single URL Scanning        | Test individual targets quickly                             |
| Bulk Scanning              | Process multiple URLs from file                             |
| Auto-Completion            | File path completion for improved workflow                  |
| Detailed Output            | Color-coded feedback for vulnerable URLs                    |
| Save Results               | Export vulnerable URLs to file for documentation            |
| HTTP Status Validation     | Confirms page accessibility before flagging                 |
| Lightweight                | Minimal dependencies, runs on any Unix-like system          |

---

## 🛠️ Installation

### Quick Setup

1. **Clone the repository**
   ```bash
   git clone https://github.com/nuknov/DeConfigro.git
   cd DeConfigro
   ```

2. **Give executable permission to the script**
   ```bash
   chmod +x DeConfigro.sh
   ```

3. **Verify dependencies**
   ```bash
   # Check if curl is installed
   curl --version
   
   # If not installed:
   # Ubuntu/Debian: sudo apt install curl
   # macOS: brew install curl
   ```

---

## 📂 **Usage**

### Basic Usage

1. **Run the tool:**
   ```bash
   ./DeConfigro.sh
   ```
   
   **OR**
   
   ```bash
   bash DeConfigro.sh
   ```
   
   > **Note:** The `./` method is preferred if the script has been made executable with `chmod +x`, while `bash` can be used if you prefer to run the script through the Bash shell explicitly.

2. **Follow the prompts:**
   - Choose single URL or bulk scan mode
   - Enter target URL(s) or file path
   - Review scan results

3. **After the scan:**
   - Vulnerable URLs will be displayed in color-coded output
   - Option to save results to a file for documentation

### Example Workflow

```bash
$ ./DeConfigro.sh

[DeConfigro - WordPress Configuration Scanner]

Select scanning mode:
1. Single URL
2. Bulk scan from file

Enter choice: 2

Enter file path: targets.txt
[Auto-completion enabled]

Scanning targets...
✅ https://example1.com - VULNERABLE
❌ https://example2.com - Not Vulnerable
✅ https://example3.com - VULNERABLE

Save results to file? (y/n): y
Results saved to: vulnerable_sites.txt
```

---

## **Vulnerability Details**

### **What is the wp-admin/setup-config.php vulnerability?**

```
┌──────────────────────────────────────────────────┐
│  WORDPRESS SETUP CONFIGURATION EXPOSURE          │
├──────────────────────────────────────────────────┤
│                                                  │
│  Vulnerable Endpoint:                            │
│  /wp-admin/setup-config.php?step=1               │
│                                                  │
│  Risk Level: MEDIUM to HIGH                      │
│                                                  │
│  Attack Vector:                                  │
│  • Incomplete WordPress installation             │
│  • Setup page left publicly accessible           │
│  • Allows database configuration exposure        │
│  • Potential for database credential theft       │
│                                                  │
│  Impact:                                         │
│  • Attacker can complete installation            │
│  • Database takeover possible                    │
│  • Full site compromise                          │
│                                                  │
└──────────────────────────────────────────────────┘
```

### **How DeConfigro Detects It**

```bash
# Detection Method:
1. Send HTTP GET request to target + /wp-admin/setup-config.php?step=1
2. Check HTTP status code (200 = vulnerable)
3. Verify page content for WordPress setup indicators
4. Flag as vulnerable if exposed
5. Save to results file
```

---

## ⚙️ How It Works

DeConfigro uses **bash scripting and curl** to:

1. **Accept target input** (single URL or file of URLs)
2. **Construct vulnerable endpoint** by appending `/wp-admin/setup-config.php?step=1`
3. **Send HTTP requests** using curl
4. **Analyze responses** for exposure indicators
5. **Display color-coded results** to user
6. **Save vulnerable targets** to output file

✅ **Runs entirely locally**  
✅ **No external dependencies** beyond curl  
✅ **Fully open source**

---

## 🔧 **Requirements**

| Requirement | Details |
|------------|---------|
| Operating System | Linux, macOS, WSL for Windows |
| Shell | Bash (pre-installed on most Unix systems) |
| HTTP Client | curl (for making HTTP requests) |
| Permissions | Execute permission on script |
| Network | Internet connection for remote scanning |

---

## 🎨 **Output Example**

```bash
┌────────────────────────────────────────────────┐
│  DeConfigro - Scan Results                    │
├────────────────────────────────────────────────┤
│                                                │
│  ✅ https://site1.com - VULNERABLE             │
│     → /wp-admin/setup-config.php?step=1        │
│                                                │
│  ❌ https://site2.com - Not Vulnerable         │
│                                                │
│  ✅ https://site3.com - VULNERABLE             │
│     → /wp-admin/setup-config.php?step=1        │
│                                                │
│  📊 Summary:                                   │
│     Total Scanned: 3                           │
│     Vulnerable: 2                              │
│     Secure: 1                                  │
│                                                │
└────────────────────────────────────────────────┘
```

---

## ⚠️ **Disclaimer**

> **IMPORTANT: This tool is for educational and authorized testing purposes ONLY.**
>
> - You **MUST** have **explicit permission** from the website owner before scanning
> - This tool is designed for **authorized security assessments** and **bug bounty programs**
> - The authors are **NOT responsible** for any misuse or unauthorized scanning
> - Unauthorized scanning may be **illegal** in your jurisdiction
>
> **Legal Considerations:**  
> - Only scan websites you **own** or have **written authorization** to test
> - Respect responsible disclosure guidelines
> - Comply with bug bounty program rules
> - Follow all applicable laws and regulations
>
> **Ethical Usage:**  
> - Use for **vulnerability research** and **security improvement** only
> - Report findings to website owners **responsibly**
> - Do not exploit discovered vulnerabilities
> - Maintain confidentiality of discovered issues
>
> Always operate within legal boundaries and ethical guidelines.

---

## 🧠 **Use Cases**

- **Bug bounty hunting** on authorized programs
- **Security assessments** with proper authorization
- **WordPress security audits** for clients
- **Penetration testing** in controlled environments
- **Security research** on owned infrastructure
- **Red team exercises** with documented scope
- **Vulnerability disclosure programs**
- **Educational security training**

Ideal for **security professionals and researchers** conducting authorized WordPress security assessments.

---

## **Authors**

**Created by:**
- [AnonKryptiQuz](https://github.com/AnonKryptiQuz)
- [Nuknov](https://github.com/Nuknov/)

*With great power comes great responsibility. Scan ethically. Always get permission. Respect boundaries.*



