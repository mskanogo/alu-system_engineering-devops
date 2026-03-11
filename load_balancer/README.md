# Load Balancer

## Description
This project focuses on improving web infrastructure by adding redundancy through load balancing. Two web servers (web-01 and web-02) are placed behind a load balancer (lb-01) using HAProxy. This setup allows the infrastructure to handle more traffic and remain available even if one web server fails.

## Infrastructure
| Server | Hostname | Role |
|--------|----------|------|
| web-01 | 7023-web-01 | Web Server 1 (Nginx) |
| web-02 | 7023-web-02 | Web Server 2 (Nginx) |
| lb-01  | 7023-lb-01  | Load Balancer (HAProxy) |

## Requirements
- Ubuntu 16.04 LTS
- Nginx (on web-01 and web-02)
- HAProxy (on lb-01)
- All Bash scripts must pass Shellcheck (version 0.3.7)

## Files

### `0-custom_http_response_header`
Configures a brand new Ubuntu server with Nginx and adds a custom HTTP response header:
- **Header name:** `X-Served-By`
- **Header value:** The hostname of the server Nginx is running on

This allows tracking of which web server is responding to each HTTP request.

**Usage:**
```bash
sudo bash 0-custom_http_response_header
```

**Verify:**
```bash
curl -sI <server-ip> | grep X-Served-By
```

---

### `1-install_load_balancer`
Installs and configures HAProxy on a brand new Ubuntu server:
- Sends traffic to web-01 and web-02
- Uses a **round-robin** algorithm to distribute requests
- HAProxy is manageable via an init script

**Usage:**
```bash
sudo bash 1-install_load_balancer
```

**Verify (run twice to see round-robin in action):**
```bash
curl -Is <lb-01-ip> | grep X-Served-By
curl -Is <lb-01-ip> | grep X-Served-By
```

Expected output:
```
X-Served-By: 7023-web-01
X-Served-By: 7023-web-02
```

## Author
- **Project:** ALU System Engineering & DevOps
- **Topic:** Web Infrastructure - Load Balancer
