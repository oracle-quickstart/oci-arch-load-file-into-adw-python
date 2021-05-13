## Copyright (c) 2020, Oracle and/or its affiliates.
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

variable "tenancy_ocid" {}
variable "user_ocid" {}
variable "fingerprint" {}
variable "private_key_path" {}
variable "compartment_ocid" {}
variable "region" {}

variable "release" {
  description = "Reference Architecture Release (OCI Architecture Center)"
  default     = "1.0"
}

variable "dbpwd-cipher" {}

variable "db-schema" {
 default = "admin"
}

variable "db-user" {
 default = "admin"
}

variable "input-bucket" {
  default = "input-bucket"
}

variable "processed-bucket" {
  default = "processed-bucket"
}

variable "VCN-CIDR" {
  default = "10.0.0.0/16"
}

variable "fnsubnet-CIDR" {
  default = "10.0.1.0/24"
}

variable "ADW_database_cpu_core_count" {
  default = 1
}

variable "ADW_database_data_storage_size_in_tbs" {
  default = 1
}

variable "ADW_database_db_name" {
  default = "adwdb"
}

variable "ADW_database_db_version" {
  default = "19c"
}

variable "ADW_database_defined_tags_value" {
  default = ""
}

variable "ADW_database_display_name" {
  default = "ADW"
}

variable "ADW_database_freeform_tags" {
  default = {
    "Owner" = ""
  }
}

variable "ADW_database_license_model" {
  default = "LICENSE_INCLUDED"
}

variable "ocir_repo_name" {
  default = "functions"
}

variable "ocir_user_name" {
  default = ""
}

variable "ocir_user_password" {
  default = ""
}


# OCIR repo name & namespace

locals {
  ocir_docker_repository = join("", [lower(lookup(data.oci_identity_regions.oci_regions.regions[0], "key" )), ".ocir.io"])
  ocir_namespace = lookup(data.oci_identity_tenancy.oci_tenancy, "name" )
}
