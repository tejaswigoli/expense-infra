data "aws_ssm_parameter" "bastion_sg_id" {
  #/expense/dev/bastion_sg_id
  name = "/${var.project_name}/${var.environment}/bastion_sg_id"
}

data "aws_ssm_parameter" "public_subnet_ids" {
  #/expense/dev/public_subnet_ids
  name = "/${var.project_name}/${var.environment}/public_subnet_ids"
}

data "aws_ami" "Amazon Linux 2023 AMI" {

	most_recent      = true
	/*owners = ["973714476881"]*/
	
	filter {
		name   = "Amazon Linux 2023 AMI"
		values = ["01ff9fc7721895c6b"]
	}
	
	filter {
		name   = "root-device-type"
		values = ["ebs"]
	}

    filter {
        name   = "virtualization-type"
        values = ["hvm"]
    }
}
