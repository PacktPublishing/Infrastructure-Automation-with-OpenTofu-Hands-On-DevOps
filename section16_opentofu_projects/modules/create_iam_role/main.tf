resource "aws_iam_role" "aws_iam_role" {
  name = var.role_name
  tags = {
    "Name" = var.name
  }
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "${var.service}.amazonaws.com"
        }
      },
    ]
  })
}