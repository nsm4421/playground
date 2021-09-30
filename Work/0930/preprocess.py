# To add a new cell, type '# %%'
# To add a new markdown cell, type '# %% [markdown]'
# %% [markdown]
# # 전처리 하는 예제

# %%
# 필요한 모듈 import
import numpy as np
import pandas as pd
import os
from tqdm import tqdm


# %%
# 현재 디렉터리에 있는 파일 확인
print(f"현재 디렉터리 : {os.getcwd()}")
for i, file_name in enumerate(os.listdir()):
    print(f"{i+1}번째 파일 : {file_name}")

# %% [markdown]
# ## Step 1) 텍스트 파일 전처리 함수 만들기

# %%
def split_txt_file(df : pd.DataFrame, columns : list = None,     pad : str = "P", blank : str = "_") -> pd.DataFrame:
    """
    df : DataFrame
    columns : 정리된 dataframe의 컬럼명
    pad : padding에 사용할 문자
    blank : 공백에 사용할 문자
    """

    # 오류가 나지 않게 하기 위한 조건
    assert len(pad) == 1 and len(blank) == 1         and pad != ' ' and blank != ' '             and isinstance(pad, str) and isinstance(blank, str)

    line = [blank]*len(df.values[0][0])  
    for row in tqdm(df.values):
        for i, letter in enumerate(row[0]):
            if letter!=" ":               
                line[i] = pad
    start_idx, end_idx = [], []
    line = [blank]+line+[blank]
    line = ''.join(line)

    for i in range(len(line)-1):
        if line[i] == blank and line[i+1] !=blank:
            start_idx.append(i)
        if line[i] != blank and line[i+1] == blank:
            end_idx.append(i)

    split_function = lambda x:[(blank+x+blank)[s_idx+1:e_idx+1].strip() for (s_idx, e_idx) in zip(start_idx, end_idx)]

    new_df = [split_function(row[0]) for row in tqdm(df.values)]
    
    if columns == None:return pd.DataFrame(new_df)
    else:return pd.DataFrame(new_df, columns = columns)

# %% [markdown]
# ## Step 2) 보험료 테이블 가공하기

# %%
# 보험료 테이블 읽기
df_P = pd.read_csv('Tab_P.txt', header=None)
print(df_P.values[0][0])
df_P.head()


# %%
# 텍스트 파일 쪼개기
df_P_preprocessed = split_txt_file(df_P).head()
df_P_preprocessed.head()


# %%
# 컬럼명 달아주기
df_P_preprocessed = split_txt_file(df_P, columns= ['일련번호&확장번호', '납입주기', '보험기간&납입기간',     '성별', '연령', '?', '최초/갱신여부', '경과기간', '최초가입연령', '영업보험료', '가입금액'])
df_P_preprocessed.head()

# %% [markdown]
# 추가적인 전처리
# 
# - 일련번호&확장번호 ---> 일련번호, 확장번호로 쪼개기
# - 보험기간&납입기간 ---> 보험기간, 납입기간으로 쪼개기
# - ? ---> 지우기 (표준체구분여부 컬럼은 필요 없음)

# %%
df_P_preprocessed['일련번호'] = df_P_preprocessed['일련번호&확장번호'].apply(lambda x:int(x[1:8]))
df_P_preprocessed['확장번호'] = df_P_preprocessed['일련번호&확장번호'].apply(lambda x:int(x[8:]))
df_P_preprocessed['보험기간'] = df_P_preprocessed['보험기간&납입기간'].apply(lambda x:int(x[:2]))
df_P_preprocessed['납입기간'] = df_P_preprocessed['보험기간&납입기간'].apply(lambda x:int(x[2:]))
df_P_preprocessed = df_P_preprocessed.drop(['일련번호&확장번호', '보험기간&납입기간', '?'], axis = 1)
df_P_preprocessed.tail()

# %% [markdown]
# 컬럼순서 바꿔주기

# %%
print(df_P_preprocessed.columns)


# %%
df_P_preprocessed = df_P_preprocessed[['일련번호', '확장번호', '보험기간', '납입기간',     '납입주기', '성별', '연령', '최초/갱신여부', '경과기간', '최초가입연령', '영업보험료', '가입금액']]
df_P_preprocessed.head()


# %%
# 일련번호는 1~6962번
np.unique(df_P_preprocessed['일련번호'])


# %%
# 자료형 string ---> integer
for column in df_P_preprocessed.columns:
    df_P_preprocessed[column] = df_P_preprocessed[column].apply(lambda x:0 if x=='' else int(x))


# %%
new_df_P = np.zeros((6962, 14))
for row in tqdm(df_P_preprocessed.values):
    # unpack
    serialNum, expandNum, n, m, m_, sex, x, re, passYear, fistJoinAge, G, AMT = row
    
    new_df_P[serialNum-1, 0] = serialNum              # 0 : 일련번호
    new_df_P[serialNum-1, 1] = expandNum              # 1 : 확장번호
    new_df_P[serialNum-1, 2] = n                      # 2 : 보험기간
    new_df_P[serialNum-1, 3] = m                      # 3 : 납입기간 
    if int(m_) == 1:new_df_P[serialNum-1, 4] = G           # 4 : 월납보험료
    if int(m_) == 3:new_df_P[serialNum-1, 5] = G           # 5 : 3월납보험료
    if int(m_) == 6:new_df_P[serialNum-1, 6] = G           # 6 : 6월납보험료
    if int(m_) == 12:new_df_P[serialNum-1, 7] = G          # 7 : 연납보험료
    new_df_P[serialNum-1, 8] = sex                    # 8 : 성별
    new_df_P[serialNum-1, 9] = x                      # 9 : 연령
    new_df_P[serialNum-1, 10] = re                    # 10 : 최초/갱신여부
    new_df_P[serialNum-1, 11] = passYear              # 11 : 경과기간
    new_df_P[serialNum-1, 12] = fistJoinAge           # 12 : 최초가입연령
    new_df_P[serialNum-1, 13] = AMT                   # 13 : 가입금액

new_df_P = pd.DataFrame(new_df_P, columns = ['일련번호', '확장번호', '보험기간', '납입기간',     'G12', 'G4', 'G2', 'G1', 'sex', 'x', 're', '경과년수', '최초가입연령', '가입금액'])
new_df_P['일련번호'] = new_df_P['일련번호'].apply(lambda x:int(x))
print(new_df_P.shape)
new_df_P.head()

# %% [markdown]
# ## 준비금 테이블 전처리

# %%
# 준비금 테이블 읽기
df_V = pd.read_csv('Tab_V.txt', header=None)
print(df_V.values[0][0])
df_V.head()


# %%
# 준비금 테이블 쪼개기
df_V_preprocessed = split_txt_file(df_V)
df_V_preprocessed.head()


# %%
# 컬럼명 붙여주기
df_V_preprocessed = split_txt_file(df_V, columns = ['일련번호', 't', '가입금액',     '기시준비금', '기말준비금','?', 'NP1', 'NP2', 'NP4', 'NP12', '자연식위험보험료',         'Beta1', 'Beta2', 'Beta4', 'Beta12'])
df_V_preprocessed.tail()


# %%
# 필요없는 컬럼 버리기
df_V_preprocessed['일련번호'] = df_V_preprocessed['일련번호'].apply(lambda x:int(x[1:]))
df_V_preprocessed = df_V_preprocessed.drop(['기말준비금', '자연식위험보험료',     '?', 'Beta1', 'Beta2', 'Beta4', 'Beta12', '가입금액'], axis = 1)

# 자료형 string ---> integer
for column in df_V_preprocessed.columns:
    df_V_preprocessed[column] = df_V_preprocessed[column].apply(lambda x:0 if x=='' else int(x))
    
df_V_preprocessed.tail()

# %% [markdown]
# ## JOIN
# 
# - 일련번호가 1~6962

# %%
# 일련번호는 1~6962번
np.unique(df_V_preprocessed['일련번호'])


# %%
# 전처리
new_df_V = np.zeros((6962, 8))
for row in df_V_preprocessed.values:
    # unpack
    serialNum, t, V, NP1, NP2, NP4, NP12 = row
    new_df_V[serialNum-1, 0] = serialNum              # 0 : 일련번호
    if t == 0:new_df_V[serialNum-1, 1] = V            # 1 : V0
    elif t == 1:new_df_V[serialNum-1, 2] = V          # 2 : V1
    elif t == 2:new_df_V[serialNum-1, 3] = V           # 3 : V2
    new_df_V[serialNum-1, 4] = NP1                    # 5 : 연납보험료
    new_df_V[serialNum-1, 5] = NP2                    # 6 : 6월납보험료
    new_df_V[serialNum-1, 6] = NP4                    # 7 : 3월납보험료
    new_df_V[serialNum-1, 7] = NP12                   # 8 : 월납보험료
new_df_V = pd.DataFrame(new_df_V, columns = ['일련번호', 'V0', 'V1', 'V2',     'NP1', 'NP2', 'NP4', 'NP12'])
new_df_V['일련번호'] = new_df_V['일련번호'].apply(lambda x:int(x))
print(new_df_V.shape)
new_df_V.tail()

# %% [markdown]
# ## Table Join 하기
# 
#     일련번호로 보험료 테이블, 준비금 테이블을 Join하기
# 
#     Inner Join시 테이블 행 개수가 같은지 확인하기!

# %%
df_joined = pd.merge(left = new_df_P,     right = new_df_V,         left_on = "일련번호", right_on = "일련번호",             how = "inner")
print(f"보험료 테이블 크기 : {new_df_P.shape}")
print(f"준비금 테이블 크기 : {new_df_V.shape}")
print(f"Joined 테이블 크기 : {df_joined.shape}")
df_joined.head()


# %%
df_joined.tail()


# %%
for column in df_joined.columns:
    df_joined[column] = df_joined[column].apply(lambda x:int(x))
df_joined.head()

# %% [markdown]
# ## 저장

# %%
df_joined.to_csv('./전처리완료.csv', index=None, encoding = "CP949")


# %%



