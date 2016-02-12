import arcpy

inDir= "1_UnpackData/"
outDir = "3_CheckData2/"

arcpy.CheckOutExtension("spatial")

print("Reclassifying population density")
arcpy.gp.Reclassify_sa(
    inDir +
    "gpw-v4-population-density-adjusted-to-2015-unwpp-country-totals_2005.tif",
    "Value", "0 0.01 1;0.01 0.3 2;0.3 2.5 3;2.5 20 4;20 9999999 5",
    outDir + "pd05rc", "DATA")
arcpy.gp.Reclassify_sa(
    inDir +
    "gpw-v4-population-density-adjusted-to-2015-unwpp-country-totals_2010.tif",
    "Value", "0 0.01 1;0.01 0.3 2;0.3 2.5 3;2.5 20 4;20 9999999 5",
    outDir + "pd10rc", "DATA")
arcpy.gp.Reclassify_sa(
    inDir +
    "gpw-v4-population-density-adjusted-to-2015-unwpp-country-totals_2015.tif",
    "Value", "0 0.01 1;0.01 0.3 2;0.3 2.5 3;2.5 20 4;20 9999999 5",
    outDir + "pd15rc", "DATA")

print("Combining into a single data frame")
outCombine = arcpy.sa.Combine([inDir + "gpw-v4-population-density-adjusted-to-2015-unwpp-country-totals_2005.tif",
                               inDir + "gpw-v4-population-density-adjusted-to-2015-unwpp-country-totals_2010.tif",
                               inDir + "gpw-v4-population-density-adjusted-to-2015-unwpp-country-totals_2015.tif"])
outCombine.save(outDir + "allyrs")

arcpy.MakeTableView_management(in_table=outCombine,out_view="allyrsdbf",
                               where_clause="", workspace="",
                               field_info="Rowid Rowid HIDDEN NONE;VALUE VALUE HIDDEN NONE;COUNT COUNT HIDDEN NONE;GPW_V4_POPULATI1 GPW_V4_POPULATI1 VISIBLE NONE;GPW_V4_POPULATI2 GPW_V4_POPULATI2 VISIBLE NONE;GPW_V4_POPULATI3 GPW_V4_POPULATI3 VISIBLE NONE")

arcpy.CopyRows_management("allyrsdbf",outDir + "allyrs.dbf")
