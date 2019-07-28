# Terraform

## Concepts

Terraform is an orchestration tool: it means that, getting things that are already present, it uses them to fit into a desired state. Terraform is declarative (it means that you provide a declaration of what you want, and Terraform manages to create a plan to do it for you).

## Installation

- Download terraform from here: https://www.terraform.io/downloads.html
- Unzip package
- sudo mv terraform /usr/local/bin/

## Structure

Terraform is structured into .tf files. All that files will come in "terraform" format (kind of simplified json) or json. Json is only intended to be only for machine-generated code

Each block will be of a given type. Following you will find definition of some of them

- provider: this block is used to configure the named provider (aws for example). Reference: https://www.terraform.io/docs/providers/index.html . Params
  - provider_name
- resource: this block defines a resource that exists within the infrastructure (EC2 instance for example). Params
  - resource_type
  - resource_name
- provisioner: this block defines the provision for a given resource (thus it's always defined inside a resource block). There are multiple provisioners (like local-exec) https://www.terraform.io/docs/provisioners/index.html. 
- output: this block will define an output value. params:
  - output_name


## Commands

- terraform init: the first command that will initialize various local settings and data that will be used by subsequent commands. It does several things, like downloading provider binaries
- terraform apply: apply the defined configuration in your .tf files into your infrastructure. In 0.11+ versions of terraform, it will make a plan first, and wait for approval to apply it. In previous versions, it will require to call "terraform plan" command first. It writes data info "terraform.tfstate"
  - Output "+" symbol for all new created resources
  - Output "-/+" symbol for destroy and recreate resources
- terraform plan: create a plan of what it's intended to apply (most like a dry run from other tools)
- terraform show: show current state
- terraform destroy: destroy resources in the current plan
- terraform output: get terraform apply generated output

## Importante files

- terraform.tfstate: it is updated on each "terraform apply". It will store the actual state (IDs and this kind of stuff)

## Provisioners

This is the way Terraform allows user to provision a given resource with initial configuration / packaging. This is accomplished with "provisioner" block in a resource block
Failed provisioners on sucessfully created resources will be marked as "tainted"
Terraform will not attempt to restart provisioning on the same resource because it isn't guaranteed to be safe. Instead, on tainted resources, tarraform will remove them and create new resources
Provisioners can be defined to run only during a destroy operation (useful on system cleanups, data backups...)

## Input Variables

Usually defined in a variables.tf. There we will store all variables for our project
Variables defined with a value of {} will be prompted to user when call "terraform plan" to be input
Variables can be of several types (plain types like strings, lists, maps
Terraform apply accepts to receive variables with the following form

```
terraform apply -var 'myvar1=myval1' -var 'myvar2=myval2'
```

Or if you want to have a file with that values, it should be called terraform.tfvars (it also will load all files that match this regex pattern *.auto.tfvars)

You can load any var file (with any name) with "-var-file" option in terraform apply

Another way to pass that values is by environment vars. All them have the following form

```
TF_VAR_myvar
```

## Output Variables

Terraform generates lots of usefull output information (like ips, results of provisionings, identifiers...) that could be valuable for other agents.
It's usually parametrized into its own blocks called "output"
Outputs will appear both in "terraform apply" and "terraform output"
If you are interested in a single output, you can summom it as follows

```
terraform output ip
```

## Modules

Self-contained packages of terraform configurations that are managed as a group. A way to package and reuse terraform configurations. There are lots of terraform modules ready to be used in registry
https://registry.terraform.io/

Following snipet of code uses the "consul" module

```
terraform {
  required_version = "0.11.11"
}
provider "aws" {
  access_key = "AWS ACCESS KEY"
  secret_key = "AWS SECRET KEY"
  region     = "us-east-1"
}

module "consul" {
  source = "hashicorp/consul/aws"

  aws_region  = "us-east-1" # should match provider region
  num_servers = "3"
}
```

## Importante notes

- Dependencies are the way terraform control which resources should be processed before others
- Resources can be linked. It allows to pass parameters from one resource to another one (like creating an elastic ip for a given EC2 instance). This creates an implicit dependency
- depends_on creates and explicit dependency
- Where possible, terraform will perform operations concurrently
- Go to https://www.terraform.io/docs/providers/index.html to get documentation of available providers and resources. This is like an API documentation endpoint

## Full example 

variables.tf
```
variable "access_key" {}
variable "secret_key" {}
variable "region" {
  default = "us-east-1"
}
variable "cidrs" { type = list }
variable "amis" {
  type = "map"
  default = {
    "us-east-1" = "ami-b374d5a5"
    "us-west-2" = "ami-4b32be2b"
  }
}
```

main.tf
```
provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = var.region
}

resource "aws_instance" "example" {
  ami           = "${lookup(var.amis, var.region)}"
  instance_type = "t2.micro"
  
  provisioner "local-exec" {
    command = "echo ${aws_instance.example.public_ip} > ip_address.txt"
  }
}

resource "aws_eip" "ip" {
  instance = aws_instance.example.id
}
```

output.tf
```
output "ip" {
	value = aws_eip.ip.public_ip
}
```

terraform.tfvars
```
access_key = "foo"
secret_key = "bar"
cidrs = [ "10.0.0.0/16", "10.1.0.0/16" ]
amis = {
  "us-east-1" = "ami-abc123"
  "us-west-2" = "ami-def456"
}

```
