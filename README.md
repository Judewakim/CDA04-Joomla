# CDA04 WordPress Deployment

> **A comprehensive guide to deploying WordPress using AWS services.**

## 📖 Overview

This repository provides resources and scripts to deploy a WordPress website using AWS services. The deployment architecture includes:

- **Amazon EC2**: Hosts the WordPress application.
- **Amazon RDS**: Manages the MySQL database for WordPress.
- **AWS CloudFormation**: Automates the infrastructure deployment.
- **User Data Scripts**: Automates the configuration of the WordPress installation.

## 🚀 Features

- **Automated Deployment**: Utilize CloudFormation templates for consistent and repeatable infrastructure setup.
- **Scalable Architecture**: Leverage AWS services to ensure the WordPress site can handle varying traffic loads.
- **Secure Configuration**: Implement best practices for security, including network isolation and managed database services.

## 🛠️ Prerequisites

Before deploying this solution, ensure you have:

- ✅ An **AWS Account** with necessary permissions to create resources.
- ✅ **AWS CLI** installed and configured on your local machine.
- ✅ **WordPress** installation package ready for deployment.

## 🚀 Deployment Instructions

### 1️⃣ **Clone the Repository**

```bash
git clone https://github.com/Judewakim/CDA04-Wordpress.git
cd CDA04-Wordpress
```

### 2️⃣ **Review CloudFormation Template**

- Open the `cda04-twotierarch-code.yml` file.
- Ensure the configurations align with your requirements, such as instance types, database settings, and network configurations.

### 3️⃣ **Deploy the CloudFormation Stack**

```bash
aws cloudformation create-stack --stack-name WordPressStack --template-body file://cda04-twotierarch-code.yml --parameters ParameterKey=KeyName,ParameterValue=YourKeyName
```

Replace `YourKeyName` with the name of your EC2 Key Pair.

### 4️⃣ **Configure WordPress**

After the stack creation:

1. Retrieve the public DNS of the EC2 instance from the AWS Management Console.
2. SSH into the instance and verify that `user-data.sh` has correctly installed WordPress.
3. Ensure `configure_wp_config.sh` has configured the `wp-config.php` file with the correct database details.
4. Access the WordPress setup wizard by navigating to `http://<EC2-Public-DNS>/wordpress` in your browser.
5. Follow the on-screen instructions to complete the WordPress installation.

## 🗑 Cleanup

To remove all deployed resources:

```bash
aws cloudformation delete-stack --stack-name WordPressStack
```

Ensure all associated resources, such as S3 buckets or additional security groups, are deleted to prevent unnecessary charges.

## 📚 References

- [WordPress Official Documentation](https://wordpress.org/support/)
- [AWS CloudFormation User Guide](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/Welcome.html)
- [Deploying WordPress on AWS](https://aws.amazon.com/getting-started/hands-on/deploy-wordpress/)

---

💡 **Happy Deploying!**

