# GraphXR Explorer for Spanner

This guide walks you through setting up and using GraphXR Explorer with Google Cloud Spanner.

## 1. Create Spanner Database

### 1) Create Google Cloud Project

Navigate to the [Google Cloud Project Creation page](https://console.cloud.google.com/projectcreate)

![Create Google Project](./images/1-create-google-project.png)

### 2) Create Spanner Instance

> **Note**: Spanner supports two types of graph databases:
> - **Schema Graph**: See [Graph Overview Documentation](https://docs.cloud.google.com/spanner/docs/graph/overview)
> - **Schema-Less Graph**: See [Schema-Less Data Management](https://docs.cloud.google.com/spanner/docs/graph/manage-schemaless-data)

Go to the [Spanner Instances page](https://console.cloud.google.com/spanner/instances)

![Create Spanner Instance](./images/2-create-spanner-instance.png)

### 3) Create Database from Sample Dataset

Create a database from the Explore dataset (e.g., Finance graph)

![Explore Dataset](./images/3-explore-dataset.png)

### 4) View the Finance Graph

You will see the Finance graph displayed

![Finance Graph](./images/4-goto-finance-graph.png)

## 2. Deploy GraphXR Explorer for Spanner

### 1) Search and Select from Marketplace

Search for "GraphXR Explorer for Spanner" in the GCP Marketplace

![Search GraphXR Explorer](./images/5-create-graphxr-explorer-for-spanner.png)

### 2) Select GraphXR Explorer

Select GraphXR Explorer for Spanner, then click **Get Started**

![Deploy GraphXR Explorer](./images/6-deploy-graphxr-explorer.png)

### 3) Agree to Terms and Conditions

Review and agree to the terms and conditions

![Agree to Terms](./images/7-agree-term.png)

### 4) Create Service Account

Create a service account for the deployment

![Create Service Account](./images/8-create-service-account.png)

### 5) Deploy the Instance

Click **Deploy** to create the GraphXR Explorer for Spanner instance

![Click Deploy](./images/9-click-deploy-button.png)

![Deployment Info](./images/91-deploy-info.png)

## 3. Access GraphXR Explorer

### 1) Login to GraphXR

Access the GraphXR Explorer interface

![Login to GraphXR](./images/92-login-graphxr.png)

### 2) Create Service Account for Database Access

Create a service account for GraphXR to access the Spanner database

![Create Service Account](./images/93-create-service-account-for-graphxr.png) 

![Service Account Name](./images/94-create-service-account-name.png) 

### 3) Assign Permissions

Assign the necessary permissions to the service account

![Service Account Permissions](./images/95-service-account-permissions.png) 

### 4) Generate Key File

Create a service account key file for GraphXR Explorer

![Manage Keys](./images/96-service-account-manager-keys.png)

![Create Key File](./images/97-service-account-keyfile.png)

### 5) Upload Key File

Upload the service account key file to GraphXR Explorer

![Upload Key File](./images/98-service-account-upload.png)

### 6) Select Database

Choose the graph database you want to explore

![Choose Database](./images/99-choose-graph-database.png)
 

## 4. Start Exploring

You're all set! Start exploring your Spanner graph database with GraphXR Explorer.

![Enjoy GraphXR](./images/991-enjoy-using-graphxr.png) 

## 5. Cleanup

### 1) Delete the Deployment

When you're finished, you can delete the GraphXR Explorer for Spanner deployment to avoid ongoing charges.

![Delete Deployment](./images/992-delete-graphxr-deployment.png)

---

## Additional Resources

- [Google Cloud Spanner Documentation](https://cloud.google.com/spanner/docs)
- [GraphXR Documentation](https://kineviz.com/documentation)

## Support

For issues or questions, please contact support or refer to the official documentation.