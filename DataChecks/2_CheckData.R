suppressMessages(library(rgdal))

inDir <- "1_UnpackData/"
outDir <- "2_CheckData/"

load(paste(inDir,"unAdj.Rd",sep=""))

if (unAdj){
  fname1 <- "gpw-v4-population-density-adjusted-to-2015-unwpp-country-totals_2005.tif"
  fname2 <- "gpw-v4-population-density-adjusted-to-2015-unwpp-country-totals_2010.tif"
  fname3 <- "gpw-v4-population-density-adjusted-to-2015-unwpp-country-totals_2015.tif"
} else {
  fname1 <- "gpw-v4-population-density_2005.tif"
  fname2 <- "gpw-v4-population-density_2010.tif"
  fname3 <- "gpw-v4-population-density_2015.tif"
}

cat('Reading data: 2005\n')
pd2005 <- readGDAL(paste(inDir,fname1,sep=""),silent=TRUE)
cat('Reading data: 2010\n')
pd2010 <- readGDAL(paste(inDir,fname2,sep=""),silent=TRUE)
cat('Reading data: 2015\n')
pd2015 <- readGDAL(paste(inDir,fname3,sep=""),silent=TRUE)

df <- data.frame(pd2005=pd2005$band1,pd2010=pd2010$band1,pd2015=pd2015$band1)

rm(pd2005,pd2010,pd2015)
gc()

cat('Checking cell consistency')
na.2005 <- which(is.na(df$pd2005))
na.2010 <- which(is.na(df$pd2010))
na.2015 <- which(is.na(df$pd2015))

if (!(length(na.2005)==length(na.2010)) & (length(na.2005)==length(na.2015)) & (
  length(setdiff(na.2005,na.2010))==0) & (length(setdiff(na.2005,na.2010))==0)){
  cat("Warning: cells with data are not consistent between years")
}

rm(na.2005,na.2010,na.2015)
gc()

