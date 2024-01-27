import numpy as np
import pandas as pd


class MyUtil:
    def __init__(self, excel_file : str, fillNa : str = "^", i : float = 0.025):

        # Excel 시트 읽기
        self.df_Qx = self.readQxSheet(excel_file=excel_file, fillNa=fillNa)
        self.df_Code = self.readCodeSheet(excel_file=excel_file, fillNa=fillNa)
        self.df_Comb = self.readCombSheet(excel_file=excel_file, fillNa=fillNa)

        self.fillNa = fillNa

        # 할인율
        self.v = 1/(1+i)

    # argument 세팅
    def setArgs(self, sex : int = None, x : int = None, n : int = None, m : int = None, \
        coverageKey : str = None, injure : int = None, driver : int = None, AMT : int = None):
        self.sex=sex                                # 성별
        self.x=x                                    # 가입연령
        self.n=n                                    # 보험기간
        self.m=m                                    # 납입기간
        self.coverageKey=coverageKey                # 담보키
        self.injure=injure                          # 상해급수
        self.driver=driver                          # 운전자급수
        self.AMT=AMT                                # 가입금액
        
    def mappingQx(self, riskCode : str, riskType : str):
        """
        INPUT : 위험률코드, 위험률Type
        OUTPUT : qx = (q_x, q_x+1, .... q_x+n)
        """
        if riskType == "C":
            return self.combQxDict[riskCode]
        else:
            return self.getQxWithCode(riskCode=riskCode, riskType=riskType, df_Qx=self.df_Qx, \
                sex=self.sex, injure=self.injure, driver=self.driver)[self.x:self.x+self.n+1]
        
    def setCombQxDict(self) -> dict:
        """
        self.CombQxDict를 세팅
        """
        self.combQxDict = {}        
        df = self.df_Comb.loc[self.df_Comb['CoverageKey'] == self.coverageKey]
        if df.shape[0] == 0:
            return self.combQxDict      # 결합위험률을 생성할 필요 없는 담보의 경우 빈 dictionary를 return
        else:
            for row in df.values:
                combRiskCode, operation, numRiskKey = row[1:4]            
                qx = np.zeros(shape=(numRiskKey, self.n+1))
                rKeys = row[4:4+numRiskKey]
                periods = row[12:12+numRiskKey]    
                for i in range(numRiskKey):
                    if rKeys[i] in self.combQxDict.keys():
                        qx[i] = self.combQxDict[rKeys[i]]
                    else:
                        qx[i] = self.getQxWithKey(df_Qx=self.df_Qx, riskKey = rKeys[i], sex=self.sex)[self.x:self.x+self.n+1]
                kx = np.array([p/12 for p in periods])
                
                if operation == 1:      # 위험률끼리 더해서 결합위험률을 생성하는 경우
                    self.combQxDict[combRiskCode] = self.sumQx(qx=qx, kx=kx)
                elif operation == 2:    # 위험률끼리 곱해서 결합위험률을 생성하는 경우
                    self.combQxDict[combRiskCode] = self.productQx(qx=qx, kx=kx)
                else:
                    raise Exception(f"ERR : operation 코드가 {operation}로 들어옴")

    def getSymbolsDict(self)->dict:
        """
        기수식계산
        """
        # 담보 정보 (탈퇴, 급부지급, 납면) 세팅
        NumBenefit, ExitCode, ExitType, NonCov, \
            BenefitCode, BenefitType, PayRate, ReduceRate, ReducePeriod, \
                GrantCode, GrantType, InvalidPeriod = self.getCoverageInfo(df_Code=self.df_Code, coverageKey=self.coverageKey, fillNa=self.fillNa)
        
        # 탈퇴율(Exit) 매핑
        Ex=[[0.]*(self.n+1)]*(NumBenefit+1)
        for i in range(NumBenefit+1):
            Ex[i] = self.mappingQx(riskCode=ExitCode[i], riskType=ExitType[i])

        # 급부율(Benefit) 매핑
        Bx=[[0.]*(self.n+1)]*(NumBenefit+1)
        for i in range(1, NumBenefit+1):
            Bx[i] = self.mappingQx(riskCode=BenefitCode[i], riskType=BenefitType[i])
        
        # 납면율 (grant) 매핑
        Gx = self.mappingQx(riskCode=GrantCode, riskType=GrantType)

        # 기수식 dictionary 세팅
        return self.calculateSymbols(NumBenefit=NumBenefit, Ex=Ex, NonCov=NonCov, \
            Bx=Bx, PayRate=PayRate, ReduceRate=ReduceRate, ReducePeriod=ReducePeriod, \
                Gx=Gx, InvalidPeriod=InvalidPeriod, n=self.n, v=self.v)


    def getSymbolTable(self) -> pd.DataFrame:
        """
        INPUT : 기수식 dictionary
        OUPUT : 기수식 dataframe
        """
        symbolsDict = self.getSymbolsDict()
        df = {}
        lx = symbolsDict['lx']
        lxPrime = symbolsDict["l'x"]
        Ex = symbolsDict['Ex']
        Bx = symbolsDict['Bx']
        Gx = symbolsDict['Gx']
        Cx = symbolsDict['Cx']
        Mx = symbolsDict['Mx']
        SUMx = symbolsDict["SUMx"]
        Dx = symbolsDict['Dx']
        DxPrime = symbolsDict["D'x"]
        Nx = symbolsDict['Nx']
        NxPrime = symbolsDict["N'x"]
        NumBenefit = len(lx) - 1
        for i in range(NumBenefit+1):
            df[f"lx({i})"] = lx[i]
            df[f"Ex({i})"] = Ex[i]
            if i != 0:
                df[f"Bx({i})"] = Bx[i]
                df[f"Cx({i})"] = Cx[i]
                df[f"Mx({i})"] = Mx[i]
        df['SUMx'] = SUMx
        df["l'x"] = lxPrime
        df["Gx"] = Gx
        df["Dx"] = Dx
        df["D'x"] = DxPrime
        df["Nx"] = Nx
        df["N'x"] = NxPrime
        return pd.DataFrame(df)

    ##=========================================== Static Method ==============================================-##
    
    ## Excel 시트 읽기

    # 위험률시트
    @staticmethod
    def readQxSheet(excel_file : str, sheet_name : str = "위험률", header = 2, fillNa : str = "^"):
        # read excel sheet
        sht_rate = pd.read_excel(excel_file, sheet_name=sheet_name, header = header).fillna(fillNa)
        sht_rate = sht_rate[['RiskKey', 'RiskCode', 'Injure', 'Driver', 'x', 'Male', 'Female']]
        sht_rate['Injure'] = sht_rate['Injure'].apply(lambda x:fillNa if x in (0, '0', fillNa) else x)
        sht_rate['Driver'] = sht_rate['Driver'].apply(lambda x:fillNa if x in (0, '0', fillNa)  else x)
        return sht_rate

    # 코드시트
    @staticmethod
    def readCodeSheet(excel_file : str, sheet_name : str = "코드", header = 2, fillNa : str = "^"):
        sht_code = pd.read_excel(excel_file, sheet_name=sheet_name, header = header).fillna(fillNa)
        sht_code = sht_code[['CoverageKey', 'BenefitNum', 'ExitCode', 'ExitType', 'NonCov',\
            'BenefitCode', 'BenefitType', 'PayRate', 'ReduceRate', 'ReducePeriod',\
                'GrantCode', 'GrantType', 'InvalidPeriod']]
        sht_code['NonCov'] = sht_code['NonCov'].apply(lambda x:0 if x==fillNa else int(x))
        sht_code['PayRate'] = sht_code['PayRate'].apply(lambda x:0. if x==fillNa else float(x))
        sht_code['ReduceRate'] = sht_code['ReduceRate'].apply(lambda x:0. if x==fillNa else float(x))
        sht_code['ReducePeriod'] = sht_code['ReducePeriod'].apply(lambda x:0 if x==fillNa else int(x))
        sht_code['InvalidPeriod'] = sht_code['InvalidPeriod'].apply(lambda x:0 if x==fillNa else int(x))
        return sht_code

    # 결합위험률시트
    @staticmethod
    def readCombSheet(excel_file : str, sheet_name : str = "결합위험률", header = 2, fillNa : str = "^"):
        sht_comb = pd.read_excel(excel_file, sheet_name=sheet_name, header=header).fillna(fillNa)
        sht_comb = sht_comb[['CoverageKey', 'CombRiskKey', 'Operation', 'NumRiskKey'] \
            + [f"RiskKey({i})" for i in range(1, 8+1)] + [f"Period({i})" for i in range(1, 8+1)]]
        sht_comb['Operation'] = sht_comb['Operation'].apply(lambda x:int(x))
        sht_comb['NumRiskKey'] = sht_comb['NumRiskKey'].apply(lambda x:int(x))
        for i in range(1, 8+1):
            sht_comb[f"Period({i})"] = sht_comb[f"Period({i})"].apply(lambda x:0 if x==fillNa else int(x))
        return sht_comb 

    ## 담보정보
    @staticmethod
    def getCoverageInfo(df_Code : pd.DataFrame, coverageKey : str, fillNa : str = "^"):
        """
        INPUT : 코드시트(dataframe), 담보키
        OUTPUT : 담보정보
        """
        
        df = df_Code.loc[df_Code['CoverageKey'] == coverageKey] 
        NumBenefit = df.shape[0] - 2    # 급부개수

        # 배열초기화
        # - 탈퇴 정보 (exit)        
        ExitCode = [fillNa]*(NumBenefit+1)        # 탈퇴위험률코드
        ExitType = [fillNa]*(NumBenefit+1)        # 탈퇴위험률 Type
        NonCov = [0]*(NumBenefit+1)             # 부담보기간
        # - 급부 정보 (benefit)
        BenefitCode = [fillNa]*(NumBenefit+1)     # 급부위험률코드
        BenefitType = [fillNa]*(NumBenefit+1)     # 급부위험률 Type
        PayRate = [1.]*(NumBenefit+1)           # 지급률
        ReduceRate = [0.]*(NumBenefit+1)        # 감액률 
        ReducePeriod = [0]*(NumBenefit+1)       # 감액기간
        # - 납면 (grant)
        GrantCode = fillNa                        # 납입면제위험률코드
        GrantType = fillNa                        # 납입면제위험률Type
        InvalidPeriod = 0                       # 무효해지기간

        # 배열 채우기
        for row in df.values:
            # unpack
            _, bNum, eCode, eType, nCov, \
                bCode, bType, pRate, rRate, rPeriod, \
                    gCode, gType, iPeriod = row

            # string ---> int
            bNum = int(bNum)

            # 납면 (grant)
            if bNum == 99:
                GrantCode = gCode 
                GrantType = gType
                InvalidPeriod = iPeriod
            else:
                # 급부지급 (benefit)
                if bNum!=0:
                    BenefitCode[bNum] = bCode
                    BenefitType[bNum] = bType
                    PayRate[bNum] = pRate
                    ReduceRate[bNum] = rRate
                    ReducePeriod[bNum] = rPeriod
                
                # 탈퇴 (exit)
                ExitCode[bNum] = eCode
                ExitType[bNum] = eType
                NonCov[bNum] = nCov

        # 담보 정보 return
        return NumBenefit, ExitCode, ExitType, NonCov,\
            BenefitCode, BenefitType, PayRate, ReduceRate, ReducePeriod, \
                GrantCode, GrantType, InvalidPeriod 

    
    ## Qx 배열 가져오기
    # 위험률코드, 위험률Type으로 가져오기
    @staticmethod
    def getQxWithCode(riskCode : str, riskType : str, df_Qx : pd.DataFrame, sex : int,\
        injure : int = None, driver : int = None, w : int = 120):
        """
        INPUT : 위험률코드, 위험률Type, Qx시트(데이터프레임), 성별, 상해급수, 운전자급수, 한계연령(w)
        OUTPUT : qx = (q_0, q_1, q_2, ...., q_w)
        """

        if riskCode == None:
            return [0.]*w
        else:
            if riskType == "I":     # 상해급수
                riskKey = f"{riskCode}_{injure}"
            elif riskType == "D":   # 운전자급수
                riskKey = f"{riskCode}_{driver}"
            elif riskType != "C":
                riskKey = riskCode
            else:
                raise Exception(f'위험률 Type이 {riskType}로 들어옴')
        
        df = df_Qx.loc[df_Qx['RiskKey'] == riskKey]
        if sex == 1:
            df = df[['x', 'Male']]
        else:
            df = df[['x', 'Female']]
        
        qx = [0.]*w
        for (t,q) in df.values:
            # 단일률
            if t == "ZZ":
                return [q]*w
            else:
                qx[t] = q
        return qx

    # 위험률키로 가져오기
    @staticmethod
    def getQxWithKey(riskKey : str, df_Qx : pd.DataFrame, sex : int, w : int = 120):
        """
        INPUT : 위험률키, Qx시트(데이터프레임), 성별, 한계연령(w)
        OUTPUT : qx = (q_0, q_1, q_2, ...., q_w)
        """
                
        df = df_Qx.loc[df_Qx['RiskKey'] == riskKey]
        if sex == 1:
            df = df[['x', 'Male']]
        else:
            df = df[['x', 'Female']]

        qx = [0.]*w
        for (t,q) in df.values:
            # 단일률
            if t == "ZZ":
                return [q]*w
            else:
                qx[t] = q
        return qx


    ## 결합위험률 계산

    # q_comb = (1-k1) q1 + (1-k2) q2 + ....     if t = 0
    # q_comb = q1 + q2 + ....     if t > 0
    @staticmethod
    def sumQx(qx : np.array, kx : np.array):
        qx[:, 0] *= 1 - kx
        return np.sum(qx, axis = 0)

    # q_comb = 1 - (1-k1 x q1) x (1-k2 x q2) x ....     if t = 0
    # q_comb = 1 - (1 - q1) x (1 - q2) x ....     if t > 0
    @staticmethod
    def productQx(qx : np.array, kx : np.array):       
        qx[:, 0] *= 1 - kx      
        product = np.product(1-qx, axis = 0)      
        return 1-product


    ## 기수식 계산
    @staticmethod
    def calculateSymbols(NumBenefit : int, Ex : list, NonCov : list, \
        Bx : list, PayRate : list, ReduceRate : list, ReducePeriod : list, \
            Gx : list, InvalidPeriod : int, \
                n : int, v:float, l0 : int = 100000) -> dict:
        """
        INPUT : 담보정보, 보험기간, v
        OUPUT : 기수식 dictionary
        """
        
        proj = n+1
        
        Ex = np.array(Ex)
        Bx = np.array(Bx)
        Gx = np.array(Gx)

        lx = np.zeros(shape=(NumBenefit+1, proj))
        lxPrime = np.zeros(proj)
        Dx = np.zeros(proj)
        DxPrime = np.zeros(proj)
        Nx = np.zeros(proj)
        NxPrime = np.zeros(proj)
        Cx = np.zeros(shape=(NumBenefit+1, proj))
        Mx = np.zeros(shape=(NumBenefit+1, proj))
        SUMx = np.zeros(proj)        
     
        # lx
        lx[:, 0] = l0
        for i in range(NumBenefit+1):
            for t in range(n):
                if t==0:
                    lx[i, t+1] = lx[i][t] * (1-Ex[i][t]*(1-NonCov[i]/12))
                else:
                    lx[i, t+1] = lx[i][t] * (1-Ex[i][t])
        # l'x
        lxPrime[0] = l0
        for t in range(n):
            if t==0:
                lxPrime[t+1] = lxPrime[t] * (1-Gx[t]*(1-InvalidPeriod/12)) 
            else:
                lxPrime[t+1] = lxPrime[t] * (1-Gx[t])

        # Dx
        Dx = lx[0] * (v ** np.arange(proj))

        # D'x
        DxPrime = lxPrime * (v ** np.arange(proj))

        # Cx
        for i in range(1, NumBenefit+1):
            Cx[i] = lx[i] * Bx[i] * (v**(np.arange(proj)+0.5))      
      
        # Nx
        Nx[-1] = Dx[-1]
        for t in range(n)[::-1]:
            Nx[t] = Nx[t+1]+Dx[t]
        
        # N'x
        NxPrime[-1] = DxPrime[-1]
        for t in range(n)[::-1]:
            NxPrime[t] = NxPrime[t+1]+DxPrime[t]

        # Mx
        for i in range(1, NumBenefit+1):
            Mx[:, -1] = Cx[:, -1]
            for t in range(n)[::-1]:
                Mx[:,t] = Mx[:,t+1]+Cx[:,t]

        # SUMx
        for i in range(1, NumBenefit+1):
            for t in range(proj):
                if t<ReducePeriod[i]:
                    SUMx[t] += PayRate[i] * ((1-ReduceRate[i])*(Mx[i][t]-Mx[i][ReducePeriod[i]])\
                        +(Mx[i][ReducePeriod[i]]-Mx[i][n]))
                else:
                    SUMx[t] += PayRate[i] * (Mx[i][t]-Mx[i][n])

        symbolsDict = {'lx' : lx, "l'x" : lxPrime, "Dx" : Dx, "D'x" : Dx,\
            "Cx" : Cx, "Mx" : Mx, "SUMx" : SUMx, "Nx" : Nx, "N'x" : NxPrime, \
                'Ex' : Ex, 'Bx' : Bx, 'Gx' : Gx, 'NumBenefit' : NumBenefit}

        return symbolsDict
