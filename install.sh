#!/bin/bash

ghb_tkn=$(jq -r .github.token secrets.json)
jwt_key=$(jq -r .api.key secrets.json)
ldap_srv=$(jq -r .ldap.server secrets.json)
ldap_port=$(jq -r .ldap.port secrets.json)
ldap_su_rna=$(jq -r .ldap.serviceUserRna secrets.json)
ldap_su_pw=$(jq -r .ldap.serviceUserPassword secrets.json)
ldap_u_t_ou=$(jq -r .ldap.userTargetOU secrets.json)
ldap_a_u_ids=$(jq -r .ldap.authorizedUserIds secrets.json)
ml_api_key=$(jq -r .mainzelliste.apiKey secrets.json)

ml_base_url=$(jq -r .mainzelliste.baseUrl config.json)

tput setaf 6; echo "# Installing UNITE Pseudonymization Service Interface"; tput sgr0

tput setaf 4; echo "# Cleaning up source code directory"; tput sgr0
rm -r -f src

tput setaf 4; echo "# Cloning fresh code to source code directory"; tput sgr0
git clone https://$ghb_tkn@github.com/dkfz-unite/unite-psi.git src
echo ""

tput setaf 4; echo "# Building and running docker image"; tput sgr0
JWT_KEY=$jwt_key \
LDAP_SERVER=$ldap_srv \
LDAP_PORT=$ldap_port \
LDAP_SERVICE_USER_RNA=$ldap_su_rna \
LDAP_SERVICE_USER_PASSWORD=$ldap_su_pw \
LDAP_USER_TARGET_OU=$ldap_u_t_ou \
LDAP_AUTHORIZED_USER_IDS=$ldap_a_u_ids \
MAINZELLISTE_API_KEY=$ml_api_key \
MAINZELLISTE_BASE_URL=$ml_base_url \
docker-compose -p '' -f docker-compose.yml up -d --build