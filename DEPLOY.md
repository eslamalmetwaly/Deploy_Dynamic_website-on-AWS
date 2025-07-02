# 🚀 Project Deployment Guide (Frontend + Backend on AWS EC2)

This guide provides full deployment instructions for both the **Angular frontend** and the **Node.js (TypeScript) backend** on a single AWS EC2 instance running Amazon Linux 2023.

---

## ✅ Prerequisites

- An EC2 instance (Amazon Linux 2023)
- SSH access to the EC2 instance
- Open ports in the EC2 security group (e.g., 80 for HTTP, 3000 for backend if needed)
- File transfer method (FileZilla or SCP)
- Angular and Node.js applications ready for deployment

---

## 🌐 Frontend Deployment (Angular + NGINX)

### Step 1: Build the Angular Project

```bash
npm install -g @angular/cli
ng version
ng build --configuration production

### Step 2 : Install Nodejs Packages

Note : Use nvm instead of installing directly via dnf to avoid problems :

 curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
 export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
 nvm --version
 nvm install node
 node -v ( The version should appear )
 npm -v (The version should appear)

✅ After building, the output will be in: dist/your-project-name

### Step 3 : Install NGINX on EC2
sudo dnf update -y
sudo dnf install -y nginx
sudo systemctl start nginx
sudo systemctl enable nginx
sudo systemctl status nginx
nginx -v

### Step 4 : Transfer Build Files to EC2
Use FileZilla (or any tool) to upload your Angular build .zip file to:
/usr/share/nginx/html/

Then run on EC2:
cd /usr/share/nginx/html
sudo rm -rf *
unzip your-dist-file.zip
sudo systemctl restart nginx
✅ Now you can access your frontend at EC2
▶️ check http://<your-ec2-public-ip>

## 🧰 Backend Deployment (Node.js + TypeScript)
Step 1: Transfer Backend Files
Transfer the backend .zip file to EC2 in this path:
/var/www/

Then on EC2:
cd /var/www
unzip backend.zip

Step 2: Install Node.js and Dependencies
Install Node.js:
sudo dnf install nodejs -y
Install project dependencies:
cd /var/www
npm install
npm install -g typescript
npm run dev

If permission errors appear:
chmod +x /var/www/node_modules/.bin/nodemon
chmod +x /var/www/node_modules/.bin/ts-node
or
sudo chmod +x /var/www/node_modules/.bin/*
✅ Your backend should now be running on port 3000.

🔄 Connect Frontend with Backend (via NGINX)
To route frontend API requests to the backend:

Step 1: Create a new NGINX config file :
sudo nano /etc/nginx/conf.d/app.conf
Paste the following content:
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
Step 2: Reload NGINX
sudo nginx -t      # Make sure syntax is OK
sudo systemctl reload nginx

🛡️ Security Group Checklist
Ensure the following ports are open on your EC2 security group:

80 → For frontend (HTTP via NGINX)

3000 → Optional: For backend (if testing directly)


🎉 Final Result
✅ Your project is now live!

🌐 Frontend: http://<your-ec2-ip>

🔗 API Calls: Routed via /api/... through NGINX to backend on port 3000








