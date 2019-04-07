apt update
apt install php git wget certbot php-soap -y

certbot --manual-public-ip-logging-ok --non-interactive --agree-tos -m j.j.dejosselindejong@gmail.com --server https://acme-v02.api.letsencrypt.org/directory \
certonly --manual --preferred-challenges=dns \
--manual-auth-hook /certbot-transip-dns-01-validator/auth-hook \
--manual-cleanup-hook /certbot-transip-dns-01-validator/cleanup-hook \
-d 'joict.nl' -d '*.joict.nl'
