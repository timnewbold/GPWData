import platform
import socket

# Define the locations of programs
if 'WCMC-LT-01636' == socket.gethostname():
    # Tim's Windows PC
    arcpy = 'c:/python26/ArcGIS10.0/python.exe'
    python = 'c:/Python34/python.exe'
    R = 'c:/Program Files/R/R-3.1.2/bin/x64/Rscript.exe'
elif 'WCMC-PC-01686' == socket.gethostname():
    arcpy = 'c:/python26/ArcGIS10.0/python.exe'
    python = 'c:/Python34/python.exe'
    R = 'c:/Program Files/R/R-3.1.2/bin/x64/Rscript.exe'
elif 'ucbttne-PC' == socket.gethostname():
    # Tim's UCL PC
    arcpy = 'c:/python27/ArcGIS10.3/python.exe'
    python = 'c:/Python35/python.exe'
    R = 'c:/Program Files/R/R-3.2.2/bin/x64/Rscript.exe'

STAGES = [ ('1', R,              '1_UnpackData.R'),
           ('2', R,              '2_CheckData.R'),
           ('3', arcpy,          '3_CheckData2.py'),
           ('4', R,              '4_CheckData3.R'),
           ('5', R,              '5_MapData.R'),
         ]
