## UNITE Pseudonymization Service Interface

UNITE PSI installation scripts and configuration files

### Prerequisites
- Software
  - Docker
  - Docker compose
- Command line tools
  - git
  - jq (https://stedolan.github.io/jq)
  - mkcert (https://github.com/FiloSottile/mkcert)
  
### Folder Structure
- _docker-compose.yml_ - installation configuration
- _install.sh_ - installation script
- _uninstall.sh_ - uninstallation script
- _secrets_template.json_ - JSON configuration template file with all required credentials
- _config_template.json_ - JSON configuration template file with all required parameters

### Config
There is just one information in this file: The base url of the mainzelliste
```json
{
  "mainzelliste": {
    "baseUrl": "http://mainzelliste.url"
  }
}
```

### Secrets
All sensitive information is stored in **secrets.json** file. Template of this file is stored in unite-psi-environment repository on github. File has the following structure:
```json
{
  "api": {
    "key": "Defautl32BitApiKeyHasToBeChanged"
  },
  "github": {
    "user": "",
    "token": ""
  },
  "ldap": {
    "server": "",
    "port": "",
    "serviceUserRna": "",
    "serviceUserPassword": "",
    "userTargetOU": "",
    "authorizedUserIds": "dummyA,dummyB"
  },
  "mainzelliste": {
    "apiKey": ""
  }
}
```
Each section represents credentials for specific part of the platform services:
- _api_ - **API** key, used for user and service authentication
- _github_ - **user** name and personal access **token** with full repository permissions for accessing source code from private **Github** repositories (follow github [instructions](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token) to generate it)

To generate passwords one of command line tools can be used:
- `openssl rand -base64 22` - to generate 32 bit Base64 string

**!IMPORTANT: ALWAYS CHANGE ALL CREDENTIALS!**

**!IMPORTANT: NEVER COMMIT THIS FILE TO THE REPOSITORY!**

### Installation
1. Download **unite-psi-environment** source files from git repository
1. **Change credentials** in secrets_template.json and **rename** the file to **secrets.json**
1. **Change config parameters** in config_template.json and **rename** the file to **config.json**
1. Generate SSL certificate
   - For **localhost**: `sh generate-ssl.sh`
   - For **network**: `sh generate-ssl.sh <IP address or domain name>`
1. Install application
   - `sh install.sh`

### Uninstallation
To uninstall the application run:
- `sh uninstall.sh`
