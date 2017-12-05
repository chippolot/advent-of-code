def rle(str):
	run_len = 0
	run_chr = str[0]
	enc_str = ""
	for i in range(0, len(str) + 1):
		chr = str[i] if i < len(str) else None
		if chr != run_chr:
			enc_str += "{}{}".format(run_len, run_chr)
			run_len = 0
		run_chr = chr
		run_len += 1
	return enc_str

res = "3113322113"
for i in range(0, 50):
	res = rle(res)
print len(res)