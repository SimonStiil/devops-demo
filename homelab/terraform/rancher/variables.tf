variable "BOOTSTRAP_PASSWORD" {
    type        = string
    description = "the bootstrap password set up for communication with rancher"
}
variable "TESTUSER_PASSWORD" {
    type        = string
    description = "the password for testuser"
}
variable "TESTUSER_NAME" {
    type        = string
    description = "the name for testuser"
}
variable "dn_base" {
    type        = string
	default     = "dc=simon,dc=stiil,dc=dk"
    description = "search base for users"
}
variable "service_account_uid" {
    type        = string
	default     = "uid=root"
    description = "service account user"
}
variable "LDAP_SA_PASSWORD" {
    type        = string
	default     = "uid=root"
    description = "service account user"
}
