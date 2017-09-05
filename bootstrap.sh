#!/usr/bin/env bash

# ---------------------------------------
#          Virtual Machine Setup
# ---------------------------------------

# Adding multiverse sources.
cat > /etc/apt/sources.list.d/multiverse.list << EOF
deb http://archive.ubuntu.com/ubuntu trusty multiverse
deb http://archive.ubuntu.com/ubuntu trusty-updates multiverse
deb http://security.ubuntu.com/ubuntu trusty-security multiverse
EOF


# Updating packages
apt-get update

# ---------------------------------------
#          Apache Setup
# ---------------------------------------

# Installing Packages
apt-get install -y apache2 libapache2-mod-fastcgi

# Add ServerName to httpd.conf
httpd=$(cat <<EOF
ServerName localhost
RewriteEngine on
EOF
)

echo $httpd > /etc/apache2/conf-available/httpd.conf 

cert=$(cat <<EOF
-----BEGIN CERTIFICATE-----
MIIDajCCAlICCQCMQMQZdfLh/DANBgkqhkiG9w0BAQsFADB3MQswCQYDVQQGEwJJ
TjELMAkGA1UECAwCTUgxDTALBgNVBAcMBFBVTkUxDDAKBgNVBAoMA0FCQzEMMAoG
A1UECwwDWFlaMRAwDgYDVQQDDAdBQkMgWFlaMR4wHAYJKoZIhvcNAQkBFg9hYmNA
ZXhhbXBsZS5jb20wHhcNMTcwOTA0MTgzNDU4WhcNMTgwOTA0MTgzNDU4WjB3MQsw
CQYDVQQGEwJJTjELMAkGA1UECAwCTUgxDTALBgNVBAcMBFBVTkUxDDAKBgNVBAoM
A0FCQzEMMAoGA1UECwwDWFlaMRAwDgYDVQQDDAdBQkMgWFlaMR4wHAYJKoZIhvcN
AQkBFg9hYmNAZXhhbXBsZS5jb20wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEK
AoIBAQDWpvgzNBK6CkKv88hqtUDl/bXI9k4dC+2t5fjRc3BaiYtE8kltNXabDHqc
FeKzirzNwOI5v4gezK9MrZR+2iyWppaobCUdWGlFS+GUZJRIkV2wkgFI8uTr7XOB
Kz0W2/tBSXnlW6BeHQ6ktBADVgJjaKw5STXhQkptjCizmDBmnkdmJi99e9EH7JGc
IwM/pQHZ2PTBNZPMbe5DEfxP1zDYfxdWnTrnboTGy40F9+dDQUxSCCbDvgWZ6LGw
S4VKG/am2zP/dGmbCkpFYN/fRra5Wm50uZ4dYqmqhJpn+nJAnf0kvo6dx+SDcqeZ
4lsEpCNEUpxtP3WyWS/IxZj3qyvrAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAHn3
Jf+AzJ5NQTgkbNi5uXuegLf+i+Qv6g616eU6t1n/oOmuNwb0p1hmomzHSyRvT07J
FEd5z7Qsp7jdT9yqYODjGMYEP2CHXzn7MZ+Ioe+qKnEcYlRWjjMtgoGG7CIrOgMB
WN35Pz4ea+yYC+Ite56lK7SpUtm7ySOPAjIx7fuuW9PKtfWZCVRugwgBaGtoHPYi
6CinLG38qHBtCV4SfWQv7qB3w8oTCE3Y22EIdplCrj0PiPaoxEAP61Bebm1WHWTC
O1Zqe9u6pgBnakQqYm7jfBv680KJp1fawfbhKOv0UMMSIe5+xLwXu1T9+aC69Gte
npK4kzK/XWznuDDZ2Zk=
-----END CERTIFICATE-----
EOF
)

newkey=$(cat <<EOF
-----BEGIN RSA PRIVATE KEY-----
MIIEpQIBAAKCAQEA1qb4MzQSugpCr/PIarVA5f21yPZOHQvtreX40XNwWomLRPJJ
bTV2mwx6nBXis4q8zcDiOb+IHsyvTK2UftoslqaWqGwlHVhpRUvhlGSUSJFdsJIB
SPLk6+1zgSs9Ftv7QUl55VugXh0OpLQQA1YCY2isOUk14UJKbYwos5gwZp5HZiYv
fXvRB+yRnCMDP6UB2dj0wTWTzG3uQxH8T9cw2H8XVp06526ExsuNBffnQ0FMUggm
w74FmeixsEuFShv2ptsz/3RpmwpKRWDf30a2uVpudLmeHWKpqoSaZ/pyQJ39JL6O
ncfkg3KnmeJbBKQjRFKcbT91slkvyMWY96sr6wIDAQABAoIBAGstVZKjdpJD20Zl
r/Vv6SatRp5ANYKVWSjSQim6vSfHs61KWNVZs435biMPXnGNXXZSz+JLuxi91O2x
YgrwvwC9z03rKaD8axu5prnkepG9W411aYTWGu2eU2T0hP0r+8l+eYnG9Uzor04X
xkMUJ/8g3ZWA85E0+1q1eAEshUZG6O4+QIqIoROgnmd9+TVvvStdsGZQpELw9rSL
+goJNnsmwCCEnr4ehX1pdyfadIYokQAdmFdMa+iqS9y4pyebcP2q4WXgIBoAUJR/
Nx5OCD2f1E0+NadF0vrTfB5q7A+MWGF9c4XxSMVLsbgRJj1+s58DqelAcGiotwq7
n//GJ1ECgYEA+28T8pMYwP68R25LBnfsu0bYheMVgCrIxsLSE01LiKyfshsC4sat
C7hOdSHJe2JPAoS8dIENOcjiPSZ8yIeYCKJezymOrYk7eehPTt2fZjtkesVdwUbJ
Nc7awGbvthaWxCyNx0uKiw5ndmcVVKnl9o1fAlE9K3AYM7FPn7xJn7kCgYEA2ozk
i0hdwvOTTOyWSkglh8W2i1wiS0IJF1eMPKvus/VJvhBLn+6FSK2dIARmhtkzYl6R
k+o8LGbOs+IKuhkPKcVGbbuDaYyLIWfvy+dRwVJQd6ecHaJqJrk+0nyYFub813Y9
bb31ms7b1oVmU6Kfj7hTg/plxemHi377CIv3ksMCgYEA5Hrh45Lr8aUKLtb48l3U
D7KnW7MpfJhkbsnm4Idi1kYXsF9/Vdg4s+e91A7p6mdBaQZ5wlzrSdFUVUE+L3OY
InB6O0KGVwfXtkX2m7IlAV+DRVVIhzPt8CmS+zgPKKaKRqY+CBaLRSXHuv6dkZv6
TvvUlGSCc5CfTYoY0wzk0nECgYEAhWuoBmPKYb6jeT2hzn1W9Bk+hLtdcEZDGI3o
3g00b4ZaW37FPEC3+5OJrcch9Eba+L207/D6hTzKCcUAOXYc7KozgcAMzL3xHha+
rONt5LBk0XdwdiL13OgQMx2/F5QyXTMg80MZkkWgrcjInFxWPr4Pti2CPh2AEygV
BrW0EVMCgYEA8JcAcbb1bsNB1YNk5Rj1nPbQiZDIUlMzIkmnToXyLUmFCpXlvDyk
URIVQPcgXKqBWBx5sWZ4GhMwktcFvNAFJV7PoTnZWQPgYcI7d14ril4RcEBNgl/n
EpQkp2Qxg5M8vFDv0OCGrIxtbQ5PEixOGN11YC/KO7ogHVm8pACbcFs=
-----END RSA PRIVATE KEY-----
EOF
)

echo $cert > /etc/apache2/server.crt
echo $newkey > /etc/apache2/server.key

chmod 400 /etc/apache2/server.key
chmod 400 /etc/apache2/server.crt

# Setup hosts file
VHOST=$(cat <<EOF
<IfModule mod_ssl.c>
  <VirtualHost _default_:443>
    DocumentRoot "/var/www/html"
    ServerName localhost
    SSLEngine on
    SSLCertificateFile /etc/apache2/server.crt
    SSLCertificateKeyFile /etc/apache2/server.key
    <FilesMatch "\.(cgi|shtml|phtml|php)$">
	SSLOptions +StdEnvVars
    </FilesMatch>
    <Directory "/var/www/html">
        AllowOverride All
	SSLOptions +StdEnvVars
    </Directory>
  </VirtualHost>
</IfModule>
EOF
)

echo "${VHOST}" > /etc/apache2/sites-available/default-ssl.conf

VHOST1=$(cat <<EOF
<VirtualHost *:80>
  DocumentRoot "/var/www/html"
  ServerName localhost
  <Directory "/var/www/html">
    AllowOverride All
  </Directory>
  Redirect permanent / https://localhost
</VirtualHost>
EOF
)

echo "${VHOST1}" > /etc/apache2/sites-available/000-default.conf


# Loading needed modules to make apache work
a2enmod actions fastcgi rewrite ssl
service apache2 reload

# Install memcached 
apt-get install memcached

memcache=$(cat <<EOF
-d

logfile /var/log/memcached.log

-m 64

-p 11211

-u memcache

-l 127.0.0.1

-c 1024
EOF
)

echo $memcache > /etc/memcached.conf

apt-get install python python-pip

