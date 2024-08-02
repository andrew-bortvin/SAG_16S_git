import sys

name = sys.argv[1]
to_assemble = sys.argv[2].split(",")
informative = sys.argv[3].split(",")

f = open("scaffold_assembly/" + name + "/" + name + ".aln")

scaffolds = {}

# Fill in dictionary
for l in f:
	if l.startswith(">"):
		header = l.strip().lstrip(">lcl|").lstrip("_R_").split("_")[1]
		scaffolds[header] = ""
	else:
		scaffolds[header] += l.strip()

f.close()

out = open("scaffold_assembly/" + name + "/" + name + "_aligned.fasta", "w")
out.write(">" + name + "\n")

assembled_sets = []
for i in range(len(scaffolds["1"])):
	# Get all nts in sequences to assemble, filtering out any gaps
	# Convert to a set - will be len 1 if all assemblies agree, will be len > 1 
	assembled_sets.append(set([scaffolds[x][i] for x in to_assemble if scaffolds[x][i] != "-"]))

def get_concensus(index, d, informative_names):
	# function gets the most common nt within a sequence at a given position
	# index - position to search at
	# d - dictionary of sequences to search through
	# informative_names - which keys to consider
	nts = []
	for i in informative_names:
		if d[i][index] != "-":
			nts.append(d[i][index])

	count_dict = {}
	for i in nts:
		count_dict.setdefault(i, 0)
		count_dict[i] += 1

	counts = list(count_dict.values())
	counts.sort(reverse = True)
	if counts[0] == counts[1]:
		return "-"
	else:
		for k,v in count_dict.items():
			if v == counts[0]:
				return k
		


assembled = ""
for i in range(len(assembled_sets)):
	s = assembled_sets[i]
	if len(s) == 0:
		assembled += "-"
	elif len(s) == 1:
		assembled += list(s)[0]
	elif len(s) > 1:
		assembled += get_concensus(i, scaffolds, informative)

out.write(assembled + "\n") 
out.close()
