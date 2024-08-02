f = open("CyanoSeq1.1.2/CyanoSeq_1.1.2.fasta", "r")
outFile = open("CyanoSeq1.1.2/CyanoSeqSubset.fasta", "w")

targets = [">Kryptousia_macronema_CENA338_KY508610.1", ">Komarekiella_atlantica_CCIBT_3483_KX638487.1",
">Aphanizomenon_flos-aquae_PMC9707_AJ293130.1"]

found = False
for l in f:
	if l.strip() in targets:
		outFile.write(l)
		found = True
	elif found == True:
		if l.startswith(">"):
			found = False
		else:
			outFile.write(l)

f.close()
outFile.close()