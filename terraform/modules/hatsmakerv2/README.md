The configs in this section are modifications that build upon what is in the "hatsmaker" module.
These are separate so as not to break current versions.

The following changes have been made:
* New variables have been added:
    * short_name
    * service_name
    * cert_name
    * haproxy_template
    * service_ssl_port
    * service_ssl_ipv6_enabled
    * ipv6_address_count
    * service_ssl_backend_enabled
    * hats_id
    * env_type
    * env_certs
    * elk_domain
    * vector_log_index
    * haproxy_log_index

What services are currently using this module (as of 07-24-2020)?
* applicationAdminService
    * tvx-appds/us-east-1 (AE)
    * tvx-appds/us-west-2 (AW)
* appdiscoveryService
    * tvx-appds/us-east-1 (AE)
    * tvx-appds/us-east-2 (AO)
    * tvx-appds/us-west-2 (AW)
* cmTagDataService
    * tvx-appds/us-east-2 (AO)
* configuratorService
    * tvx-appds/us-east-1 (AE)
    * tvx-appds/us-east-2 (AO) \[Not active\]
    * tvx-appds/us-west-2 (AW)
* xconfAdminService
    * tvx-appds/us-east-1 (AE)
    * tvx-appds/us-west-2 (AW)
* xconfDataService
    * tvx-appds/us-east-1 (AE)
    * tvx-appds/us-east-2 (AO)
    * tvx-appds/us-west-2 (AW)
* customSplitEvaluator
    * tvx-appds/us-east-1 (AE)
    * tvx-appds/us-east-2 (AO)
    * tvx-appds/us-west-2 (AW)
