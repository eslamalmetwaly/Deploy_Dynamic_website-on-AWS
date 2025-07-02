# 🚀 AWS Cloud Infrastructure for Scalable Web Application

![Infrastructure Diagram](./architecture.png)

This project provides a full Infrastructure as Code (IaC) setup using **Terraform** to deploy a scalable, secure, and production-ready web application on **AWS Cloud**.

---

## 📦 Project Components

| Layer         | Details                                           |
|---------------|---------------------------------------------------|
| 🌐 Frontend    | Angular app hosted via NGINX on EC2              |
| 🧰 Backend     | Node.js + TypeScript REST API                    |
| ☁️ Cloud       | AWS EC2, VPC, ALB, Auto Scaling Groups           |
| 🛡️ Security     | Custom Security Groups, Public/Private Subnets |
| 💾 Database    | MongoDB Atlas (Cloud-based NoSQL)               |
| ⚙️ Automation   | Terraform IAC Modules                           |

---

## 📁 Folder Structure

```bash
.
├── Compute/
│   ├── VPC.tf
│   ├── ALB.tf
│   ├── ...
│   └── Scale/
│       ├── AMI.tf
│       ├── AutoScale.tf
├── DEPLOY.md
├── README.md
└── architecture.png

📘 **Deployment Instructions**  
For full steps to build and deploy the Angular frontend, Node.js backend, configure NGINX, and Terraform setup:  

👉 [Click here to open `DEPLOY.md`](./DEPLOY.md)  

🔐 **Security Highlights**  
- Separate Security Groups for ALB and EC2  
- Inbound rules limited to HTTP (80) and app port (3000)  
- Infrastructure provisioned across multiple AZs for high availability  

🌍 **Access**  
Once deployed:  
- **Frontend**: http://<your-ec2-ip>  
- **APIs**: Accessed via `/api/...` and routed to backend via NGINX  
- **MongoDB Atlas**: Cloud-hosted & externally connected  

---

### 👨‍💻 **Author**  
**Eslam Almetwaly**  
Cloud Enthusiast ☁  
🔗 [GitHub Profile](https://github.com/eslamalmetwaly)  


📝 Feedback
Open issues or pull requests if you want to contribute or suggest improvements.

