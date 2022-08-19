import csv
import pandas as pd



def main():
    header_list = ['Pair', 'Roles',"Time","X","Y","Z","Game","Succes","Target","Selection","Introducer"]
    data1 = pd.read_csv('data_P2_selec.csv')
    print(data1)
    successful_intro = []
    successful_intro_sub = []
    role = ''
    for x in range(len(data1)):
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
        else:
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
    print(successful_intro)
    data1['Succesfull_intr'] = successful_intro
    data1.to_csv('data_P2_final.csv', index=False)  

if __name__ == "__main__":
    main()
