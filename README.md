## UNITE Pseudonymization Service Interface

UNITE PSI installation scripts and configuration files

### Prerequisites
- Software
  - Docker
  - Docker compose
- Command line tools
  - mkcert (https://github.com/FiloSottile/mkcert)
- Additional files
  - Prebuild docker image named "upsi" of https://github.com/dkfz-unite/unite-psi
  
### Folder Structure
- _docker-compose.yml_ - installation configuration
- _install.sh_ - installation script
- _uninstall.sh_ - uninstallation script
- _generate-ssl.sh_ - script to generate development SSL certificate

### Secrets
All sensitive information is stored in **docker-compose.yml** and needs to be set before you run the install script. The parameters are the following:
```yml
      JWT_KEY: "Defautl32BitApiKeyHasToBeChanged"
      LDAP_SERVER: ""
      LDAP_PORT: "thisCanBeEmpty"
      LDAP_SERVICE_USER_RNA: ""
      LDAP_SERVICE_USER_PASSWORD: ""
      LDAP_USER_TARGET_OU: ""
      LDAP_AUTHORIZED_USER_IDS: "dummyA,dummyB"
      MAINZELLISTE_BASE_URL: ""
      MAINZELLISTE_API_KEY: ""
```
Each parameter represents credentials for a specific part of the platform services:
- _JWT_KEY_ - **API** key, used for user and service authentication
- _LDAP_SERVER_ - **LDAP Server Url** used to connect to Active Directory LDAP server for AD-User authentication
- _LDAP_PORT_ - **LDAP Port** used to connect to Active Directory LDAP server. If it is not needed it can be left blank ("")
- _LDAP_SERVICE_USER_RNA_ - **LDAP Service User RNA** relative distinguished name of the service user that has access to the LDAP server in order to authenticate other user credentials
- _LDAP_SERVICE_USER_PASSWORD_ - **LDAP Service User Password** of the service user that has access to the LDAP server in order to authenticate other user credentials
- _LDAP_USER_TARGET_OU_ - **LDAP User Target OU** LDAP organizational unit of the users to be authenticated
- _LDAP_AUTHORIZED_USER_IDS_ - **LDAP User Ids** of the users that can have access to the pseudonymization service (example: "a123b,c456d,...")
- _MAINZELLISTE_BASE_URL_ - **Mainzelliste Url** used to do requests to Mainzelliste. (Mainzelliste instance to be used with this interface)
- _MAINZELLISTE_API_KEY_ - **Mainzelliste Api Key** used to do requests to Mainzelliste.

To generate passwords (eg. jwt key) one of command line tools can be used:
- `openssl rand -base64 22` - to generate 32 bit Base64 string

**!IMPORTANT: ALWAYS CHANGE ALL CREDENTIALS!**

**!IMPORTANT: NEVER COMMIT THIS FILE WITH FILLED CREDENTIALS TO THE REPOSITORY!**

### Installation
1. Provide prebuild docker image on environment named **upsi**
1. Download **unite-psi-environment** source files from git repository
1. **Change credentials** in docker-compose.yml
1. Generate SSL certificate
   - For **localhost**: `sh generate-ssl.sh`
   - For **network**: `sh generate-ssl.sh <IP address or domain name>`
1. Install application
   - `sh install.sh`

### Uninstallation
To uninstall the application run:
- `sh uninstall.sh`
