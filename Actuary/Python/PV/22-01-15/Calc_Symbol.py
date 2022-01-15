from Util_Qx import Util_Qx


class Calc_Symbol(Util_Qx):
    def __init__(self, excel_path : str):
        super().__init__(excel_path=excel_path)

    def Calulation(self):

        cov_dict = self.CovDict[self.coverage]
        numBenefit = cov_dict['NumBenefit']
        nonCov = cov_dict['NonCov']
        payRate = cov_dict['PayRate']
        reduceRate = cov_dict['ReduceRate']
        reducePeriod = cov_dict['ReducePeriod']
        invalidPeriod = cov_dict['InvalidPeriod']

        self.setUpQx()

        # init
        lx = [[0.]*(self.n+1)]*(numBenefit+1)
        lxPrime = [0.]*(self.n+1)
        Nx = [0.]*(self.n+1)
        NxPrime = [0.]*(self.n+1)
        Cx = [[0.]*(self.n+1)]*(numBenefit+1)
        Mx = [[0.]*(self.n+1)]*(numBenefit+1)
        SUMx = [0.]*(self.n+1)

        # lx
        for i in range(numBenefit+1):
            lx[i][0] = 100000
            for t in range(self.n):
                if t == 0:
                    lx[i][t+1] = lx[i][t]*(1-self.Ex[i][self.x+t] * (1-nonCov[i]/12))   # 부담보
                else:
                    lx[i][t+1] = lx[i][t]*(1-self.Ex[i][self.x+t])
        # Dx
        Dx = [lx[0][t]*self.v**t for t in range(self.n+1)]
        
        # Nx
        for t in range(self.n)[::-1]:
            Nx[t] = Nx[t+1] + Dx[t]
            
        
        # l'x
        lxPrime[0] = 100000
        for t in range(self.n):
            if t==0:
                lxPrime[t+1] = lxPrime[t]*(1-self.Gx[self.x+t] * (1-invalidPeriod/12))
            else:
                lxPrime[t+1] = lxPrime[t]*(1-self.Gx[self.x+t])
        
        # D'x
        DxPrime = [lxPrime[t]*self.v**t for t in range(self.n+1)]

        # N'x
        for t in range(self.n)[::-1]:
            NxPrime[t] = NxPrime[t+1] + DxPrime[t]
            

        # Cx
        for i in range(1, numBenefit+1):
            Cx[i] = [lx[i][self.x+t]*self.Bx[i][t]*self.v**(t+0.5) for t in range(self.n+1)]

        # Mx
        for i in range(1, numBenefit+1):
            for t in range(self.n)[::-1]:
                Mx[i][t] = Cx[i][t] + Mx[i][t+1]

        # SUMx
        for i in range(1, numBenefit+1):
            pRate = payRate[i]
            rPeriod = reducePeriod[i]
            rRate = reduceRate[i]
            for t in range(self.n+1):
                if t<reducePeriod[i]:
                    SUMx[t] += pRate * ((1-rRate) * (Mx[t]-Mx[rPeriod]) + \
                        (Mx[rPeriod] - Mx[self.n]))
                else:
                    SUMx[t] += pRate * (Mx[t] - Mx[self.n])

        return {
            'lx' : lx,
            "l'x" : lxPrime,
            "Dx" : Dx,
            "D'x" : DxPrime,
            "Nx" : Dx,
            "N'x" : DxPrime,
            "Cx" : Cx,
            "Mx" : Mx,
            "SUMx" : SUMx
        }   