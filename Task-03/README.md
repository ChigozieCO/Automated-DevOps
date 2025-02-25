# Task

Configure monitoring and alerting using Prometheus and Grafana for a deployed application.

# Implementation

We will deploy the application in the [previous task](../Task-02/) and then configure monitoring and alerting using Prometheus and Grafana for the node.js application.

Plan for Monitoring Setup
Expose Metrics in the Node.js App

Use the prom-client library to expose metrics at /metrics.
Deploy Prometheus

Use a ServiceMonitor (if using the Prometheus Operator) or manually configure a prometheus.yml to scrape the app’s /metrics endpoint.
Deploy Grafana

Install it via Helm or manifests and configure Prometheus as a data source.
Set Up Alerts

Define alerting rules in Prometheus and set up a notification channel (e.g., Slack, email).