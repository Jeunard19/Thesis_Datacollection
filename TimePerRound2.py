import csv
import pandas as pd
from datetime import datetime



def main():
    header_list = ['Pair', 'Roles',"Time","X","Y","Z","Game","Succes","Target","Selection","Introducer"]
    data1 = pd.read_csv('data_P2_final.csv')
    game = data1.loc[0,'Game']
    time = datetime.strptime('30/03/09 '+data1.loc[0,'Time2'], '%d/%m/%y %H:%M:%S.%f').timestamp() * 1000
    start = True
    durations = []
    rounds = []
    pairs = []
    times = []
    times2 = []
    condition = []
    times.append(datetime.strptime('30/03/09 '+data1.loc[0,'Time2'], '%d/%m/%y %H:%M:%S.%f').timestamp() * 1000)
    for x in range(len(data1)):
        if data1.loc[x,'Game'] == game:
            print("ok")
        else:
            times2.append(datetime.strptime('30/03/09 '+data1.loc[x-1,'Time2'], '%d/%m/%y %H:%M:%S.%f').timestamp() * 1000)
            times.append(datetime.strptime('30/03/09 '+data1.loc[x,'Time2'], '%d/%m/%y %H:%M:%S.%f').timestamp() * 1000)
            durations.append(datetime.strptime('30/03/09 '+data1.loc[x-1,'Time2'], '%d/%m/%y %H:%M:%S.%f').timestamp() * 1000 - time)
            rounds.append(data1.loc[x-1,'Game'])
            condition.append(data1.loc[x-1,'Condition'])
            pairs.append(data1.loc[x-1,'Pair'])
            game = data1.loc[x,'Game']
            time = datetime.strptime('30/03/09 '+data1.loc[x,'Time2'], '%d/%m/%y %H:%M:%S.%f').timestamp() * 1000
    times2.append(datetime.strptime('30/03/09 '+data1.loc[len(data1)-1,'Time2'], '%d/%m/%y %H:%M:%S.%f').timestamp() * 1000)
    durations.append(datetime.strptime('30/03/09 '+data1.loc[len(data1)-1,'Time2'], '%d/%m/%y %H:%M:%S.%f').timestamp() * 1000 - time)
    condition.append(data1.loc[len(data1)-1,'Condition'])
    rounds.append(data1.loc[len(data1)-1,'Game'])
    pairs.append(data1.loc[len(data1)-1,'Pair'])
    df_fine = pd.DataFrame(list(zip(pairs,condition, rounds,durations, times,times2)),
               columns =['Pair','Condtion', 'Game',"Time","Time2","Time3"])
    df_fine.to_csv('data_P2_TpR.csv', index=False) 
if __name__ == "__main__":
    main()
