gpg --batch --passphrase "" --yes --no-default-keyring --keyring ./keys.keys --quick-generate-key "$USER" rsa4096 encr,sign 0
gpg --no-default-keyring --keyring ./keys.keys -a --export $USER > $USER.key
