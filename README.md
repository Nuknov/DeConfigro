# DeConfigro: WordPress Configuration Vulnerability Scanner

**DeConfigro** is a lightweight and powerful tool designed to scan websites for a common WordPress vulnerability involving the `wp-admin/setup-config.php?step=1` page. This page is part of the WordPress installation process and, if left exposed, can be a security risk. The tool checks if the page is accessible, indicating an incomplete WordPress installation that could be exploited.

## **Features**

- **Vulnerability Detection**: Identifies exposed WordPress setup configuration pages.
- **Single URL and Bulk Scanning**: Supports both single URL scans and bulk scans from a file.
- **Auto-Completion for File Paths**: Automatically completes file paths to ease the user's workflow.
- **Detailed Output**: Provides clear and color-coded feedback about vulnerable URLs.
- **Save Results**: Option to save vulnerable URLs to a file for future reference.

## **Prerequisites**

- **Bash Shell** (Linux, macOS, or WSL for Windows)
- **Curl** (for making HTTP requests)
- **Optional**: Text editor for editing URLs file.

## **Installation**

1. **Clone the repository:**

   ```bash
   git clone https://github.com/AnonKryptiQuz/DeConfigro.git
   cd Xploitra
   ```

2. **Give executable permission to the script**

   ```bash
   chmod +x DeConfigro.sh
   ```

## **Usage**

1. **Run the tool:**

   After giving executable permission to the script, you can run the tool using one of the following commands:

   ```bash
   ./DeConfigro.sh
   ```

   or

   ```bash
   bash DeConfigro.sh
   ```

   The `./` method is preferred if the script has been made executable with `chmod +x`, while `bash` can be used if you prefer to run the script through the Bash shell explicitly.
   
2. **Follow the prompts** to configure and choose whether to scan a single URL or use a file containing URLs.

3. **After the scan**:
   - Vulnerable URLs will be displayed.
   - You will be prompted to save the results to a file.

## **Disclaimer**

- **Educational Purposes Only**: DeConfigro is intended for educational and research use only. The tool is not intended for malicious or unauthorized use. It is the user's responsibility to ensure compliance with all relevant local laws and regulations before using this tool.

## **Author**

**Created by:** [AnonKryptiQuz](https://AnonKryptiQuz.github.io/)
