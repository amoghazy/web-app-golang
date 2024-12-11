# Web App with Golang and Continuous Delivery using ArgoCD

This repository contains a simple web application built with Go (Golang), demonstrating how to set up a web server, manage routing, and implement a basic REST API. Additionally, it includes a Continuous Delivery (CD) pipeline configured with ArgoCD and GitHub Actions.

## Features

- A lightweight Go web server.
- RESTful API endpoints.
- Dockerized application for easy deployment.
- Continuous Delivery pipeline using GitHub Actions and ArgoCD.
- Helm chart-based Kubernetes deployments.
- Ingress configuration with custom domain setup.

## Prerequisites

Before using this project, ensure you have the following tools installed:

- [Go](https://golang.org/doc/install) (v1.19 or later recommended)
- [Docker](https://www.docker.com/get-started)
- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
- [Kind](https://kind.sigs.k8s.io/) (Kubernetes in Docker)

## Getting Started

### Clone the Repository

```bash
git clone https://github.com/amoghazy/web-app-golang.git
cd web-app-golang
```

### Build and Run the Application Locally

1. **Build the Application:**

   ```bash
   go build -o web-app
   ```

2. **Run the Application:**

   ```bash
   ./web-app
   ```

3. **Access the Application:**

   Open your browser and navigate to `http://localhost:8080`.

### Setting Up the Kubernetes Cluster

1. **Install Kind:**

   Follow the [Kind installation guide](https://kind.sigs.k8s.io/docs/user/quick-start/#installation) to install Kind on your system.

2. **Create a Kubernetes Cluster:**

   ```bash
   kind create cluster --name web-app-cluster
   ```

#### Using Ingress Controller

1. **Install an Ingress Controller:**

   Deploy an ingress controller in your cluster. For example, using NGINX:

   ```bash
   kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml
   ```

2. **Verify Ingress Configuration:**

   Access the application at `http://web-go-app.local` after applying the ingress settings.

#### Setting Up ArgoCD

1. **Install ArgoCD on Your Cluster:**

   Follow the [ArgoCD installation guide](https://argo-cd.readthedocs.io/en/stable/getting_started/) to install ArgoCD.

2. **Set Up Port Forwarding:**

   ```bash
   kubectl port-forward svc/argocd-server -n argocd 8080:443
   ```

3. **Edit `/etc/hosts` File:**

   Add the following line to map the custom domain to localhost:

   ```plaintext
   127.0.0.1 web-go-app.local
   ```

4. **Access ArgoCD Dashboard:**

   Retrieve the ArgoCD admin password:

   ```bash
   kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath="{.data.password}" | base64 -d
   ```

   Access the ArgoCD dashboard at `https://localhost:8080` and log in with username `admin` and the retrieved password.

5. **Link ArgoCD to the Repository:**

   Create an application in ArgoCD that points to this repository and uses the Helm chart located in the `helm/` directory.

6. **Sync and Deploy:**

   Sync the application in ArgoCD to deploy the web app to your cluster.

### Continuous Delivery with GitHub Actions and ArgoCD

#### GitHub Actions Workflow

1. **Configure GitHub Actions:**

   The repository includes a `.github/workflows/ci-workflow.yaml` file for automating the build process:

   - Build the code to check for errors.
   - Build the Docker image.
   - Push the image to DockerHub.

2. **Update Helm Chart Values:**

   After pushing the Docker image, update the Helm chart values in `values.yaml` to reference the new image tag.

3. **Push Updates to the Repository:**

   Commit and push the updated Helm files:

   ```bash
   git add helm/web-go-app/values.yaml
   git commit -m "Update image tag"
   git push
   ```
#### if need update code must pull before push changes 
   ```bash
       git pull origin main 
   ```
   because GitHub Actions 
## Contributing

Contributions are welcome! If you find any issues or have suggestions for improvements, please create an issue or submit a pull request.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Acknowledgments

- [Golang](https://golang.org/) for its simplicity and performance.
- [ArgoCD](https://argo-cd.readthedocs.io/) for seamless Continuous Delivery.
- [Docker](https://www.docker.com/) for containerization.
- [Helm](https://helm.sh/) for Kubernetes application management.
- [NGINX Ingress Controller](https://kubernetes.github.io/ingress-nginx/) for routing traffic.
