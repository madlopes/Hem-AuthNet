#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""

@author: tiago

In this version, I preprocess the Medline input file to remove duplicated records.
I do not know why, but sometimes there are duplicated records in the results
retrieved from Pubmed.

Feb 05 2022
"""

from Bio import Medline
import csv

def countPapers(inputFile):

  print("Counting papers by individual authors")
  
  with open(inputFile) as handle:
    
    
    records = Medline.parse(handle)
        
    authorPapers = dict()
    
    processedPapers = dict()
    
    for record in records:
      if("AB" in record and "AU" in record):

        if(record["PMID"] in processedPapers):
          next
        else:
          processedPapers[str(record["PMID"])] = str(record["PMID"])
        
          authorList = record['AU']
        
          #print(record['PMID'] + " " + record['TI'] + " " +str(authorList))
          
          for author in authorList:
            if author in authorPapers and author != "et al.":
              authorPapers[author] = authorPapers[author] + 1
            else:
              authorPapers[author] = 1
  return(authorPapers)


def getCollaboration(inputFile, authorPapers, minPapers_alone=2, minPapers_together=1):
  
  print("Creating collaboration network")
  with open(inputFile) as handle:
    records = Medline.parse(handle)
        
    authorGraph = dict()
    processedPapers = dict()
        
    for record in records:
      if("AB" in record and "AU" in record and record['PMID'] not in processedPapers):
        
        processedPapers[record['PMID']] = record['PMID'] # This is important to process each manuscript only once
        
        authorList = record['AU']
                    
        # This selects only manuscripts with more than one author
        # This is important because we are studying collaborations.
        if len(authorList) > 1: 
          for i in range(0, len(authorList)-1):
            author1 = authorList[i]
            
            for j in range(i+1, len(authorList)):
            
              author2 = authorList[j]
            
              if author1 == author2 or authorPapers[author1] < minPapers_alone or authorPapers[author2] < minPapers_alone or author1 == "et al." or author2 == "et al.":
                next
              else:
                
                edge = ''
                
                #print(author1 + " " + author2)
                if author1 > author2:
                  edge = author1 + '@' + author2
                else:
                  edge = author2 + '@' + author1

                if edge in authorGraph:
                  authorGraph[edge] = authorGraph[edge] + 1
                else:
                  authorGraph[edge] = 1

    authorGraph = {k: v for k, v in authorGraph.items() if v >= minPapers_together}
        
    return(authorGraph)

def countNodes(tmpNet):
  
  authorCount = dict()
  
  for k, v in tmpNet.items():
    authors = k.split("@")

    authorCount[authors[0]] = 1
    authorCount[authors[1]] = 1
      
  return(len(authorCount))

if __name__ == "__main__":
  
  authorPaperNum = countPapers("../datasets/pubmed_hemophilia_records_1960-Feb_2022.txt")
  
  # The final network is:

  finalNet = getCollaboration("../datasets/pubmed_hemophilia_records_1960-Feb_2022.txt", authorPaperNum, minPapers_alone = 2, minPapers_together=1)

  # Write to the disk

  print("Writing to the disk")
  
  with open('authorNet.csv', 'w') as csv_file:  
      writer = csv.writer(csv_file)
      
      for key, value in finalNet.items():
         writer.writerow([key, value])
  
  ## Write the number of papers by each author
  with open('authorPapers.csv', 'w') as csv_file:  
      writer = csv.writer(csv_file)
      
      for key, value in authorPaperNum.items():
         writer.writerow([key, value])
  
  print("Done! Have a nice night.")
    
    
    
    
    
    
    
    
    
    
    
    
    