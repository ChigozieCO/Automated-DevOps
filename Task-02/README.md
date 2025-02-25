# Task

Containerize a Node.js or Python application using Docker and deploy it to Kubernetes

# Implementation

We will containerize a simple Node.js + Express application that checks password strength and suggests a stronger password when needed. The app is containerized using Docker and deployed on Kubernetes (Minikube).

## 🚀 Features

- Web UI for checking password strength

- API endpoint (/api)

- Dockerized for easy deployment

- Kubernetes manifests for running on Minikube

## 🛠 Prerequisites

- Node.js & npm

- Docker

- Minikube

- Kubectl

## 🚀 Getting Started

1.  Install Dependencies

    ```sh
    npm install
    ```

2. Run Locally

    ```sh
    node server.js
    ```

    App runs at: http://localhost:3000

3. Build the Docker Image 🐳

    ```sh
    docker build -t express-app .
    ```

4. Run the Container

    ```sh
    docker run -p 3000:3000 express-app
    ```

5. Deploying to Minikube: Start Minikube

    ```sh
    minikube start
    ```

6. Build the Image Inside Minikube

    ```sh
    eval $(minikube docker-env)
    docker build -t my-express-app .
    ```

7.  Deploy to Kubernetes

    ```sh
    kubectl apply -f deployment.yaml
    ```

8. Get the Service URL

    ```sh
    minikube service my-express-service --url
    ```

    Open the URL in your browser.