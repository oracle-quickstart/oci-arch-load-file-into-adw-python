## Copyright (c) 2020, Oracle and/or its affiliates.
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

resource "oci_functions_application" "LoadFileIntoAdwFnApp" {
    compartment_id = var.compartment_ocid
    display_name = "LoadFileIntoAdwFnApp"
    subnet_ids = [oci_core_subnet.fnsubnet.id]
}

resource "oci_functions_function" "LoadFileIntoAdwFn" {
    depends_on = [null_resource.LoadFileIntoAdwFnPush2OCIR]
    application_id = oci_functions_application.LoadFileIntoAdwFnApp.id
    display_name = "LoadFileIntoAdwFn"
    image = "${var.ocir_docker_repository}/${var.ocir_namespace}/${var.ocir_repo_name}/loadfileintoadw:0.0.1"
    memory_in_mbs = "256" 
    config = { ords-base-url = "https://${substr(oci_database_autonomous_database.ADWdatabase.connection_urls[0].apex_url,8,21)}.adb.${var.region}.oraclecloudapps.com/ords/", db-schema =  "${var.db-schema}", db-user = "${var.db-user}", dbpwd-cipher = "${var.dbpwd-cipher}", input-bucket =  "${var.input-bucket}", processed-bucket = "${var.processed-bucket}"}
}

