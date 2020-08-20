RDS Proxy for aurora cluster terraform module

Provisions an RDS Proxy for an RDS Aurora cluster, using a cloudformation stack

The cloudformation stack is configured with DeletionPolicy: "Retain".
When official support for RDS Proxy is available you should import the resources and switch to it.
(You can track that here: https://github.com/terraform-providers/terraform-provider-aws/issues/12690)  