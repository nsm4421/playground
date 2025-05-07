import numpy as np
import pandas as pd

class Calculation:
    def __init__(self, excel_file : str = './INFO.xlsx'):
        self.excel_file = excel_file
        self.sht_rate = pd.read_excel(self.excel_file, sheet_name="위험률", header = 1).fillna(0)
        self.sht_rate = self.sht_rate[['Key', 'x', 'Male', 'Female']]

    def getQx(self, rKey : str, sex : int = None) -> np.array:
        if sex==None:sex = self.sex
        qx = np.zeros(120)
        df = self.sht_rate.loc[self.sht_rate['Key'] == rKey].copy(deep=True)
        if sex == 1:
            df = df[['x', 'Male']].values
        else:
            df = df[['x', 'Female']].values
        for row in df:
            age, rate = row
            qx[int(age)] = rate
        return qx[self.x:]
    
    def setArgs(self, x : int, sex : int, \
        n : int, m : int, re: int, hyung : int):
        #=========== Set Arguments ===========#
        self.x = x
        self.sex = sex
        
        self.n = n  # 보험기간
        self.m = m  # 납입기간

        self.re = re  # 1 : 최초계약, 2 : 갱신계약
        self.hyung = hyung   # 형

        assert re in [1, 2]
        assert hyung in [1, 2]

        self.w = 108 if sex==1 else 110
        self.l0 = 100000
        self.i = 0.0225
        self.v = 1/(1+self.i)
        self.AMT = 1000000   # 가입금액

        self.beta5 = 0
        if self.re == 1:
            self.alpha1 = 0.35/1000
            self.alpha2 = 0.05*min(self.n, 20)
            if self.hyung == 1:self.S = 0.18
            else:self.S = 0.17
        else:
            self.alpha1 = 0.245/1000*min(self.n, 10)/10
            self.alpha2 = 0.035*min(self.n, 20)
            self.S = 0.01
        self.beta1 = 0.002/1000
        self.beta2 = 0.385 - self.beta5
        self.betaPrime = self.beta1/2

    def main(self):
        # a
        if self.re==1:a = [3/4] + [1.]*(self.n)
        else:a = [1.]*(self.n+1)

        #=========== RiskRate ===========#
        # 나중에 위험율 긁어오는 코드 추가!!!!
        qx_t = self.getQx("Qt")
        qx_c = self.getQx("Qc")
        qx_ca = self.getQx("Qca")


        # lx
        lx = [self.l0]
        lx_c = [self.l0]
        lx_ca = [self.l0]
        for t in range(self.n+1):
            lx.append(lx[t]*(1-qx_t[t]*a[t]))
            lx_c.append(lx_c[t]*(1-qx_c[t]*a[t]))
            lx_ca.append(lx_ca[t]*(1-(qx_ca[t]-(1-a[t])*qx_c[t])))

        # Dx
        Dx = [lx[t]*self.v**t for t in range(self.n+1)]
        Dx_c = []
        for t in range(self.n+1):
            D = lx_c[t]*self.v**t
            Dx_c.append(D)
      

        # Nx
        Nx = [sum(Dx[t:]) for t in range(self.n+1)]
        Nx_c = [sum(Dx_c[t:]) for t in range(self.n+1)]
        Nshop = [max(Nx_c[t] - Nx_c[self.m], 0) for t in range(self.n+1)]
        Nstar = 12*((Nx_c[0] - Nx_c[self.m]) - 11/24*(Dx_c[0] - Dx_c[self.m]))

        # M#
        dx_t = [lx_ca[t]*a[t]*qx_t[t] for t in range(self.n+1)]
        Cx_t = []
        for t in range(self.n+1):
            if t==0 and self.re == 1:
                C = dx_t[t]*self.v**(t+5/8)
            else:
                C = dx_t[t]*self.v**(t+1/2)
            Cx_t.append(C)        

        Mx_t = [sum(Cx_t[t:]) for t in range(self.n+1)]
        if self.re==1 and self.hyung==2:
            Mshop = []
            for t in range(self.n+1):
                if self.re==1 and t<2:
                    Mshop.append(0.5*(Mx_t[t]-Mx_t[2])+(Mx_t[2] - Mx_t[self.n]))
                else:
                    Mshop.append(Mx_t[t] - Mx_t[self.n])
        else:
            Mshop = [Mx_t[t] - Mx_t[self.n] for t in range(self.n+1)]


        #=========== Prenium ===========#

        # 월납 순보험료
        NP = Mshop[0] / Nstar   
        # 기준 연납 순보험료
        NP_std = Mshop[0]/(Nx_c[0] - Nx_c[min(self.n, 20)])  
        # 연납 베타순보험료
        NP_beta = Mshop[0]/(Nx_c[0] - Nx_c[self.m]) + \
            self.betaPrime*(Nx[0]-Nx[self.n]-Nshop[0])/Nshop[0]   
        # 월납 영업보험료
        G = (NP+ (self.alpha1+self.alpha2*NP_std)*Dx[0]/Nstar+self.beta1/12 \
            +self.betaPrime*(Nx[0]-Nx[self.n]-Nstar/12)/Nstar)\
            /(1-self.beta2-self.beta5)        

        tVx = []
        for t in range(self.n+1):
            if t==0:V=0
            elif t<self.m:V = (Mshop[t]+self.betaPrime*(Nx[t]-Nx[self.n]-Nshop[t])-NP_beta*Nshop[t])/Dx[t]
            else:V = (Mshop[t]+self.betaPrime*(Nx[t]-Nx[self.n]))/Dx[t]
            V = round(V,6)
            tVx.append(V)


        alpha_std = NP_std*0.05*min(self.n, 20)+10/1000*self.S
        alpha_apply = self.alpha1+self.alpha2*NP_std
        alphaPrime = min(alpha_std, alpha_apply)

        tWx = []
        for t in range(self.n+1):
            V = tVx[t]
            W = max(V - max(0, (1-t/min(7, self.m)))*alphaPrime, 0)
            tWx.append(W)    


        #=========== Output ===========#

        return {'G' : round(self.AMT*G), \
            'NP_beta' : round(self.AMT*NP_beta), \
                'tVx' : [round(V*self.AMT) for V in tVx], \
                    'tWx' : [round(W*self.AMT) for W in tWx]}
