suppressMessages(library(rgdal))
suppressMessages(library(RColorBrewer))

dataDir <- "0_data/"
inDir <- "3_CheckData2/"
outDir <- "5_MapData/"

setwd(dataDir)
outline <- readOGR(".","outline_clip2",verbose = FALSE)
setwd("..")

cat("Reading map for 2005-2010\n")

ratio0510 <- readGDAL(fname = paste(inDir,"/Ratio0510",sep=""),silent = TRUE)

cat("Plotting map for 2005-2010\n")

png(paste(outDir,"Ratio2005-2010.png",sep=""),width = 17.5,height = 9,units = "cm",res = 1200)

par(mar=c(0,0,0,0))

plot(outline,border=NA,col="#666666")

image(ratio0510,breaks=c(0,0.5,1,2,5,25,50),col=brewer.pal(11,"RdYlBu")[c(9,8,4,3,2,1)],add=TRUE)

legend(-180,20,c("0-0.5","0.5-1.0","1.0-2.0","2.0-5.0","2.0-25.0",">25.0"),fill=brewer.pal(11,"RdYlBu")[c(9,8,4,3,2,1)])

invisible(dev.off())

cat("Reading map for 2010-2015\n")

ratio1015 <- readGDAL(fname = paste(inDir,"/Ratio1015",sep=""),silent=TRUE)

cat("Plotting map for 2010-2015\n")

png(paste(outDir,"Ratio2010-2015.png",sep=""),width = 17.5,height = 9,units = "cm",res = 1200)

par(mar=c(0,0,0,0))

plot(outline,border=NA,col="#666666")

image(ratio1015,breaks=c(0,0.5,1,2,5,25,50),col=brewer.pal(11,"RdYlBu")[c(9,8,4,3,2,1)],add=TRUE)

legend(-180,20,c("0-0.5","0.5-1.0","1.0-2.0","2.0-5.0","2.0-25.0",">25.0"),fill=brewer.pal(11,"RdYlBu")[c(9,8,4,3,2,1)])

invisible(dev.off())
