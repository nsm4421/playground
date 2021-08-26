import numpy as np
import pandas as pd


def Calculation(x : int, sex : int, \
    n : int, m : int, re: int, hyung : int)->dict:
    #=========== Set Arguments ===========#
    x = 30
    sex = 1
    
    n = 10  # 보험기간
    m = 10  # 납입기간

    re = 1  # 1 : 최초계약, 2 : 갱신계약
    hyung = 1   # 형

    assert re in [1, 2]
    assert hyung in [1, 2]

    #--------------------------------------
    w = 108 if sex==1 else 110
    l0 = 1000000
    i = 0.0225
    v = 1/(1+i)
    AMT = 1000000   # 가입금액

    beta5 = 0
    if re == 1:
        alpha1 = 0.35/1000
        alpha2 = 0.05*min(n, 20)
        if hyung == 1:S = 0.18
        else:S = 0.17
    else:
        alpha1 = 0.245/1000*min(n, 10)/10
        alpha2 = 0.035*min(n, 20)
        S = 0.01
    beta1 = 0.0002/1000
    beta2 = 0.385 - beta5
    betaPrime = beta1/2


    #=========== RiskRate ===========#
    # 나중에 위험율 긁어오는 코드 추가!!!!
    qx_t = [0.1]*(w-x)
    qx_c = [0.1]*(w-x)
    qx_ca = [0.1]*(w-x)

    #=========== 기수 ===========#

    # a
    if re==1:a = [3/4] + [1.]*(w-x-1)
    else:a = [1.]*(w-x)

    # lx
    lx = [l0]
    lx_c = [l0]
    lx_ca = [l0]
    for t in range(w-x-1):
        lx.append(lx[t]*(1-qx_t[t]*a[t]))
        lx_c.append(lx_c[t]*(1-qx_c[t]*a[t]))
        lx_ca.append(lx_ca[t]*(1-(qx_ca[t]-(1-a[t]*qx_c[t]))))

    # Dx
    Dx = [lx[t]*v**t for t in range(n+1)]
    Dx_c = [lx_c[t]*v**t for t in range(n+1)]

    # Nx
    Nx = [sum(Dx[t:]) for t in range(n+1)]
    Nx_c = [sum(Dx_c[t:]) for t in range(n+1)]
    Nshop = [max(Nx_c[t] - Nx_c[m], 0) for t in range(n+1)]
    Nstar = 12*((Nx_c[0] - Nx_c[m]) - 11/24*(Dx_c[0] - Dx_c[m]))

    # M#
    dx_t = [lx_ca[t]*a[t]*qx_t[t] for t in range(n+1)]
    Cx_t = [dx_t[t]*v**(t+1-a[t]/2) for t in range(n+1)]
    Mx_t = [sum(Cx_t[t:]) for t in range(n+1)]
    if hyung==1:
        Mshop = [Mx_t[t] - Mx_t[n] for t in range(n+1)]
    else:
        Mshop = []
        for t in range(n+1):
            if re==1 and t<2:
                Mshop.append(0.5*(Mx_t[t]-Mx_t[2])+(Mx_t[2] - Mx_t[n]))
            else:
                Mshop.append(Mx_t[t] - Mx_t[n])


    #=========== Prenium ===========#

    # 월납 순보험료
    NP = Mshop[0] / Nstar   
    # 기준 연납 순보험료
    NP_std = Mshop[0]/(Nx_c[0] - Nx_c[min(n, 20)])  
    # 연납 베타순보험료
    NP_beta = Mshop[0]/(Nx_c[0] - Nx_c[m]) + \
        betaPrime*(Nx[0]-Nx[n]-Nshop[0])/Nshop[0]   
    # 월납 영업보험료
    G = (NP+(alpha1+alpha2*NP_std)*Dx[0]/Nstar+beta1/12 \
        +betaPrime*(Nx[0]-Nx[n]-Nstar/12)/Nstar)\
        /(1-beta2-beta5)        

    tVx = [0.]
    for t in range(n+1):
        if t==0:V=0
        elif t<m:V = (Mshop[t]+betaPrime*(Nx[t]-Nx[n]-Nshop[t])-NP_beta*Nshop[t])/Dx[t]
        else:V = (Mshop[t]+betaPrime*(Nx[t]-Nx[n]))/Dx[t]
        tVx.append(V)

    #=========== Reserve, Surrender ===========#

    alpha_std = NP_std*0.05*min(n, 20)+10/1000*S
    alpha_apply = alpha1+alpha2*NP_std
    alphaPrime = min(alpha_std, alpha_apply)

    tWx = []
    for t in range(n+1):
        V = tVx[t]
        W = max(V - max(0, (1-t/max(7, m)))*alphaPrime, 0)
        tWx.append(W)    


    #=========== Output ===========#
    return {'G' : round(AMT*G), \
        'NP_beta' : round(AMT*NP_beta), \
            'tVx' : [round(V*AMT) for V in tVx], \
                'tWx' : [round(W*AMT) for W in tWx]}


#=========== Check ===========#
df_g = pd.read_excel("CASE.xlsx", sheet_name="영업보험료")
df_V = pd.read_excel("CASE.xlsx", sheet_name="준비금")

print("영업보험료 값 맞추는 중")
for j, row in enumerate(df_g.values):
    x, sex, n, m, re, hyung, G_given = row
    G = Calculation(x, sex, n, m, re, hyung)['G']
    with open("영업보험료.txt", 'w') as file:
        if G_given!=G:
            file.write(f"{j+1}. Error - 내가 계산한 값 : {G} / 확인의뢰서 : {G_given} \n")
        else:
            file.write(f"{j+1}. OK - G : {G}")

for j, row in enumerate(df_V.values):
    x, sex, n, m, re, hyung, NP_beta_given, V1_given, V3_given, \
        V5_given, V7_given, V10_given, W1_given, W3_given, \
        W5_given, W7_given, W10_given = row
    result_dict = Calculation(x, sex, n, m, re, hyung)
    NP_beta = result_dict['NP_beta']
    tVx = result_dict['tVx']
    tWx = result_dict['tWx']
    with open("준비금.txt", 'w') as file:
        isCorrect = (NP_beta == NP_beta_given) &\
            (V1_given == tVx[1]) &\
                (V3_given == tVx[3]) &\
                    (V5_given == tVx[5]) &\
                        (V7_given == tVx[7]) &\
                            (V10_given == tVx[10]) &\
            (W1_given == tWx[1]) &\
                (W3_given == tWx[3]) &\
                    (W5_given == tWx[5]) &\
                        (W7_given == tWx[7]) &\
                            (W10_given == tWx[10])
        if isCorrect:
            file.write(f"{j+1}. OK")
        else:
            file.write(f"{j+1}. Error")




    


