# aws-native-cicd-pipeline
Complete CI/CD automation on AWS using CodePipeline, CodeBuild, and CodeDeploy, including secure build steps, Docker image creation, and automated deployment.
This repository demonstrates an end-to-end CI/CD pipeline built entirely with AWS-native services.
The pipeline automates the complete flow from source → build → deploy using:

AWS CodePipeline (Orchestrator)

AWS CodeBuild (CI: build & test Docker image)

AWS CodeDeploy (CD: deploy application)

GitHub as the source repository

AWS Systems Manager Parameter Store for secure secret handling

🚀 Architecture Overview

Here’s the high-level workflow based on the diagram:

Developer → commits code → GitHub
            |
            v (triggers)
      AWS CodePipeline  ← orchestrator
            |
            +--> invokes CI stage → AWS CodeBuild
            |          - installs dependencies
            |          - builds Docker image
            |          - pushes image to registry
            |
            +--> invokes CD stage → AWS CodeDeploy
                       - pulls new artifact/image
                       - deploys to target environment

Key Concept

CodePipeline ≠ Build tool
It is an orchestrator that invokes:

CodeBuild for CI

CodeDeploy for CD

📦 What This Project Includes
✅ Continuous Integration (CI)

Automated builds using AWS CodeBuild

Python/Flask sample application

Docker image creation

Secure credentials stored in Parameter Store

DockerHub image push (or ECR when needed)

Build stages defined through buildspec.yml

✅ Continuous Deployment (CD)

Automated deployment using AWS CodeDeploy

Pipeline triggers deployment on successful build

Zero manual steps once the pipeline is active

✅ AWS CodePipeline Integration

Connects GitHub → CodeBuild → CodeDeploy

Automatically triggers on every commit

Shows real-time progress of each stage

🔐 Secret Management

This repo uses AWS Systems Manager Parameter Store to store sensitive values:

/myapp/docker/credentials/username  
/myapp/docker/credentials/password  
/myapp/docker/registry/url


These are injected into CodeBuild during runtime, ensuring no secrets are exposed in the repository.

📁 Repository Contents
aws-native-cicd-pipeline/
│
├── sample-app/
│   └── app.py               # Flask application source code
├── Dockerfile               # Container build instructions
├── requirements.txt         # Python dependencies
└── README.md                # Project documentation

⚙️ Technologies Used

AWS CodePipeline

AWS CodeBuild

AWS CodeDeploy

AWS IAM Roles

AWS Systems Manager (Parameter Store)

Docker

Python / Flask

GitHub Webhooks

🧪 How the Pipeline Works

1. Developer pushes code to GitHub
2. GitHub notifies AWS CodePipeline
3. CodePipeline invokes CodeBuild
4. CodeBuild:
   - Installs dependencies from requirements.txt
   - Builds Docker image using Dockerfile
   - Logs in to Docker registry using credentials from Parameter Store
   - Pushes image with version tag and latest tag
5. CodePipeline triggers CodeDeploy
6. CodeDeploy deploys the updated version
7. Application updates automatically

🛠️ Local Setup and Testing

Prerequisites:
- Python 3.9+
- Docker installed
- AWS CLI configured

Test Locally Without Docker:
```bash
pip install -r requirements.txt
python sample-app/app.py
```
Access at: http://localhost:5000

Test with Docker:
```bash
docker build -t myapp:latest .
docker run -p 5000:5000 myapp:latest
```

Available Endpoints:
- GET / - Welcome message
- GET /health - Health check endpoint
- GET /info - Application information

🔧 AWS Setup Instructions

Step 1: Create Parameter Store Values
```bash
aws ssm put-parameter --name /myapp/docker/credentials/username --value "YOUR_DOCKER_USERNAME" --type String
aws ssm put-parameter --name /myapp/docker/credentials/password --value "YOUR_DOCKER_PASSWORD" --type SecureString
aws ssm put-parameter --name /myapp/docker/registry/url --value "docker.io/YOUR_USERNAME" --type String
```

Step 2: Create IAM Role for CodeBuild
Required permissions:
- AmazonEC2ContainerRegistryPowerUser
- AmazonSSMReadOnlyAccess
- CloudWatchLogsFullAccess

Step 3: Create CodeBuild Project
- Source: GitHub repository
- Environment: Linux, Standard image
- Service role: Attach the role from Step 2

Step 4: Create CodePipeline
- Source stage: GitHub connection
- Build stage: CodeBuild project
- Deploy stage: CodeDeploy or ECS (optional)

Step 5: Commit and Push
Pipeline will automatically trigger on every commit to the main branch.

🎯 Goal of This Project

This repository is built to help learners and DevOps engineers understand:

How AWS-native CI/CD works

How to securely handle credentials

How to connect GitHub → AWS Pipeline

How to automate Docker builds & deployments

It is an industry-style hands-on implementation suitable for:

Students

DevOps beginners

Cloud engineers

Interview preparation

📓 Future Enhancements

Optional improvements you can add later:

Replace DockerHub with Amazon ECR

Use ECS or EC2 for deployment environment

Add Unit Tests in CI stage

Add Static Code Analysis (Bandit/Flake8)

Add SonarQube integration

Add Blue/Green deployment with CodeDeploy

🙌 Contributing

Feel free to raise issues, submit PRs, or extend this project with new AWS services.
