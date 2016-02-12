suppressMessages(library(foreign))

inDir <- "3_CheckData2/"
outDir <- "4_CheckData3/"

pd.data <- read.dbf(paste(inDir,"allyrs.dbf",sep=""))
names(pd.data) <- c("pd2005","pd2010","pd2015")

pd.data$ratio0510 <- pd.data$pd2010/pd.data$pd2005
pd.data$ratio0510[(pd.data$ratio0510==Inf)]<- NA

pd.data$ratio1015 <- pd.data$pd2015/pd.data$pd2010
pd.data$ratio1015[(pd.data$ratio1015==Inf)]<- NA

png(paste(outDir,"Data checks.png",sep=""),width = 17.5,height = 24,units = "cm",res = 1200)

par(mfrow=c(3,2))

par(las=1)
par(tck=-0.01)
par(mar=c(3,4,0.2,0.2))

plot(pd.data$pd2005+1,pd.data$pd2010+1,pch=16,cex=0.2,col="#00000011",
     log="xy",xlab="Population density (2005)",ylab=NA,yaxt="n",
     mgp=c(1.6,0.2,0))
axis(2,mgp=c(2.5,0.3,0))
title(ylab="Population density (2010)")

plot(pd.data$pd2010+1,pd.data$pd2015+1,pch=16,cex=0.2,col="#00000011",
     log="xy",xlab="Population density (2010)",ylab=NA,yaxt="n",
     mgp=c(1.6,0.2,0))
axis(2,mgp=c(2.5,0.3,0))
title(ylab="Population density (2015)")

par(mar=c(3,4,0.2,0.2))

brks <- c(0,0.5,0.75,1,1.25,1.5,2,5,10,15,20,25,33)

h <- hist(log(pd.data$ratio0510+1),breaks=log(brks+1),plot = FALSE)

barplot(height = log(h$counts+1),width = diff(log(brks+1)),space = 0,border=NA,yaxt="n")

axis(1,at=log(brks+1),labels=brks,mgp=c(2,0.2,0))
axis(2,at=log(c(0,10,50,500,5000,25000,4e5)+1),labels=c(0,10,50,500,5000,25000,4e5))
box(bty="l")
title(xlab="Population ratio 2010:2005",mgp=c(1.2,0.2,1))
title(ylab="Number of cells")

h <- hist(log(pd.data$ratio1015+1),breaks=log(brks+1),plot = FALSE)

barplot(height = log(h$counts+1),width = diff(log(brks+1)),space = 0,border=NA,yaxt="n")

axis(1,at=log(brks+1),labels=brks,mgp=c(2,0.2,0))
axis(2,at=log(c(0,10,50,500,5000,25000,4e5)+1),labels=c(0,10,50,500,5000,25000,4e5))
box(bty="l")
title(xlab="Population ratio 2015:2010",mgp=c(1.2,0.2,1))
title(ylab="Number of cells")

par(las=1)
par(tck=-0.01)
par(mar=c(3,3,0.2,0.2))

plot(pd.data$pd2005+1,pd.data$ratio0510+1,pch=16,cex=0.2,col="#00000011",
     log="xy",xlab="Population density (2005)",ylab=NA,yaxt="n",
     mgp=c(1.6,0.2,0))
axis(2,mgp=c(1.6,0.3,0),at=c(1,2,3,6,11,21,31),labels=c(0,1,2,5,10,20,30))
title(ylab="Population ratio 2010:2005",mgp=c(1.6,0.3,0))

plot(pd.data$pd2010+1,pd.data$ratio1015+1,pch=16,cex=0.2,col="#00000011",
     log="xy",xlab="Population density (2010)",ylab=NA,yaxt="n",
     mgp=c(1.6,0.2,0))
axis(2,mgp=c(1.6,0.3,0),at=c(1,2,3,6,11,21,31),labels=c(0,1,2,5,10,20,30))
title(ylab="Population ratio 2015:2010",mgp=c(1.6,0.3,0))

dev.off()
