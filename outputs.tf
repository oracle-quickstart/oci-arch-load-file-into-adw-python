output "ADW_query_URL_for_JSON_formatted_with_python" {
 value = "curl -X POST -u 'ADMIN:${var.dbpwd-cipher}' -H \"Content-Type: application/json\" https://${substr(oci_database_autonomous_database.ADWdatabase.connection_urls[0].apex_url,8,21)}.adb.${var.region}.oraclecloudapps.com/ords/admin/soda/latest/regionsnumbers?action=query | python -m json.tool"
}