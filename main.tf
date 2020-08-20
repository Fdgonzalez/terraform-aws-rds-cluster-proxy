resource "aws_cloudformation_stack" "dbproxy" {
  name = "DB-PROXY-${var.stage}"

  parameters = {
    SecretArn = var.db_secret_arn
    ProxyName = "DB-Proxy-${var.stage}"
    EngineFamily = var.engine_family
    RoleArn: aws_iam_role.proxy_secret_acess_role.arn
    VpcSecurityGroupIds: var.db_security_group
    VpcSubnetIds: join(", ", var.private_subnets)
    exportArn: "DB-PROXY-${var.stage}-arn"
    exportEndpoint: "DB-PROXY-${var.stage}-endpoint"
    ClusterId: var.db_cluster_identifier
    MaxConnectionsPercent: var.max_connections_percent
    MaxIdleConnectionsPercent: var.max_idle_connections_percent
    ConnectionBorrowTimeout: var.connection_borrow_timeout
  }
  timeout_in_minutes = 60
  template_body = file("${path.module}/DBProxy.yml")
}

resource "aws_iam_role" "proxy_secret_acess_role" {
  name               = "proxy_secret_access_role_${var.stage}"
  assume_role_policy = data.aws_iam_policy_document.task_assume.json
}

data "aws_iam_policy_document" "task_assume" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["rds.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy" "proxy_secret_access" {
  name   = "proxy_secret_access_${var.stage}"
  role   = aws_iam_role.proxy_secret_acess_role.id
  policy = data.aws_iam_policy_document.proxy_secret_access_policy.json
}

data "aws_iam_policy_document" "proxy_secret_access_policy" {
  statement {
    effect = "Allow"

    resources = [var.db_secret_arn]

    actions = ["secretsmanager:GetSecretValue"]
  }
}

