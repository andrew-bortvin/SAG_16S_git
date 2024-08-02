f = open("SILVA_db/SILVA_138.1_SSURef_NR99_tax_silva.fasta", "r")
SILVA_cyano = open("SILVA_db/SILVA_138.1_SSURef_NR99_CYANO_ONLY.fasta", "w")

cyano = False # Boolean to check if we are in a line relevant for cyano sequences
for l in f:
	# Check if new sequence is cyano
	if l.startswith(">"):
		# New seq is cyano
		if "Cyanobacteria" in l: 
			SILVA_cyano.write(l)
			cyano = True 
		# New seq is not cyano
		else: 
			cyano = False 

	# If not a sequence header
	else:
		if cyano == True:
			# Print, replacing Uracil with Thymine
			SILVA_cyano.write(l.replace('U', 'T'))

f.close()
SILVA_cyano.close()