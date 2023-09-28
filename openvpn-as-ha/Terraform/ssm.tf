# Define the SSM document for automatic updates
resource "aws_ssm_document" "automatic_updates" {
  name          = "OpenVPNautomatic-updates"
  document_type = "Command"
  content = jsonencode({
    schemaVersion = "2.2"
    description   = "Install automatic updates on the instance"
    mainSteps = [
      {
        action = "aws:runShellScript"
        name   = "installupdates"
        inputs = {
          runCommand = [
            "apt-mark hold openvpn-as",
            "apt update -y",
            "apt update && apt upgrade -y",
          ]
        }
      }
    ]
  })
}

resource "aws_ssm_association" "my_ssm_association" {
  name = "AWS-RunAnsiblePlaybook"
  association_name = "MyAnsiblePlaybook"
  max_concurrency = "1"
  parameters = {
    check = "False"
    extravars = "SSM=True Version=${aws_s3_object.ansibleplaybook.etag}"
    playbookurl = "s3://${aws_s3_bucket.terraform-artifacts.bucket}/Ansible/server.yml"
    timeoutSeconds = "3600"
  }

  output_location {
    s3_bucket_name = REMOVED FOR SECURITY
    s3_key_prefix = "output"
  }

  targets {
    key = "tag:Purpose"
    values = [var.service_descriptor]
  }
  depends_on = [
    aws_db_instance.openvpn-as-rds
  ]
}
