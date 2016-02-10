
inDir= "2_CheckData/"

pd2005 = [None] * 212563217
pd2010 = [None] * 212563217
pd2015 = [None] * 212563217

f = open(inDir + "nrows.txt",'r')
f.readline()
nrows = int(f.readline().replace('\n',''))
f.close()

f = open(inDir + "cell_data.csv",'r')

h = f.readline().split(',')

i = 0
for x in range(0,nrows):
    print(x)
    l = f.readline().split(',')
    if l[0] != 'NA':
        pd2005[i] = l[0]
        pd2010[i] = l[1]
        pd2015[i] = l[2]
        i=i+1
    
f.close()
