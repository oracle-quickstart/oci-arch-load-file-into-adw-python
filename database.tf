## Copyright (c) 2021, Oracle and/or its affiliates.
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl


module "oci-adb" {
  source                                = "github.com/oracle-quickstart/oci-adb"
  adb_password                          = var.dbpwd-cipher
  compartment_ocid                      = var.compartment_ocid
  adb_database_cpu_core_count           = var.ADW_database_cpu_core_count
  adb_database_data_storage_size_in_tbs = var.ADW_database_data_storage_size_in_tbs
  adb_database_db_name                  = var.ADW_database_db_name
  adb_database_db_version               = var.ADW_database_db_version
  adb_database_display_name             = var.ADW_database_display_name
  adb_database_freeform_tags            = var.ADW_database_freeform_tags
  adb_database_license_model            = var.ADW_database_license_model
  adb_database_db_workload              = "DW"
  use_existing_vcn                      = false
  adb_private_endpoint                  = false
  defined_tags                          = { "${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}

/*
resource "oci_database_autonomous_database" "ADWdatabase" {
  admin_password           = var.dbpwd-cipher
  compartment_id           = var.compartment_ocid
  db_workload              = "DW"
  cpu_core_count           = var.ADW_database_cpu_core_count
  data_storage_size_in_tbs = var.ADW_database_data_storage_size_in_tbs
  db_name                  = var.ADW_database_db_name
  db_version               = var.ADW_database_db_version
  display_name             = var.ADW_database_display_name
  freeform_tags            = var.ADW_database_freeform_tags
  license_model            = var.ADW_database_license_model
  defined_tags             = { "${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }

  provisioner "local-exec" {
    command = "sleep 120"
  }
}
*/

resource "null_resource" "soda_update" {
  #  depends_on = [oci_database_autonomous_database.ADWdatabase]
  depends_on = [module.oci-adb.adb_database]

  provisioner "local-exec" {
    command = "sleep 120"
  }

  provisioner "local-exec" {
    #    command = "curl -X PUT -u 'ADMIN:${var.dbpwd-cipher}' -H \"Content-Type: application/json\" https://${substr(oci_database_autonomous_database.ADWdatabase.connection_urls[0].apex_url, 8, 21)}.adb.${var.region}.oraclecloudapps.com/ords/admin/soda/latest/regionsnumbers"
    command = "curl -X PUT -u 'ADMIN:${var.dbpwd-cipher}' -H \"Content-Type: application/json\" https://${substr(module.oci-adb.adb_database.connection_urls[0].apex_url, 8, 22)}.adb.${var.region}.oraclecloudapps.com/ords/admin/soda/latest/regionsnumbers"
  }
}

resource "null_resource" "soda_query" {
  depends_on = [null_resource.soda_update]

  provisioner "local-exec" {
    #    command = "curl -X POST -u 'ADMIN:${var.dbpwd-cipher}' -H \"Content-Type: application/json\" https://${substr(oci_database_autonomous_database.ADWdatabase.connection_urls[0].apex_url, 8, 21)}.adb.${var.region}.oraclecloudapps.com/ords/admin/soda/latest/regionsnumbers?action=query"
    command = "curl -X POST -u 'ADMIN:${var.dbpwd-cipher}' -H \"Content-Type: application/json\" https://${substr(module.oci-adb.adb_database.connection_urls[0].apex_url, 8, 22)}.adb.${var.region}.oraclecloudapps.com/ords/admin/soda/latest/regionsnumbers?action=query"
  }
}
