from itertools import combinations

# 가입조건
class Condition:
    def __init__(cls, **kds):
        cls.covSeq = int(kds.get('covSeq'))         # 담보순번
        cls.jong = int(kds.get('jong'))             # 종
        cls.hyung = int(kds.get('hyung'))           # 형
        cls.re = int(kds.get('re'))                 # 신규갱신
        cls.reTerm = int(kds.get('reTerm'))         # 갱신주기
        cls.n = int(kds.get('n'))                   # 만기
        cls.nn = int(kds.get('nn'))                 # 실만기
        cls.m = int(kds.get('m'))                   # 납기
        cls.mm = int(kds.get('mm'))                 # 실납기        
        for k in kds.keys():
            assert k in ['covSeq', 'jong', 'hyung', 're', 'reTerm', 'n', 'nn', 'm', 'mm'] 
         
    def __repr__(cls) -> str:
        return f'담보순번:{cls.covSeq}|종:{cls.jong}|형:{cls.hyung}|신규갱신:{cls.re}|갱신주기:{cls.reTerm}|만기:{cls.n}|실만기:{cls.nn}|납기:{cls.m}|실납기:{cls.mm}'
  
    def __eq__(cls, other: object) -> bool:
        # type 오류인 경우 -> False
        if not isinstance(other, cls.__class__):
            Exception('Type Error')
        return (other.covSeq == cls.covSeq) and \
            (other.jong == cls.jong) and \
            (other.hyung == cls.hyung) and \
            (other.re == cls.re) and \
            (other.reTerm == cls.reTerm) and \
            (other.n == cls.n) and \
            (other.nn == cls.nn) and \
            (other.m == cls.m) and \
            (other.mm == cls.mm)
     
    # TODO : 담보별, 종별 포함관계, 세만기 케이스에 대해 가입조건 구현 필요함
    def __gt__(cls, other:object) -> bool:
        """
        1) 사업비 대소관계가 존재하지 않는 경우 False
        2) 사업비 대소관계가 존재하고, 더 큰 경우 True
        2) 사업비 대소관계가 존재하고, 더 작은 경우 False
        """
        if not isinstance(other, cls.__class__):
            Exception('Type Error')
        # 가입조건 비교가 불가(담보순번, 종, 형, 신규갱신 불일치) -> False   
        elif not((other.covSeq == cls.covSeq) and \
            (other.jong == cls.jong) and \
            (other.hyung == cls.hyung) and \
            (other.re == cls.re)):
            return False
        # 납만기 동일하고, 갱신주기만 다른 경우 -> 갱신주기로 비교
        elif ((cls.n >= other.n) and (cls.nn >= other.nn) and (cls.m >= other.m) and (cls.mm >= other.mm)):
            return cls.reTerm >= other.reTerm
        # 갱신주기가 동일하나 납만기가 다른 경우
        else:
            return (cls.n >= other.n) and (cls.nn >= other.nn) and (cls.m >= other.m) and (cls.mm >= other.mm) 
    
    def __lt__(cls, other:object) -> bool:
        """
        1) 사업비 대소관계가 존재하지 않는 경우 False
        2) 사업비 대소관계가 존재하고, 더 작은 경우 True
        2) 사업비 대소관계가 존재하고, 더 큰 경우 False
        """
        if not isinstance(other, cls.__class__):
            Exception('Type Error')
        elif not((other.covSeq == cls.covSeq) and \
            (other.jong == cls.jong) and \
            (other.hyung == cls.hyung) and \
            (other.re == cls.re)):
            return False
        # 납만기 동일하고, 갱신주기만 다른 경우 -> 갱신주기로 비교
        elif ((cls.n >= other.n) and (cls.nn >= other.nn) and (cls.m >= other.m) and (cls.mm >= other.mm)):
            return cls.reTerm <= other.reTerm
        # 갱신주기가 동일하나 납만기가 다른 경우
        else:
            return (cls.n <= other.n) and (cls.nn <= other.nn) and (cls.m <= other.m) and (cls.mm <= other.mm) 
        
# 사업비
class Expense:
    def __init__(cls, **kds):
        # 신계약비
        cls.a1 = float(kds.get('a1'))
        cls.a2 = float(kds.get('a2'))
        cls.a3 = float(kds.get('a3'))
        cls.a4 = float(kds.get('a4'))
        # 유지비
        cls.b1 = float(kds.get('b1'))
        cls.b2 = float(kds.get('b2'))       
        cls.b3 = float(kds.get('b3'))
        # 수금비
        cls.r = float(kds.get('r'))          
        # 손조비
        cls.ce1 = float(kds.get('ce1'))          
        cls.ce2 = float(kds.get('ce2'))
        for k in kds.keys():
            assert k in ['a1', 'a2', 'a3', 'a4', 'b1', 'b2', 'b3', 'r', 'ce1', 'ce2']

    def update(cls, lessThan:object)->None:
        """
        새로운 사업비(상위 사업비)가 주어지면 사업비 업데이트
        """
        if not (isinstance(lessThan, Expense)):
            Exception('Type Error')
        cls.a1 = min(lessThan.a1, cls.a1)
        cls.a2 = min(lessThan.a2, cls.a2)
        cls.a3 = min(lessThan.a3, cls.a3)
        cls.a4 = min(lessThan.a4, cls.a4)
        cls.b1 = min(lessThan.b1, cls.b1)
        cls.b2 = min(lessThan.b2, cls.b2)
        cls.b3 = min(lessThan.b3, cls.b3)
        cls.r = min(lessThan.r, cls.r)
        cls.ce1 = min(lessThan.ce1, cls.ce1)
        cls.ce2 = min(lessThan.ce2, cls.ce2)
            
    def __repr__(cls)->str:
        return f'a1:{cls.a1}|a2:{cls.a2}|a3:{cls.a3}|a4:{cls.a4}|b1:{cls.b1}|b2:{cls.b2}|b3:{cls.b3}|r1:{cls.r}|ce1:{cls.ce1}|ce2:{cls.ce2}'

    def __eq__(cls, other:object) -> bool:
        # type 오류인 경우 -> False
        if not isinstance(other, cls.__class__):
            Exception('Type Error') 
        return (cls.a1 == other.a1) and \
            (cls.a2 == other.a2) and \
            (cls.a3 == other.a3) and \
            (cls.a4 == other.a4) and \
            (cls.b1 == other.b1) and \
            (cls.b2 == other.b2) and \
            (cls.b3 == other.b3) and \
            (cls.r == other.r) and \
            (cls.ce1 == other.ce1) and \
            (cls.ce2 == other.ce2) 

    def __gt__(cls, other:object) -> bool:
        """
        1) 사업비 대소관계가 존재하지 않는 경우 False
        2) 사업비 대소관계가 존재하고, 더 큰 경우 True
        2) 사업비 대소관계가 존재하고, 더 작은 경우 False
        """
        # type 오류인 경우 -> False
        if not isinstance(other, cls.__class__):
            Exception('Type Error')
        return (cls.a1 > other.a1) and \
            (cls.a2 > other.a2) and \
            (cls.a3 > other.a3) and \
            (cls.a4 > other.a4) and \
            (cls.b1 > other.b1) and \
            (cls.b2 > other.b2) and \
            (cls.b3 > other.b3) and \
            (cls.r > other.r) and \
            (cls.ce1 > other.ce1) and \
            (cls.ce2 > other.ce2) 

    def __lt__(cls, other:object) -> bool:
        """
        1) 사업비 대소관계가 존재하지 않는 경우 False
        2) 사업비 대소관계가 존재하고, 더 작은 경우 True
        2) 사업비 대소관계가 존재하고, 더 큰 경우 False
        """
        # type 오류인 경우 -> False
        if not isinstance(other, cls.__class__):
            Exception('Type Error')
        return (cls.a1 < other.a1) and \
            (cls.a2 < other.a2) and \
            (cls.a3 < other.a3) and \
            (cls.a4 < other.a4) and \
            (cls.b1 < other.b1) and \
            (cls.b2 < other.b2) and \
            (cls.b3 < other.b3) and \
            (cls.r < other.r) and \
            (cls.ce1 < other.ce1) and \
            (cls.ce2 < other.ce2) 
            
    def __le__(cls, other:object)->bool:
        # type 오류인 경우 -> False
        if not isinstance(other, cls.__class__):
            Exception('Type Error')
        return (cls.a1 <= other.a1) and \
            (cls.a2 <= other.a2) and \
            (cls.a3 <= other.a3) and \
            (cls.a4 <= other.a4) and \
            (cls.b1 <= other.b1) and \
            (cls.b2 <= other.b2) and \
            (cls.b3 <= other.b3) and \
            (cls.r <= other.r) and \
            (cls.ce1 <= other.ce1) and \
            (cls.ce2 <= other.ce2) 

    def __ge__(cls, other:object)->bool:
        # type 오류인 경우 -> False
        if not isinstance(other, cls.__class__):
            Exception('Type Error')
        return (cls.a1 >= other.a1) and \
            (cls.a2 >= other.a2) and \
            (cls.a3 >= other.a3) and \
            (cls.a4 >= other.a4) and \
            (cls.b1 >= other.b1) and \
            (cls.b2 >= other.b2) and \
            (cls.b3 >= other.b3) and \
            (cls.r >= other.r) and \
            (cls.ce1 >= other.ce1) and \
            (cls.ce2 >= other.ce2) 
    
# 노드
class Node:
    def __init__(cls, **kds):
        cls.condition : Condition = kds.get('condition')
        cls.expense : Expense = kds.get('expense')
        for k in kds.keys():
            assert k in ['condition', 'expense']
            
    def __repr__(cls)->str:
        return f'condition:{cls.condition.__repr__}\nexpense:{cls.expense.__repr__}'

# 그래프 
class Graph:
    def __init__(cls, **kds):
        """
        그래프 세팅
            - nodes라는 멤버변수에 주어진 노드 저장
            - graph라는 멤버변수에 그래프 정보 저장
            - graph의 i번째 원소는 i번째 노드보다 사업비를 높게 걸어야 하는 노드 index
        """
        cls.nodes : list[Node] = kds.get('nodes')
        for k in kds.keys():
            assert k in ['nodes']
        cls.graph : list[list[int]] = [[] for _ in range(len(cls.nodes))]        
        for c in combinations(nodes, 2):
            l, r = c[0], c[1]
            l_idx, r_idx = cls.nodes.index(l), cls.nodes.index(r)
            if (l.condition > r.condition):
                cls.graph[r_idx].append(l_idx)
            elif (r.condition > l.condition):
                cls.graph[l_idx].append(r_idx)
    
    def nodeRepr(cls)->str:
        """
        각 노드에의 가입조건 및 사업비 출력
        """
        return '\n'.join([f'{n.condition} >> {n.expense}\n' for n in nodes])
    
    @property
    def isOk(cls)->bool:
        """
        현재 사업비 역전이 잡혀있는지 여부
        """
        for (idx, node) in enumerate(cls.nodes):
            for adjIdx in cls.graph[idx]:
                adj = cls.nodes[adjIdx]
                if not (node.expense <= adj.expense):
                    return False
        return True
    
    def update(cls)->None:
        """
        사업비 역전 누르기
        """
        while not cls.isOk:
            for idx, adjIdxLst in enumerate(cls.graph):
                node = cls.nodes[idx]
                for adjIdx in adjIdxLst:
                    adj = cls.nodes[adjIdx]
                    if not (node.expense <= adj.expense):
                        node.expense.update(adj.expense)
                        cls.nodes[idx] = node
                        continue
                    
    def foramt(cls, header:bool = False)->str:
        ret = '\t'.join(['담보순번','종','형','신규갱신','갱신주기','보기','실보기','납기','실납기',
                         'a1','a2','a3','a4','b1','b2','b3','r','ce1','ce2']) +'\n' if header else ''
        ret += '\n'.join(
            ['\t'.join(map(str, [node.condition.covSeq, 
                            node.condition.jong, 
                            node.condition.hyung, 
                            node.condition.re, 
                            node.condition.reTerm, 
                            node.condition.n, 
                            node.condition.nn, 
                            node.condition.m, 
                            node.condition.mm, 
                            node.expense.a1, 
                            node.expense.a2, 
                            node.expense.a3, 
                            node.expense.a4, 
                            node.expense.b1, 
                            node.expense.b2, 
                            node.expense.b3, 
                            node.expense.r, 
                            node.expense.ce1, 
                            node.expense.ce2])) for node in cls.nodes])
        return ret
     

if __name__ == '__main__':
    
    # 테스트용 데이터
    nodes : list[Node] = [
        Node(
            condition=Condition(covSeq=1, jong = 1, hyung = 1, n=0, nn=5, m=5, mm=5, re=1, reTerm=5), 
            expense=Expense(a1=30, a2=0, a3=0, a4=80, b1=0.2, b2=0, b3=0, r=0.06, ce1=0.05, ce2=0)
        ),
        Node(
            condition=Condition(covSeq=1, jong = 1, hyung = 1, n=10, nn=10, m=10, mm=10, re=1, reTerm=10), 
            expense=Expense(a1=30, a2=0, a3=0, a4=50, b1=0.2, b2=0, b3=0, r=0.04, ce1=0.05, ce2=0)
        ),
        Node(
            condition=Condition(covSeq=1, jong = 1, hyung = 1, n=20, nn=20, m=20, mm=20, re=1, reTerm=20), 
            expense=Expense(a1=20, a2=0, a3=0, a4=30, b1=0.5, b2=0, b3=0, r=0.03, ce1=0.05, ce2=0)
        ),
        Node(
            condition=Condition(covSeq=1, jong = 1, hyung = 1, n=30, nn=30, m=30, mm=30, re=1, reTerm=30), 
            expense=Expense(a1=30, a2=0, a3=0, a4=10, b1=0.50, b2=0, b3=0, r=0.01, ce1=0.05, ce2=0)
        )
    ]
    
    print('='*10, '사업비 변경전', '='*10)
    graph = Graph(nodes=nodes)
    print(graph.foramt(header=True))
    print('='*10, '사업비 변경후', '='*10)
    graph.update()
    print(graph.foramt(header=True))
    