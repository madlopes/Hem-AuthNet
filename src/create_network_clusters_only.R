
source("../src/generate_net_and_centralities.R")

myFiles = list.files("../results/clusters/", "*.txt", full.names = T)

# Creates the first graph-cluster
clusterNet = ""

for(i in 1:length(myFiles)){
    print(myFiles[i])
    
    if(i == 1){
        tmpFile = read.table(myFiles[i], sep="\t", quote="")
        clusterNet = induced.subgraph(net, match(tmpFile$V1, V(net)$name))
    }
    else{
        tmpFile = read.table(myFiles[i], sep="\t", quote="")
        tmpNet = induced.subgraph(net, match(tmpFile$V1, V(net)$name))
        
        #V(tmpNet)$name <- V(tmpNet)$label
        #V(clusterNet)$name <- V(clusterNet)$label
        
        attrs <- rbind(as_data_frame(tmpNet, "vertices"), as_data_frame(clusterNet, "vertices")) %>% unique()
        el <- rbind(as_data_frame(tmpNet), as_data_frame(clusterNet))

        clusterNet <- graph_from_data_frame(el, directed = FALSE, vertices = attrs)
    }
}






