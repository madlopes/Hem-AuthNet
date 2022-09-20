#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Fri Sep 25 12:40:41 2020

@author: tiago
"""

from Bio import Medline

def getPapers():
    
    with open("../datasets/pubmed_hemophilia_records_1960-Feb_2022.txt") as handle:
    #with open("./tmp.txt") as handle:
        #print("{0}\t{1}\t{2}\t{3}\t{4}".format("PMID", "Title", "Abstract", "Journal", "Date"))
        
        records = Medline.parse(handle)
        
        for record in records:
            if("AB" in record and "AU" in record):
                if(len(record['AU']) > 1):
                  filename = record['PMID'] + '.txt'
                  text_file = open(filename, "w")
                  
                  for au in record['AU']:
                    text_file.write(au+'\n')
                  
                  text_file.close()

#            with open(record['PMID']+'.txt', 'w') as f:
 



if __name__ == "__main__":
    # execute only if run as a script
    getPapers()
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    