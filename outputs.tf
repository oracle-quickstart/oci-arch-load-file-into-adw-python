## Copyright (c) 2021, Oracle and/or its affiliates.
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

output "ADW_query_URL_for_JSON_formatted_with_python" {
  #  value = "curl -X POST -u 'ADMIN:${var.dbpwd-cipher}' -H \"Content-Type: application/json\"  --data '{}' https://${substr(oci_database_autonomous_database.ADWdatabase.connection_urls[0].apex_url, 8, 21)}.adb.${var.region}.oraclecloudapps.com/ords/admin/soda/latest/regionsnumbers?action=query | python -m json.tool"
  value = "curl -X POST -u 'ADMIN:${var.dbpwd-cipher}' -H \"Content-Type: application/json\"  --data '{}' https://${substr(module.oci-adb.adb_database.connection_urls[0].apex_url, 8, 22)}.adb.${var.region}.oraclecloudapps.com/ords/admin/soda/latest/regionsnumbers?action=query | python -m json.tool"
}

output "ADWdatabase_connection_urls" {
  value = module.oci-adb.adb_database.connection_urls
}
