import pandas as pd

 

df1 = pd.read_csv("./Hs_RNASeq_top_alt_junctions-PSI_EventAnnotation-75p-TCGA-LGG.txt", sep = "\t")

print df1.shape
print df1.head()
 

df1 = df1.drop(['Symbol', 'Description', 'Examined-Junction', 'Background-Major-Junction', 'AltExons', 'ProteinPredictions', 'dPSI', 'ClusterID', 'Coordinates', 'EventAnnotation'], axis = 1)

print df1.shape
df1.columns=df1.columns.str.split('_').str[0]
#df1.columns = df1.columns.Split('_')[0];
#df1.columns = df1.columns.str.replace("[()]", "_")
print df1.head()

df1.to_csv("./Hs_RNASeq_top_alt_junctions-PSI_EventAnnotation-75p_onlyUID.txt", sep = "\t", index=False)