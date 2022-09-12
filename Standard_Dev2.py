import csv
import pandas as pd
from datetime import datetime
import statistics



def main():
    header_list = ['Pair', 'Roles',"Time","X","Y","Z","Game","Succes","Target","Selection","Introducer"]
    data1 = pd.read_csv('data_P2_final.csv')
    game = data1.loc[0,'Game']
    start = True
    durations = []
    rounds = []
    pairs = []
    condition = []
    success = []
    succ_intro = []
    role = []
    X = []
    Y = []
    Z = []
    target = []
    intr = []
    part = []
    part_id = 25
    Xst = []
    Yst = []
    Zst = []
    for x in range(len(data1)):
        if data1.loc[x,'Game'] == game:
           X.append(float(data1.loc[x,'X']))
           Y.append(float(data1.loc[x,'Y']))
           Z.append(float(data1.loc[x,'Z']))
        else:
            
            Xst.append(statistics.stdev(X))
            print(Xst)
            Yst.append(statistics.stdev(Y))
            Zst.append(statistics.stdev(Z))
            target.append(data1.loc[x-1,'Target'])
            condition.append(data1.loc[x-1,'Condition'])
            rounds.append(data1.loc[x-1,'Game'])
            pairs.append(data1.loc[x-1,'Pair'])
            role.append(data1.loc[x-1,'Roles'])
            success.append(data1.loc[x-1,'rSucces'])
            X = []
            Y = []
            Z = []
            X.append(data1.loc[x,'X'])
            Y.append(data1.loc[x,'Y'])
            Z.append(data1.loc[x,'Z'])
            game = data1.loc[x,'Game']
            intr.append(data1.loc[x-1,'Introducer'])
            part.append(data1.loc[x-1,'Pair'])
            succ_intro.append(data1.loc[x-1,'Succesfull_intr']) 
    Xst.append(statistics.stdev(X))
    Yst.append(statistics.stdev(Y))
    Zst.append(statistics.stdev(Z))
    target.append(data1.loc[len(data1)-1,'Target'])
    condition.append(data1.loc[len(data1)-1,'Condition'])
    rounds.append(data1.loc[len(data1)-1,'Game'])
    print(data1.loc[len(data1)-1,'Game'])
    pairs.append(data1.loc[len(data1)-1,'Pair'])
    role.append(data1.loc[len(data1)-1,'Roles'])
    success.append(data1.loc[len(data1)-1,'rSucces'])
    intr.append(data1.loc[len(data1)-1,'Introducer'])
    part.append(data1.loc[len(data1)-1,'Pair'])
    succ_intro.append(data1.loc[len(data1)-1,'Succesfull_intr']) 




    df_fine = pd.DataFrame(list(zip(pairs,condition,rounds,Xst,Yst,Zst,role,success,target,intr,succ_intro,part)),
               columns =['Pair','Condtion', 'Game',"X","Y","Z","Role","Success","Target","Introducer","Succ_Introducer","Participant"])
    df_fine.to_csv('data_P1_SD.csv', index=False) 
if __name__ == "__main__":
    main()
