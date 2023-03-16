# terraform-aws-batch-example

Sample aws batch configuration with terraform

## How to start 

(for development environment)

Execute the following command

```
cd ./deployments/dev/
touch terraform.tfvars
```

Please define variables with reference to the following.

```tf
project_name     = "xxxx"
batch_vpc_id     = "vpc-xxx"
batch_subnet_ids = ["subnet-xxxxx", "subnet-xxxxx"]
container_image  = "xxxxx.dkr.ecr.ap-northeast-1.amazonaws.com/XXXXX"  # in case of ECR
image_version    = "latest"
```

Please confirm the changes with the plan command after executing init.

```
terraform init
terraform validate
terraform plan
```

Deploying a configuration.

```
terraform apply
```