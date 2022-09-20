
# authors_dir: This is the directory with the files named with Pubmed ID, and containing only the authors inside it (get if from ../src/output_authors_to_txt.py)
# This is the directory containing the TXT files with the clusters, coming out of SpiCi (and post-processed using the Perl script spici to text) (get it with spici_clusters_to_files.pl)
# clusters_dir This is where the abstracts texts are stored (get it from ../src/output_abstracts_to_txt.py)

get_papers = function(authors_dir, clusters_dir, abstracts_dir){
    clusters = list.files(path = clusters_dir, full.names = F, pattern = "*.txt")
    papers = list.files(path = authors_dir, full.names = F, include.dirs = F)
    
    myClusters = list()
    myPapers = list()
    result = list()

    print("Reading cluster files.")
    
    for(i in 1:length(clusters)){
        myClusters[[i]] = read.table(paste(clusters_dir, clusters[i], sep="", collapse=""), sep = "\t", quote="", stringsAsFactors = F)
    }

    print("Reading papers' author list files.")
    
    for(j in 1:length(papers)){
        myPapers[[j]] = read.table(paste(authors_dir, papers[j], sep="", collapse = ""), sep = "\t", quote="", stringsAsFactors = F)
    }

    for(i in 1:length(myClusters)){
        clusterID = unlist(strsplit(clusters[i], "\\."))[1]

        print(paste("Finding papers enriched for", clusterID))

        result = vector()
        
        for(j in 1:length(myPapers)){
            white_balls = length(intersect(myClusters[[i]]$V1, myPapers[[j]]$V1))
            
            if(white_balls >= 3){
                result[j] = 1
            }
        }
        
        pos = which(result == 1)
        
        print(paste("       ***", length(pos), "papers enriched for this cluster."))
        
        if(length(pos) > 0){
            for(p in 1:length(pos)){
                paperPath = paste(abstracts_dir, papers[pos[p]], sep="", collapse = "")

                #print(paperPath)
                dir.create(clusterID, showWarnings = FALSE)

                #print(file.path(".", clusterID))
                file.copy(from=paperPath, to=file.path(".", clusterID), 
                          overwrite = TRUE, recursive = FALSE, 
                          copy.mode = TRUE)
                
            }
        }        
    }

}

































