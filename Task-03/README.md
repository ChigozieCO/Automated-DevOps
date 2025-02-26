# Task

Configure monitoring and alerting using Prometheus and Grafana for a deployed application.

# Implementation

We will deploy the application in the [previous task](../Task-02/) and then configure monitoring using Prometheus and Grafana for the node.js application.

This project sets up monitoring for a Node.js application using Prometheus for metrics collection and Grafana for visualization. The application exposes metrics, which are scraped by Prometheus and visualized in Grafana dashboards.

## Components

- Node.js Express App: Exposes application metrics at `/metrics` using prom-client.

- Prometheus: Scrapes metrics from the Node.js app.

- Grafana: Visualizes collected metrics.

- Kubernetes: Deploys all components using manifests.

## Prerequisites

- Docker

- Minikube or a Kubernetes cluster

- kubectl command-line tool

## Setup Instructions

1. Clone this repo

2. Start Minikube

    ```sh
    minikube start
    ```

3. Deploy the Node.js Application, Prometheus and Grafana

    ```sh
    kubectl apply -f .
    ```

4. Access the Services

    Express-app UI:

    ```sh
    minikube service express-service --url
    ```

    Open the provided URL in your browser.

    Prometheus UI:

    ```sh
    minikube service prometheus --url
    ```

    Open the provided URL in your browser.

    Grafana UI:

    ```sh
    minikube service grafana --url
    ```

    Open the provided URL in your browser. Login using:

    - Username: admin

    - Password: admin

5. Configure the Dashboard

    - Go to Grafana > Configuration > Data Sources.

    - Ensure Prometheus is added as a data source, it should be added automatically as that is part of this configuration but if for any reason it isn't add it. (http://prometheus.default.svc.cluster.local:9090).

    - Import a dashboard using its ID or JSON file.

## Troubleshooting

- Check pod logs for errors:

  ```sh
  kubectl logs -l app=grafana
  kubectl logs -l app=prometheus
  ```

- Restart pods if needed:

  ```sh
  kubectl delete pod -l app=grafana
  kubectl delete pod -l app=prometheus
  ```

## Future Improvements

- Fix automatic dashboard provisioning.

- Secure Grafana with persistent storage and authentication.

- Optimize resource limits for better performance.