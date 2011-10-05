#!/bin/bash
set -e
cd /etc/keystone
rm -f keystone.db

# Tenants
keystone-manage $* tenant add admin
keystone-manage $* tenant add demo

# Users
keystone-manage $* user add demo secrete demo
keystone-manage $* user add admin secrete admin
keystone-manage $* user add serviceadmin secrete admin 

# Roles
keystone-manage $* role add Admin
keystone-manage $* role add KeystoneServiceAdmin
keystone-manage $* role add Member
keystone-manage $* role grant Admin admin
keystone-manage $* role grant KeystoneServiceAdmin serviceadmin

# Service
keystone-manage $* service add swift object-store 'Swift-compatible service'
keystone-manage $* service add nova compute 'OpenStack compute service'
keystone-manage $* service add nova_compat compute 'OpenStack compute service'
keystone-manage $* service add glance image  'OpenStack compute service'
keystone-manage $* service add identity identity  'OpenStack Identity service'

#endpointTemplates
keystone-manage $* endpointTemplates add RegionOne swift http://proxy01:8080/v1/AUTH_%tenant_id% http://proxy01:8080/ http://proxy01:8080/v1/AUTH_%tenant_id% 1 1
keystone-manage $* endpointTemplates add RegionOne nova_compat http://proxy01:8774/v1.0/ http://proxy01:8774/v1.0  http://proxy01:8774/v1.0 1 1
keystone-manage $* endpointTemplates add RegionOne nova http://proxy01:8774/v1.1/%tenant_id% http://proxy01:8774/v1.1/%tenant_id%  http://proxy01:8774/v1.1/%tenant_id% 1 1
keystone-manage $* endpointTemplates add RegionOne glance http://proxy01:9292/v1.1/%tenant_id% http://proxy01:9292/v1.1/%tenant_id% http://proxy01:9292/v1.1/%tenant_id% 1 1
keystone-manage $* endpointTemplates add RegionOne identity http://proxy01:5000/v2.0 http://proxy01:5001/v2.0 http://proxy01:5000/v2.0 1 1

# Tokens
keystone-manage $* token add tsC6Kqp79iL3wmIL admin admin 2015-02-05T00:00
keystone-manage $* token add 111222333444 serviceadmin admin '2015-02-05T00:00'

#Tenant endpoints
keystone-manage $* endpoint add admin 1
keystone-manage $* endpoint add admin 2
keystone-manage $* endpoint add admin 3
keystone-manage $* endpoint add admin 4
keystone-manage $* endpoint add admin 5
keystone-manage $* endpoint add admin 6

keystone-manage $* endpoint add demo 1
keystone-manage $* endpoint add demo 2
keystone-manage $* endpoint add demo 3
keystone-manage $* endpoint add demo 4
keystone-manage $* endpoint add demo 5
keystone-manage $* endpoint add demo 6
