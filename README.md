# class112625
This is a Terraform setup file s for AWS
You need to add your own AMI imformation on the EC2.tf file

Quick graph for visual
                          ┌────────────────────────────────────┐
                          │            AWS Region              │
                          │             us-east-1              │
                          └────────────────────────────────────┘
                                        │
                                        ▼
                          ┌─────────────────────────┐
                          │          VPC            │
                          │     10.0.0.0/16         │
                          └─────────────────────────┘
                                        │
   ┌────────────────────────────── PUBLIC SUBNETS ──────────────────────────────┐
   │                                                                            │
   │  ┌──────────────────────┐          ┌──────────────────────┐                │
   │  │  Public Subnet A     │          │  Public Subnet B     │                │
   │  │    (10.0.1.0/24)     │          │    (10.0.2.0/24)     │                │
   │  └──────────────────────┘          └──────────────────────┘                │
   │           │                                     │                          │
   │           ▼                                     ▼                          │
   │  ┌──────────────────────┐          ┌──────────────────────┐                │
   │  │  ALB (HTTP :80)      │ ◄────────┤  ALB Target Group    │                │
   │  │ Application LB       │          │ (Health Checks)      │                │
   │  └──────────────────────┘          └──────────────────────┘                │
   │           │                                                                │
   └───────────┴──────────────────────────────────────────────────────────────┘
                                        │
                                        ▼
   ┌────────────────────────────── PRIVATE SUBNETS ─────────────────────────────┐
   │                                                                            │
   │  ┌──────────────────────┐   ┌──────────────────────┐   ┌──────────────────────┐
   │  │ Private Subnet A     │   │ Private Subnet B     │   │ Private Subnet C     │
   │  │    (10.0.3.0/24)     │   │    (10.0.4.0/24)     │   │    (10.0.5.0/24)     │
   │  └──────────────────────┘   └──────────────────────┘   └──────────────────────┘
   │          │                         │                         │
   │          ▼                         ▼                         ▼
   │  ┌──────────────────────┐   ┌──────────────────────┐   ┌──────────────────────┐
   │  │ Auto Scaling Group   │   │ Auto Scaling Group   │   │ Auto Scaling Group   │
   │  │ EC2 Instances (ASG)  │   │ EC2 Instances (ASG)  │   │ EC2 Instances (ASG)  │
   │  │ Launch Template +    │   │ Launch Template +    │   │ Launch Template +    │
   │  │ user_data.sh         │   │ user_data.sh         │   │ user_data.sh         │
   │  └──────────────────────┘   └──────────────────────┘   └──────────────────────┘
   │                                                                            │
   └────────────────────────────────────────────────────────────────────────────┘
                                        │
                                        ▼
                          ┌─────────────────────────┐
                          │ NAT Gateway (Public)    │
                          │ Internet access for     │
                          │ private EC2 instances   │
                          └─────────────────────────┘

                                        │
                                        ▼
                          ┌─────────────────────────┐
                          │ Internet Gateway (IGW)  │
                          │ Public Subnets Routing  │
                          └─────────────────────────┘


Here is an updated **project description** that includes a clear explanation of all your Terraform files.
# **Terraform AWS Load Balancer Setup – us-east-1 (N. Virginia)**
This Terraform project deploys a complete, highly available **Application Load Balancer (ALB)** environment in the **AWS us-east-1 region**.
It includes networking, security, compute, and scaling components required for a scalable web application.

# **Terraform File Overview**
Each file in this project is modularized for clarity and maintainability:

### **0-auth.tf**
Configures AWS provider authentication and sets the region (**us-east-1**).

### **1-vpc.tf**
Creates the main **VPC** used for the entire infrastructure.

### **2-subnets.tf**
Defines **public and private subnets** across multiple Availability Zones for high availability.

### **3-igw.tf**
Creates the **Internet Gateway**, allowing public resources to access the internet.

### **4-nat.tf**
Deploys a **NAT Gateway** so private subnet instances can access the internet securely.

### **5-rtb.tf**
Configures **Route Tables** for both public and private subnets.

### **6-sg.tf**
Creates primary **Security Groups** for ALB and EC2 access (HTTP/HTTPS rules).

### **6a-sg.tf**
Additional security groups (secondary or service-specific rules).

### **7-ec2.tf**
Defines EC2 instances if needed outside of ASG (optional/demo instance).

### **8-launchtemplate.tf**
Configures a **Launch Template** for Auto Scaling with:

* AMI
* Instance type
* Security groups
* Bootstrap (`user_data.sh`)

### **9-targetgroup.tf**
Creates an ALB **Target Group** with health checks, used by the Auto Scaling Group.

### **10a-loadbalancer.tf**
Deploys the **Application Load Balancer (ALB)** and HTTP listeners.

### **10b-scalling-policy.tf**
Defines **scaling policies** (CPU-based) for the Auto Scaling Group.

### **11-autoscallinggroup.tf**
Creates the **Auto Scaling Group (ASG)** across private subnets and attaches the target group.

### **A-output.tf**
Outputs important information such as:

* Load Balancer DNS name
* VPC ID
* Subnet IDs
* ASG name

### **user_data.sh**
Bootstrap script executed on EC2 instances during launch (installs packages, configures services, etc.).

# **Architecture Summary**
The Terraform configuration provisions:

### **Networking**

* VPC (us-east-1)
* Public & private subnets
* Internet Gateway
* NAT Gateway
* Route tables

### **Security**
* Security groups for ALB and EC2
* Restricted inbound/outbound network rules

### **Compute**
* Launch Template
* Auto Scaling Group
* Bootstrap script
* Optional standalone EC2 resources

### **Load Balancing**
* Application Load Balancer (ALB)
* Listener (HTTP 80)
* Target Group (instance target type)
* Health checks

### **Auto Scaling**
* ASG across 3 private subnets
* Scaling policy based on average CPU utilization
* Lifecycle hooks for instance launch/termination

#  **Purpose of This Project**
This repository provides a ready-to-use Terraform blueprint for deploying a **scalable, load-balanced architecture** in **AWS us-east-1**.
It is ideal for:

* DevOps learning
* AWS IaC demos
* Portfolio projects
* Production-ready base templates




# class112625
