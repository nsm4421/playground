#===================== 영업보험료 확인 =====================#
sht_G = pd.read_excel("./INFO.xlsx", sheet_name="영업보험료 확인", header=1).fillna(0.)

cnt_error = 0
for i, row in enumerate(sht_G.values):
    _, hyung, re, _, _, sex, x, n, m, G = row
    Cal.setArgs(x, sex, n, m, re, hyung)
    result = Cal.main()
    if result['G']!=G:
        print(f"{i+1}th case - Cal : {result['G']} / G : {G}")
        cnt_error+=1
if cnt_error == 0:
    print(f"보험료 Pass")
 
#===================== 준비금 확인 =====================#
sht_V = pd.read_excel("./INFO.xlsx", sheet_name="준비금 확인", header=1).fillna(0.)

cnt_error = 0
for i, row in enumerate(sht_V.values):
    _, hyung, re, _, _, sex, x, n, m, NP_beta, V1, V3, V5, V7, V10, W1, W3, W5, W7, W10 = row
    tVx = [V1, V3, V5, V7, V10]
    tWx = [W1, W3, W5, W7, W10]
    Cal.setArgs(x, sex, n, m, re, hyung)
    result = Cal.main()
    if result['NP_beta']!=NP_beta:
        print(f"{i+1}th case - Cal : {result['NP_beta']} / 연납베타순보험료 : {NP_beta}")
        cnt_error+=1
    if result['tVx'][1] != V1:
        print(f"{i+1}th case - Cal : {result['tVx'][1]} / V(1) : {V1}")
        cnt_error += 1
    if result['tVx'][3] != V3:
        print(f"{i+1}th case - Cal : {result['tVx'][3]} / V(3) : {V3}")
        cnt_error += 1
    if result['tVx'][5] != V5:
        print(f"{i+1}th case - Cal : {result['tVx'][5]} / V(5) : {V5}")
        cnt_error += 1
    if result['tVx'][7] != V7:
        print(f"{i+1}th case - Cal : {result['tVx'][7]} / V(7) : {V7}")
        cnt_error += 1
    if result['tVx'][10] != V10:
        print(f"{i+1}th case - Cal : {result['tVx'][10]} / V(10) : {V10}")
        cnt_error += 1

    if result['tWx'][1] != W1:
        print(f"{i+1}th case - Cal : {result['tWx'][1]} / W(1) : {W1}")
        cnt_error += 1
    if result['tWx'][3] != W3:
        print(f"{i+1}th case - Cal : {result['tWx'][3]} / W(3) : {W3}")
        cnt_error += 1
    if result['tWx'][5] != W5:
        print(f"{i+1}th case - Cal : {result['tWx'][5]} / W(5) : {W5}")
        cnt_error += 1
    if result['tWx'][7] != W7:
        print(f"{i+1}th case - Cal : {result['tWx'][7]} / W(7) : {W7}")
        cnt_error += 1
    if result['tWx'][10] != W10:
        print(f"{i+1}th case - Cal : {result['tWx'][10]} / W(10) : {W10}")
        cnt_error += 1
if cnt_error == 0:
    print(f"준비금 & 환급금 Pass")
