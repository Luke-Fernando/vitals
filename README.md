
# Vitals
 
A simple, lightweight CLI tool to check the health and response times of websites, one URL at a time, or a whole list at once.
 
---
 
## Features
 
- Check a single URL instantly from the terminal
- Pass in a text file with a list of URLs to check them all at once
- Shows HTTP status codes and response times
---
 
## Dependencies
 
Before using Vitals, make sure you have the following installed:
 
| Dependency | Why it's needed                                       |
| ---------- | ----------------------------------------------------- |
| `bash`     | The script is written in Bash                         |
| `curl`     | Used to make HTTP requests and measure response times |
 
To check if `curl` is available:
 
```bash
curl --version
```
 
If it's missing, install it with your package manager:
 
```bash
# Debian/Ubuntu
sudo apt install curl
 
# macOS (with Homebrew)
brew install curl

# Fedora
sudo dnf install curl
```
 
---
 
## Installation
 
**1. Clone the repository**
 
```bash
git clone https://github.com/Luke-Fernando/vitals.git
cd vitals
```
 
**2. Make the installer executable**
 
```bash
chmod +x ./install.sh
```
 
**3. Run the installer**
 
```bash
sudo ./install.sh
```
 
You can now use the `vitals` command from anywhere in your terminal.
 
---
 
## Usage
 
**Check a single URL:**
 
```bash
vitals google.com
```
 
**Check a list of URLs from a file:**
 
```bash
vitals ./sites.txt
```
 
Your text file should have one URL per line, like this:
 
```
google.com
github.com
example.com
```
 
**Show help:**
 
```bash
vitals --help
```
 
**Show version:**
 
```bash
vitals --version
```
 
---

 
## License
 
MIT — do whatever you like with it.
