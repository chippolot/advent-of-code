import hashlib

str = "ckczppom"
i = 0
while True:
	secret_key = "{0}{1}".format(str,i)
	hash = hashlib.md5(secret_key).hexdigest()
	if hash.startswith("000000"):
		break
	i = i + 1
print i