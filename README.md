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
├── sample-app/              # Flask application source
├── Dockerfile               # Container build instructions
├── buildspec.yml            # CI build + docker push pipeline
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

1️⃣ Developer pushes code to GitHub
2️⃣ GitHub notifies AWS CodePipeline
3️⃣ CodePipeline invokes CodeBuild
4️⃣ CodeBuild:

installs dependencies

builds Docker image

logs in to Docker registry

pushes image

outputs build artifacts

5️⃣ CodePipeline triggers CodeDeploy
6️⃣ CodeDeploy deploys the updated version
7️⃣ Application updates automatically

📸 Diagram Reference

The architecture above is directly derived from your sketch:

(If you want, I can recreate this sketch into a clean digital diagram.)

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
