## UNITE Pseudonymization Service Interface
UNITE PSI installation scripts and configuration files.

### Prerequisites
- Software
  - Docker
  - Docker compose
- Command line tools
  - [mkcert](https://github.com/FiloSottile/mkcert)
  - [jq](https://stedolan.github.io/jq)
  
### Folder Structure
- _docker-compose.yml_ - deployment configuration.
- _docker-compose.build.yml_ - build configuration.
- _deploy.sh_ - deployment script.
- _build.sh_ - build script.
- _uninstall.sh_ - uninstallation script.
- _generate-ssl.sh_ - script to generate development SSL certificate.
- _configure.sh_ - host environment configuration script.

### Secrets
Secrets reuired to configure image build process are located in **config.json** file:
- _github.user_ - Github user name, used to connect to github docker registry.
- _github.token_ - Github user development (with all repository permissions), used to authorize github user.
- _source.path_ - Path to the source code directory, used to build the docker image.

Secrets required to configure the application are stored in **.env** file:
- _LDAP_SERVER_ - **LDAP Server Url** used to connect to Active Directory LDAP server for AD-User authentication.
- _LDAP_PORT_ - **LDAP Port** used to connect to Active Directory LDAP server. If it is not needed it can be left blank ("").
- _LDAP_SERVICE_USER_RNA_ - **LDAP Service User RNA** relative distinguished name of the service user that has access to the LDAP server in order to authenticate other user credentials.
- _LDAP_SERVICE_USER_PASSWORD_ - **LDAP Service User Password** of the service user that has access to the LDAP server in order to authenticate other user credentials.
- _LDAP_USER_TARGET_OU_ - **LDAP User Target OU** LDAP organizational unit of the users to be authenticated.
- _UPSI_API_KEY_ - 32 bit **API** key, used for authorization purposes.
- _UPSI_ADMIN_USER_ - Admin user. This option used only for dev purposes and doesnt work on production environment.
- _UPSI_ADMIN_PASSWORD_ - Admin password. This option used only for dev purposes and doesnt work on production environment.
- _UPSI_AUTHORIZED_USERS_ - Comma separated list of authorized users or "*" if all users are authorized to access.
- _ML_API_KEY_ - 32 bit **API** key, used by **Mainzelliste** for security purposes.
- _ML_DB_NAME_ - **Mainzelliste** database name.
- _ML_DB_USER_ - **Mainzelliste** database password.
- _ML_DB_PASS_ - **Mainzelliste** database password.

To generate passwords (eg. API key) one of command line tools can be used:
- `openssl rand -base64 22` - to generate 32 bit Base64 string.

**!IMPORTANT: ALWAYS CHANGE ALL CREDENTIALS!**

**!IMPORTANT: NEVER COMMIT THESE FILES OR CREDENTIALS TO THE REPOSITORY!**

### Installation
1. Download **unite-psi-env** source files from git repository.
1. **Change** credentials in **env_template** file and rename it to **.env**.
1. **Change** credentials in **config_template.json** file and rename it to **config.json**.
1. Generate SSL certificate
   - For **localhost**: `sh generate-ssl.sh`
   - For **network**: `sh generate-ssl.sh <IP address or domain name>`
1. Run **configure.sh** script to configure the application.
   - `sh configure.sh`
1. Deploy application
   - `sh deploy.sh`

### Mainzelliste configuration
For **Mainzelliste** configuration chage **mainzelliste.docker.conf** file according to official [documentation](https://bitbucket.org/medicalinformatics/mainzelliste/wiki/2.%20Mainzelliste%20Documentation.md#!mainzelliste-documentation).

### Uninstallation
To uninstall the application run:
- `sh uninstall.sh`
