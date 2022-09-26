variable "AWS_REGION" {
  default = "eu-west-2"
}
variable "AMI" {
  type = map
  default = {
     eu-west-2 = "ami-098828924dc89ea4a"
  }
}
