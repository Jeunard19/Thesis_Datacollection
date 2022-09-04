import csv
import pandas as pd
from datetime import datetime



def main():
    header_list = ['Pair', 'Roles',"Time","X","Y","Z","Game","Succes","Target","Selection","Introducer"]
    data1 = pd.read_csv('data_P1_final.csv')
    game = data1.loc[0,'Game']
    time = datetime.strptime('30/03/09 '+data1.loc[0,'Time2'], '%d/%m/%y %H:%M:%S.%f').timestamp() * 1000
    start = True
    durations = []
    rounds = []
    pairs = []
    times = []
    times2 = []
    times.append(datetime.strptime('30/03/09 '+data1.loc[0,'Time2'], '%d/%m/%y %H:%M:%S.%f').timestamp() * 1000)
    for x in range(len(data1)):
        if data1.loc[x,'Game'] == game:
            print("ok")
        else:
            times2.append(datetime.strptime('30/03/09 '+data1.loc[x-1,'Time2'], '%d/%m/%y %H:%M:%S.%f').timestamp() * 1000)
            times.append(datetime.strptime('30/03/09 '+data1.loc[x,'Time2'], '%d/%m/%y %H:%M:%S.%f').timestamp() * 1000)
            durations.append(datetime.strptime('30/03/09 '+data1.loc[x-1,'Time2'], '%d/%m/%y %H:%M:%S.%f').timestamp() * 1000 - time)
            rounds.append(data1.loc[x-1,'Game'])
            pairs.append(data1.loc[x-1,'Pair'])
            game = data1.loc[x,'Game']
            time = datetime.strptime('30/03/09 '+data1.loc[x,'Time2'], '%d/%m/%y %H:%M:%S.%f').timestamp() * 1000
    times2.append(datetime.strptime('30/03/09 '+data1.loc[len(data1)-1,'Time2'], '%d/%m/%y %H:%M:%S.%f').timestamp() * 1000)
    df_fine = pd.DataFrame(list(zip(pairs, rounds,durations, times,times2)),
               columns =['Pair', 'Game',"Time","Time2","Time3"])
    df_fine.to_csv('data_P1_TpR.csv', index=False) 
if __name__ == "__main__":
    main()
