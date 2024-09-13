variable "resourcegroup" {
  type        = map(any)
}
variable "dev_sub_id" {
  type = string
 default = "47c6b6cb-f5a9-4816-b672-ec5dc38c2dc0"
}
variable "prod_sub_id" {
  type = string
  default = "00b9c8ab-f7d4-4c4f-ac56-7e2b38ca92de"
}
