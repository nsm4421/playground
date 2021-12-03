from BasicPV import BasicPV


class PV(BasicPV):
    def __init__(self):
        BasicPV.__init__(self)

    def SettingArguments(self, x: int = None, sex: int = None, n: int = None, m: int = None, injure: int = None, driver: int = None, AMT: int = None, coverageKey: str = None):
        self.clearSymbols()
        self.setArgs(x=x, sex=sex, n=n, m=m, injure=injure, driver=driver, AMT=AMT, coverageKey=coverageKey)
        self.parsingCoverageInfo()
        self.qxMapping()
       
    def CalcNetPrenium(self, mPrime : int = 12):
        return self.SUMx[self.x] / (mPrime *(self.NxPrime[self.x] - self.NxPrime[self.x+self.m] - (mPrime-1)/(2*mPrime)*(self.DxPrime[self.x] - self.DxPrime[self.x+self.n])))
