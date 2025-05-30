ghb_usr=""
ghb_tkn=""

tput setaf 4; echo "# Logging in to UNITE docker registry"; tput sgr0
echo $ghb_tkn | docker login ghcr.io -u $ghb_usr --password-stdin
echo ""