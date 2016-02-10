inDir <- "0_data/"
outDir <- "1_UnpackData"

cat('2005\n')
unzip(zipfile = paste(inDir,"/gpw-v4-population-density-adjusted-to-2015-unwpp-country-totals-2005.zip",sep=""),
      exdir = paste("./",outDir,sep=""))
cat('2010\n')
unzip(zipfile = paste(inDir,"/gpw-v4-population-density-adjusted-to-2015-unwpp-country-totals-2010.zip",sep=""),
      exdir = paste("./",outDir,sep=""))
cat('2015\n')
unzip(zipfile = paste(inDir,"/gpw-v4-population-density-adjusted-to-2015-unwpp-country-totals-2015.zip",sep=""),
      exdir = paste("./",outDir,sep=""))
