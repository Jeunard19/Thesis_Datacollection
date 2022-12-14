import csv
import pandas as pd


def getTime(time):
    times = time.split(":")
    new_time = int(times[0])
    
    if new_time > 12:
        new_time = new_time-12

    return str(new_time)+":"+times[1]


def main():
    header_list = ["player", "role","time","x","y","z","target","selection"]
    P1 = pd.read_csv('/Users/jeunard/Documents/logs.txt', names = header_list)
    P2 = pd.read_csv('/Users/jeunard/Documents/logs.txt', names = header_list)
    player_info= pd.read_csv('/Users/jeunard/Downloads/playerdatainfo.csv')
    #print(df.to_string())
    #print(df.head())
    pair = []
    times = []
    X = []
    Y =[]
    Z = []
    succes = []
    rel_succes = []
    roles = []
    game = []
    target = []
    selection = []
    intr = []
    succ = []
    condition = []
    n_game = 0
    n_pair = 0
    begin = False
    stop = False
    role = "none"
    choice = ""
    
    suc = 0
    for i in range(len(player_info)):
        n_pair += 1
        date_player = player_info.loc[i,'Date']
        time_player = player_info.loc[i,'Time']
        group = player_info.loc[i,'condition']
        start = time_player.split('-')[0].strip()
        end = time_player.split('-')[1].strip()
        suc = 0
        rel_suc = 0
        n_game = 0
        words = {"fear":0,
	"strength":0,
	"luck":0,
	"reality":0,
	"war":0,
	"luxury":0,
	"death":0,
	"envy":0,
	"anger":0,
	"freedom":0}

        for x in range(len(P1)):
            #split time based on date and time
            datetime = P1.loc[x,'time'].split(",")
            date= datetime[0]
            time= datetime[1].strip()
            if date_player == date:

                if getTime(start) == time[:-6]:
                    print(start)
                    print(getTime(start))
                    print(time[:-6])
                    begin = True
                elif P1.loc[x,'target'] == "Hello World" or  P1.loc[x,'target'] == "New Game":
                    begin = False
                    
                if begin:
                   
                    if role != P1.loc[x,'role']:
                        rel_suc = 0
                        if role == "director":
                            words[P1.loc[x-1,"target"]] = 1
                        role = P1.loc[x,'role']
                        n_game += 1

                    elif role == P1.loc[x,'role']:
                        choice = P1.loc[x,'selection']
                        
                        try:
                            role2 = P1.loc[x+1,'role']
                            
                        except KeyError:
                            role2 = "end"
                        if(P1.loc[x,'target'] == P1.loc[x,'selection']) and role != role2:
                            suc+=1
                            rel_suc = 1
                        else:
                            rel_suc = 0

                    condition.append(group)
                    pair.append(n_pair)
                    times.append(time)
                    game.append(n_game)
                    succes.append(suc)
                    rel_succes.append(rel_suc)
                    X.append(P1.loc[x,"x"])
                    Y.append(P1.loc[x,"y"])
                    Z.append(P1.loc[x,"z"])
                    target.append(P1.loc[x,"target"])
                    
                    selection.append(P1.loc[x,"selection"])
                    roles.append(role)
                    if role == "director":
                        if P1.loc[x,"target"] != "Hello World" and P1.loc[x,"target"] != "New Game": 
                            if words[P1.loc[x,"target"]] == 1:
                                intr.append(0)
                            else:
                                intr.append(1)
                        else:
                            intr.append(0)
                    else:
                        intr.append(0)
    df_fine = pd.DataFrame(list(zip(pair, condition, roles,times, X,Y,Z, game,succes,rel_succes,target,selection,intr)),
               columns =['Pair','Condition', 'Roles',"Time","X","Y","Z","Game","Succes","rSucces","Target","Selection","Introducer"])
    df_fine.to_csv('data_P1_selec.csv', index=False)  

if __name__ == "__main__":
    main()
