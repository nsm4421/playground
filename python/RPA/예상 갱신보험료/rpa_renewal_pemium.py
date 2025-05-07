import os
from pyhtml2pdf import converter

class CoverageModel:
    """
    담보
        - coverage_name : 담보명
        - premimum_dict : 보험료 dictionary
    """
    def __init__(cls, coverage_name:str):
        cls.coverage_name = coverage_name
        cls.premimum_dict = {}

    def update(cls, age:int, premium:int):
        cls.premimum_dict[age] = premium
        
class ProductModel:
    """
    상품
        - product_name : 상품명
        - condition : 가입조건
        - coverage_dict : 담보 dictionary
    """
    def __init__(cls, product_name:str):
        cls.product_name = product_name
        cls.condition = None
        cls.coverage_dict = {}

    def update(cls, coverage_name:str, age:int, premium:int, condition:str):
        if (condition != None): cls.condition = condition
        coverage = cls.coverage_dict[coverage_name] if (coverage_name in cls.coverage_dict.keys()) \
            else CoverageModel(coverage_name=coverage_name)
        coverage.update(age=age, premium=premium)
        cls.coverage_dict[coverage_name] = coverage

class RenewalPremium:

    @property
    def html(cls)->str:
        return cls.__html_string()

    @property
    def product(cls)->str:
        return cls.__product
    
    @classmethod
    def set_product(cls, product:ProductModel):
        cls.__product = product

    @classmethod
    def save_html(cls, save_dir:str):
        """
        상품를 바탕으로 html 문서 생성
            - save_dir : html 파일 저장할 폴더경로
        """
        with open(f'{save_dir}/{cls.__product.product_name}.html', 'w', encoding='utf-8') as f:
            f.write(cls.__html_string())

    @staticmethod
    def html_to_pdf(html_dir:str, pdf_dir:str, product_name:str):
        """
        html을 pdf로 변환
        """
        html_path = os.path.abspath(os.path.join(html_dir, f'{product_name}.html'))
        pdf_path = os.path.abspath(os.path.join(pdf_dir, f'{product_name}.pdf'))
        converter.convert(f'file:///{html_path}', pdf_path)

    @classmethod
    def __html_string(cls)->str:
        """
        HTML 생성
        """
        rows = " ".join([cls.__html_for_coverage(c) for c in cls.__product.coverage_dict.values()])
        return f'''
            <!DOCTYPE html>
            <html lang="kr">
            <head>
                <meta charset="UTF-8"/>
                <meta name="viewport" content="width=device-width, initial-scale=1.0" />
                <title>예상갱신보험료</title>
            </head>
            <body>
                <h3>{cls.__product.product_name} 예상 갱신보험료 예시</h3>

                <div style="border: 1px solid; padding: 10px">
                <h3 style="text-align: center">&lt;예상 갱신보험료 예시&gt;</h3>
                <p style="text-align: right">(기준 : {cls.__product.condition})</p>
                <table style="width: 100%; border-collapse: collapse">
                    {cls.__html_for_header()}
                    <tbody>
                        {rows}
                    </tbody>
                </table>
                    {cls.__html_for_footer()}
                </div>
            </body>
            </html>
            '''
    
    @classmethod
    def __html_for_header(cls)->str:
        """
        테이블 헤더
        """
        return '''
                <thead style="background-color: #dcf2f1">
                    <th style="border: 1px solid #000000; text-align: center" colspan="2">구분</th>
                    <th style="border: 1px solid #000000; text-align: center">
                        1회 갱신
                    </th>
                    <th style="border: 1px solid #000000; text-align: center">
                        2회 갱신
                    </th>
                    <th style="border: 1px solid #000000; text-align: center">
                        3회 갱신
                    </th>
                    <th style="border: 1px solid #000000; text-align: center">
                        4회 갱신
                    </th>
                    <th style="border: 1px solid #000000; text-align: center">...</th>
                    <th style="border: 1px solid #000000; text-align: center">
                        00회 갱신
                    </th>
                </thead>
        '''
    
    @classmethod
    def __html_for_coverage(cls, coverage:CoverageModel)->str:
        """
        담보 1개의 연령별 예상 갱신보험료
        """
        items = list(coverage.premimum_dict.items())
        items.sort(key=lambda x:x[0])                                       # 연령순으로 정렬
        items = [(f'{i[0]}세',  '{:,}'.format(i[1])) for i in items]        # 연령에 "세" 붙이기
        items = items + [('', '') for _ in range(6-len(items))]             # 보험료가 없는 연령에는 빈 문자열

        return f'''
            <tr>
                <td rowspan="2" style="border: 1px solid #000000; text-align: center;">{coverage.coverage_name}</td>
                <td style="border: 1px solid #000000; text-align: center;">갱신시 나이</td>
                
                <td style="border: 1px solid #000000; text-align: center;">{items[0][0]}</td>
                <td style="border: 1px solid #000000; text-align: center;">{items[1][0]}</td>
                <td style="border: 1px solid #000000; text-align: center;">{items[2][0]}</td>
                <td style="border: 1px solid #000000; text-align: center;">{items[3][0]}</td>
                <td style="border: 1px solid #000000; text-align: center;">{items[4][0]}</td>
                <td style="border: 1px solid #000000; text-align: center;">{items[5][0]}</td>
            </tr>
            <tr>
                <td style="border: 1px solid #000000; text-align: center;">보험료</td>
                <td style="border: 1px solid #000000; text-align: center;">{items[0][1]}</td>       
                <td style="border: 1px solid #000000; text-align: center;">{items[1][1]}</td>       
                <td style="border: 1px solid #000000; text-align: center;">{items[2][1]}</td>       
                <td style="border: 1px solid #000000; text-align: center;">{items[3][1]}</td>       
                <td style="border: 1px solid #000000; text-align: center;">{items[4][1]}</td>       
                <td style="border: 1px solid #000000; text-align: center;">{items[5][1]}</td>       
            </tr>
        '''
    
    @classmethod
    def __html_for_footer(cls)->str:
        """
        안내문구
        """
        return '''
            <p style="font-size:0.8rem;">*00회 갱신보험료는 75세 이상 시점(또는 최대갱신나이 00세) 보험료를 포함합니다.</p>
            <p style="font-size:0.8rem;">※ 상기 예시는 75세 이상 시점 또는 최대 갱신 가능연령의 보험료를 포함하여 예시한 것으로, 최초계약 가입당시의 보험료율을 기준으로 산출(연령증가만 반영)하였으므로, 갱신시 보험요율이 변동될 경우 갱신시점의 보험료는 상기예시와 크게 달라질 수 있습니다.</p>
        '''