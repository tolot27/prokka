#!/bin/bash
# prokka-uniprot_to_fasta_db requires http://swissknife.sourceforge.net
#wget -c ftp://ftp.uniprot.org/pub/databases/uniprot/current_release/knowledgebase/taxonomic_divisions/uniprot_sprot_bacteria.dat.gz
FTP_DIR="/pub/databases/uniprot/current_release/knowledgebase/taxonomic_divisions"
lftp -v -c "set xfer:destination-directory ${OUT_DIR}; open ftp://ftp.uniprot.org; mget -P 5 -c ${FTP_DIR}/uniprot_sprot_bacteria.dat.gz ${FTP_DIR}/uniprot_sprot_viruses.dat.gz ${FTP_DIR}/uniprot_sprot_archaea.dat.gz"
pigz -d uniprot_sprot_*.dat.gz
prokka-uniprot_to_fasta_db uniprot_sprot_bacteria.dat > kingdom/Bacteria/sprot
prokka-uniprot_to_fasta_db uniprot_sprot_viruses.dat > kingdom/Viruses/sprot
prokka-uniprot_to_fasta_db uniprot_sprot_archaea.dat > kingdom/Archaea/sprot
#prokka-uniprot_to_fasta_db --verbose uniprot_sprot_archaea.dat > kingdom/Archaea/sprot
prokka --setupdb
