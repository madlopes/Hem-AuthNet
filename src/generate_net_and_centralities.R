library(igraph)
library(BBmisc)
library(corrplot)
library(gplots)

mydata = read.table(text = gsub(",", "@", readLines("../datasets/authorNet.csv")), header=F, sep="@", stringsAsFactors = F, quote = "")

print("Done reading the input file")

# Generate the network
net = graph.data.frame(mydata, F)
net = simplify(net)
print("Done creating the graph")

# Calculate centrality measures
dg = degree(net)
bt = betweenness(net, normalized = T)
cl = closeness(net, normalized = T)
burts = constraint(net)
pr = page_rank(net)$vector
auth = authority_score(net)$vector
kcore = coreness(net)

print("Calculating the degree")

# Create the final data frame
net.centr = data.frame(node=V(net)$name, dg=NA, bt=NA, cl=NA, burts=NA, pr=NA, auth=NA, kcore=NA)

## Assign the centrality measures

net.centr$dg = dg[match(net.centr$node, names(dg))]
net.centr$bt = bt[match(net.centr$node, names(bt))]
net.centr$cl = cl[match(net.centr$node, names(cl))]
net.centr$burts = 1/burts[match(net.centr$node, names(burts))]
net.centr$pr = pr[match(net.centr$node, names(pr))]
net.centr$auth = auth[match(net.centr$node, names(auth))]
net.centr$kcore = kcore[match(net.centr$node, names(kcore))]

# Generate the correlation plot/heatmap
corrM = cor(net.centr[,2:8], method="spearman")
corrplot(corrM, method="color", type="lower", order="hclust", tl.col="black", tl.srt=45, addCoef.col = "black", col=redblue(30))
