
locals {
  role_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/REMOVED FOR SECURITY",
    "arn:aws:iam::aws:policy/REMOVED FOR SECURITY"
  ]
}

resource "aws_iam_instance_profile" "openvpn-as-ec2profile" {
  name = "openvpn-as-ec2-profile"
  role = aws_iam_role.openvpn-as-role.name
}

resource "aws_iam_role_policy_attachment" "openvpn-as-profileattach" {
  count = length(local.role_policy_arns)
  role       = aws_iam_role.openvpn-as-role.name
  policy_arn = element(local.role_policy_arns, count.index)
}

resource "aws_iam_role_policy" "openvpn-ec2-policy" {
  name = "openvpn-ec2-policy"
  role = aws_iam_role.openvpn-as-role.id
  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Action" : [
            "ssm:*"
            
          ],
          "Resource" : "*"
        }
      ]
    }
  )
}

resource "aws_iam_role" "openvpn-as-role" {
  name = "openvpn-as-ec2-role"
  path = "/"

  assume_role_policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Action" : "sts:AssumeRole",
          "Principal" : {
            "Service" : "ec2.amazonaws.com"
          },
          "Effect" : "Allow"
        }
      ]
    }
  )
}