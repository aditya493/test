$passphrase = 824c6013-5fb7-41be-b684-bb131afdd946
$inputFile = "secret.txt"
$outputFile = "decrypted_secret.txt"
openssl enc -aes-256-cbc -d -in $inputFile -out $outputFile -k $passphrase