import csv
import pandas as pd

def getTrueTime(newtime):
    if "PM" in newtime:
        newtime.replace(' PM', '')
        newtimelist = newtime.split(':')
        newtimelist[0] = str(int(newtimelist[0])+12)
        if newtimelist[0] == "24":
            newtimelist[0] = "12"
        newtime = ":".join(newtimelist)
    return newtime


def main():
    header_list = ['Pair', 'Roles',"Time","X","Y","Z","Game","Succes","Target","Selection","Introducer"]
    data1 = pd.read_csv('data_P1_selec.csv')
    print(data1)
    successful_intro = []
    successful_intro_sub = []
    
    #selection
    selection = []
    selection_sub = []
    
    #rsuccess
    rSucces = []
    rSucces_sub = []
    
    #Time
    Time_s = []
    Time = []
    time = ""
    
    role = ''
    for x in range(len(data1)):
        if data1.loc[x,'Time'] == time:
            newtime = data1.loc[x,'Time']
            newtime = getTrueTime(newtime)
            Time_s.append(newtime.replace(' AM', '').replace(' PM', ''))
        else:
            if time == "":
                time = data1.loc[x,'Time']
                newtime = data1.loc[x,'Time']
                newtime = getTrueTime(newtime)
                Time_s.append(newtime.replace(' AM', '').replace(' PM', ''))
            else:
                time = data1.loc[x,'Time']
                tot_time = len(Time_s)
                step = 1000/tot_time
                start = 0
            
                for v in range(len(Time_s)):
                    start+=step
                    Time_s[v] = Time_s[v]+"."+str(int(start))
                Time.extend(Time_s)
                Time_s = []
                newtime = data1.loc[x,'Time']
                newtime = getTrueTime(newtime)
                Time_s.append(newtime.replace(' AM', '').replace(' PM', ''))
        
        
        if role != data1.loc[x,'Roles']:
            success = data1.loc[x,'Succes']
            role = data1.loc[x,'Roles']
            if all(x==successful_intro_sub[0] for x in successful_intro_sub):
                print(successful_intro_sub)
            else:
                for d in range(len(successful_intro_sub)):
                    successful_intro_sub[d] = 1
   
            successful_intro.extend(successful_intro_sub)
            successful_intro_sub = []
            successful_intro_sub.append(0)
            
            #selection
            for d in range(len(selection_sub)):
                selection_sub[d] = selection_sub[-1]
            
            selection.extend(selection_sub)
            selection_sub = []
            selection_sub.append(data1.loc[x,'Selection'])
           
            
            
        else:
            #selection
            selection_sub.append(data1.loc[x,'Selection'])
            rSucces_sub.append(0)
            
            if int(data1.loc[x,'Succes']) > int(success):
                
                if int(data1.loc[x,'Introducer']) ==1:
                    successful_intro_sub.append(1)
                else:
                    successful_intro_sub.append(0)
            else:
                successful_intro_sub.append(0)
    
    if all(x==successful_intro_sub[0] for x in successful_intro_sub):
       print("ok")
    else:
       for d in range(len(successful_intro_sub)):
           successful_intro_sub[d] = 1
   
    successful_intro.extend(successful_intro_sub)
    
    #selection
    for d in range(len(selection_sub)):
           selection_sub[d] = selection_sub[-1]
    selection.extend(selection_sub)
    
    tot_time = len(Time_s)
    step = 1000/tot_time
    start = 0
            
    for v in range(len(Time_s)):
        start+=step
        Time_s[v] = Time_s[v]+"."+str(int(start))
    Time.extend(Time_s)

     
    data1['Succesfull_intr'] = successful_intro
    data1['Selection'] = selection
    data1['Time2'] = Time
    data1.to_csv('data_P1_final.csv', index=False)  
    
    #rSuccess
    data2 = pd.read_csv('data_P1_final.csv')
    for i in range(len(data2)):

        if data2.loc[i,'Selection'] == data2.loc[i,'Target']:
            rSucces.append(1)
        else:
            rSucces.append(0)

    data2['rSucces'] = rSucces
    data2.to_csv('data_P1_final.csv', index=False)  
if __name__ == "__main__":
    main()
