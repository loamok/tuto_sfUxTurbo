#!/bin/bash

if [ ! -e ../../config/jwt/public.pem ]; then

    mkdir -p ../../config/jwt ; 
    cd ../../config/jwt ;
    jwt_passphrase=${JWT_PASSPHRASE:-$(grep ''^JWT_PASSPHRASE='' ../../.env.local | cut -f 2 -d ''='')};
    if [ ! -f public.pem ] ; then echo ${jwt_passphrase} | openssl genpkey -out private.pem -pass stdin -aes256 -algorithm rsa -pkeyopt rsa_keygen_bits:4096; fi
    if [ ! -f public.pem ] ; then echo ${jwt_passphrase} | openssl pkey -in private.pem -passin stdin -out public.pem -pubout; fi;
    setfacl -R -m u:www-data:rX -m u:"$(whoami)":rwX ../../config/jwt
    setfacl -dR -m u:www-data:rX -m u:"$(whoami)":rwX ../../config/jwt
    if [ "${APPLY_ACL_TO_ROOT}" == "1" ] ; then
        setfacl -R -m u:www-data:rX -m u:"$(whoami)":rwX ../../config/jwt
        setfacl -dR -m u:www-data:rX -m u:"$(whoami)":rwX ../../config/jwt
    fi
fi
