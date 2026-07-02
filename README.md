# 🔐 Linux Security Audit

A lightweight Bash script that performs a quick security and system health audit on Linux machines.

The script gathers important system, network, and security information and presents it in a clean, human-readable report along with a security summary.

---

## 📌 Features

- 🖥️ Displays system information
  - Hostname
  - Current user
  - Operating system
  - Kernel version
  - System uptime

- 🌐 Displays network information
  - IP address
  - Default gateway
  - DNS server

- 🛡️ Security checks
  - Firewall status (UFW)
  - SSH service status
  - Listening TCP ports
  - Service names for open ports
  - Running processes
  - Logged-in users
  - Active user sessions
  - RAM usage
  - Disk usage

- 📊 Summary section
  - Firewall health
  - SSH status
  - Listening ports overview
  - Disk usage health

- 🎨 Color-coded output
  - 🟢 Healthy
  - 🟡 Warning / Unknown
  - 🔴 Critical / Inactive

---

## 🛠 Technologies Used

- Bash
- awk
- grep
- cut
- wc
- ss
- free
- df
- systemctl
- hostname
- uptime
- UFW

---

## 📂 Project Structure

```
linux-security-audit/
│
├── audit.sh
├── README.md
└── screenshots/
```

---

## 🚀 Installation

Clone the repository

```bash
git clone git@github.com:Sam-Paul1/linux-security-audit.git
```

Move into the project

```bash
cd linux-security-audit
```

Give execute permission

```bash
chmod +x audit.sh
```

Run

```bash
./audit.sh
```

---

## 📷 Sample Output

### Audit Report

> *(Add a screenshot here after uploading one to the repository.)*

```
====================================
         Linux Security Audit
====================================

Date            :02-07-2026
Time            :14:59:51
Hostname        :sp

=========SYSTEM INFORMATION=========

Current User    :sampaul
OS              :Kali GNU/Linux Rolling
Kernel          :6.16.8+kali-amd64
Uptime          :up 5 minutes

=========NETWORK INFORMATION=========

IP Address      :10.0.2.15
Default Gateway :10.0.2.2
DNS Server      :192.168.1.1
```

---

## 📋 Security Summary

Example:

```
=============SUMMARY=============

Firewall        : UNKNOWN
SSH             : WARNING
Listening Ports : OK (0)
Disk Usage      : WARNING (85%)
```

---

## ⚠ Notes

- Some security checks require **root privileges**.
- If the script is executed as a non-root user, firewall information may be unavailable.

---

## 🔮 Future Improvements

- Export results to JSON
- Export results to HTML
- Generate PDF reports
- Support additional firewall solutions
- Detect suspicious processes
- Check failed login attempts
- Check system updates
- Email audit reports
- Support multiple Linux distributions

---

## 👨‍💻 Author

**Sam Paul**

GitHub: https://github.com/Sam-Paul1

---

## 📄 License

This project is licensed under the MIT License.
