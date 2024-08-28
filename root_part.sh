#!/bin/bash

### We set up the kerberos config file to access to 42's kerberos server.

cat >> /etc/krb5.conf << EOF
[libdefaults]
default_realm = 42AMMAN.COM
forwardable = true
proxiable = true
dns_lookup_kdc = no
dns_lookup_realm = no
allow_weak_crypto = true
rdns = false
default_keytab_name = FILE:/etc/krb5.keytab

[realms]
42AMMAN.COM = {
        kdc = ldap.42amman.com
        default_domain = 42amman.com
        database_module = openldap_ldapconf
}

[domain_realm]
.42amman.com = 42AMMAN.COM
42amman.com = 42AMMAN.COM

EOF

### We set up the ssh config file to access to 42's git server (vogsphere)
### using your kerberos identification

cat >> /etc/ssh/ssh_config << EOF
Host *.42amman.com
     SendEnv LANG LC_*
     StrictHostKeyChecking no
     GSSAPIAuthentication yes
     GSSAPIDelegateCredentials yes
     PasswordAuthentication yes
EOF

echo "root part finished !"
