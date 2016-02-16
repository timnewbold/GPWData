inDir <- "0_data/"
outDir <- "1_UnpackData"

unAdj <- read.table(paste(inDir,"unAdj.csv",sep=""))[1,1]

if (unAdj){
  fname1 <- "/gpw-v4-population-density-adjusted-to-2015-unwpp-country-totals-2005.zip"
  fname2 <- "/gpw-v4-population-density-adjusted-to-2015-unwpp-country-totals-2010.zip"
  fname3 <- "/gpw-v4-population-density-adjusted-to-2015-unwpp-country-totals-2015.zip"
} else {
  
}

cat('2005\n')
unzip(zipfile = paste(inDir,fname1,sep=""),
      exdir = paste("./",outDir,sep=""))
cat('2010\n')
unzip(zipfile = paste(inDir,fname2,sep=""),
      exdir = paste("./",outDir,sep=""))
cat('2015\n')
unzip(zipfile = paste(inDir,fname3,sep=""),
      exdir = paste("./",outDir,sep=""))

save(unAdj,file = paste(outDir,"/unAdj.Rd",sep=""))