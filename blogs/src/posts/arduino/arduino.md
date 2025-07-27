# get fingerprint thumb
`echo | openssl s_client -connect home.phammanh.info:443 |& openssl x509 -fingerprint -noout`