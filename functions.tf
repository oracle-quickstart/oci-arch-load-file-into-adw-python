## Copyright (c) 2020, Oracle and/or its affiliates.
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

resource "oci_functions_application" "LoadFileIntoAdwFnApp" {
    compartment_id = var.compartment_ocid
    display_name = "LoadFileIntoAdwFnApp"
    subnet_ids = [oci_core_subnet.fnsubnet.id]
    defined_tags   = {"${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}

resource "oci_functions_function" "LoadFileIntoAdwFn" {
    depends_on = [null_resource.LoadFileIntoAdwFnPush2OCIR]
    application_id = oci_functions_application.LoadFileIntoAdwFnApp.id
    display_name = "LoadFileIntoAdwFn"
    image = "${local.ocir_docker_repository}/${local.ocir_namespace}/${var.ocir_repo_name}/loadfileintoadw:0.0.1"
    memory_in_mbs = "256" 
    config = { 
         "ORDS_BASE_URL": "https://${substr(oci_database_autonomous_database.ADWdatabase.connection_urls[0].apex_url,8,21)}.adb.${var.region}.oraclecloudapps.com/ords/", 
         "DB_SCHEMA": "${var.db-schema}",
         "DB_USER": "${var.db-user}",
         "DBPWD_CIPHER": "${var.dbpwd-cipher}",
         "INPUT_BUCKET": "${var.input-bucket}-${random_id.tag.hex}",
         "PROCESSED_BUCKET": "${var.processed-bucket}-${random_id.tag.hex}"
    }
    defined_tags   = {"${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}

