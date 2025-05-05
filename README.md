# <img src="https://raw.githubusercontent.com/Tarikul-Islam-Anik/Telegram-Animated-Emojis/main/Travel%20and%20Places/Rocket.webp" alt="Rocket" width="50" height="50" /> A modular Terraform project to deploy AWS infrastructure using GitHub Actions for automation.

## <img src="https://raw.githubusercontent.com/Tarikul-Islam-Anik/Telegram-Animated-Emojis/main/Objects/Toolbox.webp" alt="Toolbox" width="30" height="30" /> Features
- Modular design using reusable Terraform modules
- GitHub Actions CI/CD for automation
- AWS Infrastructure as Code using best practices

## <img src="https://raw.githubusercontent.com/Tarikul-Islam-Anik/Telegram-Animated-Emojis/main/Objects/Card%20Index%20Dividers.webp" alt="Card Index Dividers" width="30" height="30" /> Modules
- **API Gateway Module**
Handles deployment of an API Gateway to route requests to backend services (like Lambda). It acts as the main entry point for your API infrastructure.

- **Lambda Module**
Deploys AWS Lambda functions to run backend code without managing servers. It supports scalable and cost-effective event-driven workloads.

- **S3 Module**
Creates an S3 bucket for static file hosting, backups, or data storage. Ideal for websites, logs, or general storage needs.

- **DynamoDB Module**
Creates and configures a DynamoDB table for fast and scalable NoSQL data storage with support for key-value and document data models.

## <img src="https://raw.githubusercontent.com/Tarikul-Islam-Anik/Telegram-Animated-Emojis/main/Symbols/Dizzy.webp" alt="Dizzy" width="30" height="30" /> CI/CD with GitHub Actions
This project uses a GitHub Actions workflow in .github/workflows/main.yml to automatically validate and deploy changes.

## <img src="https://raw.githubusercontent.com/Tarikul-Islam-Anik/Telegram-Animated-Emojis/main/Objects/Outbox%20Tray.webp" alt="Outbox Tray" width="30" height="30" /> Outputs
After deployment, Terraform will display output values such as:

- API Gateway endpoint
