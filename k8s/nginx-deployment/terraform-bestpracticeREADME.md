Composition

A composition consists of infrastructure modules, which consist of resources modules, which implement individual resources.

composition-1 {
  infrastructure-module-1 {
    data-source-1 => d1

    resource-module-1 {
      data-source-2 => d2
      resource-1 (d1, d2)
      resource-2 (d2)
    }

    resource-module-2 {
      data-source-3 => d3
      resource-3 (d1, d3)
      resource-4 (d3)
    }
  }
}

important files are :

main.tf - call modules, locals, and data sources to create all resources

variables.tf - contains declarations of variables used in main.tf

outputs.tf - contains outputs from the resources created in main.tf

versions.tf - contains version requirements for Terraform and providers


terraform plan and terraform apply both make cloud API calls to verify the status of resources

Managing a tfstate file in git is a nightmare


Use data sources and terraform_remote_state specifically as a glue between infrastructure modules within the composition

There are at least 5 distinct groups of orchestration solutions that developers use:

Terraform only. Very straightforward, developers have to know only Terraform to get the job done.

Terragrunt. Pure orchestration tool which can be used to orchestrate the entire infrastructure as well as handle dependencies. Terragrunt operates with infrastructure modules and compositions natively, so it reduces duplication of code.

In-house scripts. Often this happens as a starting point towards orchestration and before discovering Terragrunt.

Ansible or similar general purpose automation tool. Usually used when Terraform is adopted after Ansible, or when Ansible UI is actively used.

Crossplane and other Kubernetes-inspired solutions. Sometimes it makes sense to utilize the Kubernetes ecosystem and employ a reconciliation loop feature to achieve the desired state of your Terraform configurations. View video Crossplane vs Terraform for more information.

General conventions

Use _ (underscore) instead of - (dash) everywhere (in resource names, data source names, variable names, outputs, etc).

Prefer to use lowercase letters and numbers (even though UTF-8 is supported).

Resource and data source arguments
Do not repeat resource type in resource name (not partially, nor completely):

Copy
`resource "aws_route_table" "public" {}`


Resource name should be named this if there is no more descriptive and general name available, or if the resource module creates a single resource of this type (eg, in AWS VPC module there is a single resource of type aws_nat_gateway and multiple resources of typeaws_route_table, so aws_nat_gateway should be named this and aws_route_table should have more descriptive names - like private, public, database).

Always use singular nouns for names.

Use - inside arguments values and in places where value will be exposed to a human (eg, inside DNS name of RDS instance).

Include argument count / for_each inside resource or data source block as the first argument at the top and separate by newline after it.

Include argument tags, if supported by resource, as the last real argument, following by depends_on and lifecycle, if necessary. All of these should be separated by a single empty line.

When using conditions in an argumentcount / for_each prefer boolean values instead of using length or other expressions.

correct placement of tag:
resource "aws_nat_gateway" "this" {
  count = 2

  allocation_id = "..."
  subnet_id     = "..."

  tags = {
    Name = "..."
  }

  depends_on = [aws_internet_gateway.this]

  lifecycle {
    create_before_destroy = true
  }
}   


Conditions in count
outputs.tf:
resource "aws_nat_gateway" "that" {    # Best
  count = var.create_public_subnets ? 1 : 0
}

resource "aws_nat_gateway" "this" {    # Good
  count = length(var.public_subnets) > 0 ? 1 : 0
}

variable:
Order keys in a variable block like this: description , type, default, validation.
Always include description on all variables even if you think it is obvious (you will need it in the future).
Prefer using simple types (number, string, list(...), map(...), any) over specific type like object() unless you need to have strict constraints on each key.

Use type any to disable type validation starting from a certain depth or when multiple types should be supported.

Value {} is sometimes a map but sometimes an object. Use tomap(...) to make a map because there is no way to make an object

output:

Good structure for the name of output looks like {name}_{type}_{attribute} , where:

{name} is a resource or data source name

{name} for data "aws_subnet" "private" is private

{name} for resource "aws_vpc_endpoint_policy" "test" is test

{type} is a resource or data source type without a provider prefix

{type} for data "aws_subnet" "private" is subnet

{type} for resource "aws_vpc_endpoint_policy" "test" is vpc_endpoint_policy

{attribute} is an attribute returned by the output

If the output is returning a value with interpolation functions and multiple resources, {name} and {type} there should be as generic as possible (this as prefix should be omitted). See example.

If the returned value is a list it should have a plural name. See example.


Prefer try() (available since Terraform 0.13) over element(concat(...)) (legacy approach for the version before 0.13)

