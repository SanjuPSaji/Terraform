Here's a README file for the Terraform script:

```markdown
# AKS Cluster and ACR Deployment with Terraform

This project sets up an Azure Kubernetes Service (AKS) cluster along with an Azure Container Registry (ACR) and deploys frontend and backend applications to the AKS cluster using Terraform.

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) installed
- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli) installed and configured
- Azure Subscription

## Setup

1. **Clone the Repository**
   ```sh
   git clone https://github.com/your-repo/aks-acr-terraform.git
   cd aks-acr-terraform
   ```

2. **Configure Terraform Variables**
   
   Create a `terraform.tfvars` file in the root directory of the project and add your Azure subscription details:
   ```hcl
   subscription_id       = "your-subscription-id"
   resource_group_name   = "your-resource-group-name"
   location              = "your-location"
   aks_cluster_name      = "your-aks-cluster-name"
   dns_prefix            = "your-dns-prefix"
   node_count            = 2
   acr_name              = "your-acr-name"
   ```

3. **Initialize Terraform**
   ```sh
   terraform init
   ```

4. **Apply Terraform Configuration**
   ```sh
   terraform apply
   ```

   Confirm the apply action with `yes`. This will create all the necessary resources in Azure.

## Resources Created

- **Resource Group:** The resource group to contain all resources.
- **Azure Container Registry (ACR):** Used to store Docker images.
- **Azure Kubernetes Service (AKS):** Kubernetes cluster to run applications.
- **Kubernetes Namespace:** A namespace to organize resources in the AKS cluster.
- **Kubernetes Deployments:** Deployments for frontend and backend applications.
- **Kubernetes Services:** Services to expose the frontend and backend applications.

## Accessing the Applications

- The frontend application will be exposed via a LoadBalancer service, and can be accessed using the public IP provided by Azure.
- The backend application is exposed internally within the cluster using a ClusterIP service.

## Cleanup

To destroy all resources created by this Terraform script, run:
```sh
terraform destroy
```

Confirm the destroy action with `yes`.

## Notes

- Ensure that the Azure CLI is authenticated with the correct subscription before running Terraform commands.
- The backend and frontend Docker images should be pushed to the ACR before applying the Terraform configuration.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
```
