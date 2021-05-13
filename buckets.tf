## Copyright (c) 2020, Oracle and/or its affiliates.
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

data "oci_objectstorage_namespace" "bucket_namespace" {
    compartment_id  = var.compartment_ocid
}

resource "oci_objectstorage_bucket" "input-bucket" {
    compartment_id        = var.compartment_ocid
    name                  = var.input-bucket
    namespace             = data.oci_objectstorage_namespace.bucket_namespace.namespace
    object_events_enabled = true
}

resource "oci_objectstorage_bucket" "processed-bucket" {
    compartment_id = var.compartment_ocid
    name           = var.processed-bucket
    namespace      = data.oci_objectstorage_namespace.bucket_namespace.namespace
}