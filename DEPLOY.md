
# 🚀 Project Deployment Guide (Frontend + Backend on AWS EC2)

Complete step-by-step guide to deploy an Angular **frontend** and Node.js (TypeScript) **backend** on the same AWS EC2 instance running Amazon Linux 2023.

---

## ✅ Prerequisites

- An EC2 instance running Amazon Linux 2023
- SSH access to the EC2 instance
- Open necessary ports in the Security Group (e.g., 80 for HTTP, 3000 for backend if needed)
- File transfer method (FileZilla, SCP, etc.)
- Ready Angular and Node.js projects for deployment

---

## 🌐 Frontend Deployment (Angular + NGINX)

### Step 1: Build Angular Project

```bash
npm install -g @angular/cli
ng version
ng build --configuration production
```

✅ After building, the output will be in:  
`dist/your-project-name`

---

### Step 2: Install Node.js using nvm (to avoid dnf install issues)

```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
nvm --version
nvm install node
node -v       # Check Node.js version
npm -v        # Check npm version
```

---

### Step 3: Install and start NGINX on EC2

```bash
sudo dnf update -y
sudo dnf install -y nginx
sudo systemctl start nginx
sudo systemctl enable nginx
sudo systemctl status nginx
nginx -v     # Check version
```

---

### Step 4: Upload frontend build files to EC2

- Use FileZilla or any tool to upload the zipped build files to:

```bash
/usr/share/nginx/html/
```

- Then on EC2 run:

```bash
cd /usr/share/nginx/html
sudo rm -rf *
unzip your-dist-file.zip
sudo systemctl restart nginx
```

---

### ✅ Now you can access the frontend via:

```
http://<your-ec2-public-ip>
```

---

## 🧰 Backend Deployment (Node.js + TypeScript)

### Step 1: Upload backend files to EC2

- Upload your backend.zip file to:

```bash
/var/www/
```

- Then on EC2:

```bash
cd /var/www
unzip backend.zip
```

---

### Step 2: Install Node.js and dependencies

> If you did not install Node.js via nvm earlier:

```bash
sudo dnf install nodejs -y
```

- Install project dependencies:

```bash
cd /var/www
npm install
npm install -g typescript
```

- To run the project (based on your package.json scripts):

```bash
npm run dev
```

> **Note:** If you face permission issues with nodemon or ts-node, run:

```bash
chmod +x /var/www/node_modules/.bin/nodemon
chmod +x /var/www/node_modules/.bin/ts-node
# Or generally
sudo chmod +x /var/www/node_modules/.bin/*
```

✅ Backend should now be running on port `3000`

---

## 🔄 Connect frontend to backend via NGINX (Reverse Proxy)

### Step 1: Create new NGINX config file

```bash
sudo nano /etc/nginx/conf.d/app.conf
```

Add the following content:

```nginx
server {
    listen 80;
    server_name _;

    root /usr/share/nginx/html;
    index index.html;

    location / {
        try_files $uri $uri/ /index.html;
    }

    location /api/ {
        proxy_pass http://localhost:3000;
        proxy_http_version 1.1;

        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

---

### Step 2: Test and reload NGINX

```bash
sudo nginx -t   # Test config syntax
sudo systemctl reload nginx
```

---

## 🛡️ EC2 Security Group Setup

Make sure the following ports are open in your EC2 Security Group:

| Port | Purpose                      |
|-------|-----------------------------|
| 80    | HTTP (Frontend via NGINX)    |
| 3000  | Backend Node.js (Optional)   |

---

## 🎉 Final Result

- Frontend accessible at:  
  `http://<your-ec2-public-ip>`

- All API calls starting with `/api/` will be proxied to backend on port 3000
