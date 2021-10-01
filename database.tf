## Copyright (c) 2021, Oracle and/or its affiliates.
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

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

resource "null_resource" "soda_update" {
  depends_on = [oci_database_autonomous_database.ADWdatabase]

  provisioner "local-exec" {
    command = "curl -X PUT -u 'ADMIN:${var.dbpwd-cipher}' -H \"Content-Type: application/json\" https://${substr(oci_database_autonomous_database.ADWdatabase.connection_urls[0].apex_url, 8, 21)}.adb.${var.region}.oraclecloudapps.com/ords/admin/soda/latest/regionsnumbers"
  }
}

resource "null_resource" "soda_query" {
  depends_on = [null_resource.soda_update]

  provisioner "local-exec" {
    command = "curl -X POST -u 'ADMIN:${var.dbpwd-cipher}' -H \"Content-Type: application/json\" https://${substr(oci_database_autonomous_database.ADWdatabase.connection_urls[0].apex_url, 8, 21)}.adb.${var.region}.oraclecloudapps.com/ords/admin/soda/latest/regionsnumbers?action=query"
  }
}
