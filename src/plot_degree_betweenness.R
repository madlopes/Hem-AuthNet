top_quant_dg = quantile(net.centr$dg, (100 - 1)/100)
top_quant_bt = quantile(net.centr$bt, (100 - 1)/100)

a = net.centr[which(net.centr$dg > top_quant_dg & net.centr$bt > top_quant_bt),]
net.centr_new = net.centr[-match(a$bt, net.centr$bt),]

plot(net.centr_new$dg, log(net.centr_new$bt), pch=19, col="#4393C3", las=1, ylim=c(-23, -1), xlim=c(0,650))
points(a$dg, log(a$bt), col="#F4A582", pch=19)

grid()
