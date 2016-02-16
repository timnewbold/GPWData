import arcpy
from arcpy.sa import *

dataDir = "0_data/"
inDir= "1_UnpackData/"
outDir = "3_CheckData2/"

f = open(dataDir + "unAdj.csv",'r')
unAdj = bool(f.readline().split('\n')[0])
f.close()

if (unAdj):
    fname1 = "gpw-v4-population-density-adjusted-to-2015-unwpp-country-totals_2005.tif"
    fname2 = "gpw-v4-population-density-adjusted-to-2015-unwpp-country-totals_2010.tif"
    fname3 = "gpw-v4-population-density-adjusted-to-2015-unwpp-country-totals_2015.tif"

arcpy.CheckOutExtension("spatial")

print("Reclassifying population density")
arcpy.gp.Reclassify_sa(
    inDir + fname1,
    "Value", "0 0.01 1;0.01 0.3 2;0.3 2.5 3;2.5 20 4;20 9999999 5",
    outDir + "pd05rc", "DATA")
arcpy.gp.Reclassify_sa(
    inDir + fname2,
    "Value", "0 0.01 1;0.01 0.3 2;0.3 2.5 3;2.5 20 4;20 9999999 5",
    outDir + "pd10rc", "DATA")
arcpy.gp.Reclassify_sa(
    inDir + fname3,
    "Value", "0 0.01 1;0.01 0.3 2;0.3 2.5 3;2.5 20 4;20 9999999 5",
    outDir + "pd15rc", "DATA")

print("Calculating between-year ratios")
ratio0510 = Raster(inDir + fname2) / \
            Raster(inDir + fname1)
ratio1015 = Raster(inDir + fname3) / \
            Raster(inDir + fname2)

ratio0510.save(outDir + "Ratio0510")
ratio1015.save(outDir + "Ratio1015")

print("Combining into a single data frame")
outCombine = arcpy.sa.Combine([inDir + fname1,
                               inDir + fname2,
                               inDir + fname3])
outCombine.save(outDir + "allyrs")

arcpy.MakeTableView_management(in_table=outCombine,out_view="allyrsdbf",
                               where_clause="", workspace="",
                               field_info="Rowid Rowid HIDDEN NONE;VALUE VALUE HIDDEN NONE;COUNT COUNT HIDDEN NONE;GPW_V4_POPULATI1 GPW_V4_POPULATI1 VISIBLE NONE;GPW_V4_POPULATI2 GPW_V4_POPULATI2 VISIBLE NONE;GPW_V4_POPULATI3 GPW_V4_POPULATI3 VISIBLE NONE")

arcpy.CopyRows_management("allyrsdbf",outDir + "allyrs.dbf")
