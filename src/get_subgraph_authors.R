
get_subgraph = function(authorsFile, networkFile, outputFile){
    mydata = read.table(text = gsub(",", "@", readLines(networkFile)), header=F, sep="@", stringsAsFactors = F, quote = "")

    authors = read.table(authorsFile, sep="\t")

    print(authors)    
    result = data.frame(auth1=character(), auth2=character(), papers=integer())
    
    for(i in 1:nrow(mydata)){
        if(!is.na(match(mydata$V1[i], authors$V1)) & !is.na(match(mydata$V2[i], authors$V1))){
            result = rbind(result, mydata[i,])
        }
    }
    
    colnames(result) = c("auth1", "auth2", "papers")
    
    write.table(result, outputFile, sep="@", row.names = F, quote=F)
}

clusterFiles = list.files("../datasets/clusters_dir", pattern = "*.txt", full.names = T)
clusterFiles_nameOnly = list.files("../datasets/clusters_dir", pattern = "*.txt", full.names = F)

for(i in 1:length(clusterFiles)){
    get_subgraph(clusterFiles[i], "../results/tables/authorNet.csv", paste("subgraph_", clusterFiles_nameOnly[i], sep="", collapse = ""))
}