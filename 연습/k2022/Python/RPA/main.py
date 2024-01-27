import win32com.client as win32
from os import mkdir, listdir
from os.path import abspath, join, exists
from PyPDF2 import PdfMerger
import pandas as pd
from tqdm import tqdm

class Rpa: 
    """
    공시용 별지 작성을 위해서 작성한 코드 - N -
    """

    @classmethod
    def run(cls,exel_file_path,hwp_dir,working_dir,pdf_dir):
        """
        params
            - exel_file_path : 주계약&독립특약 mapping list가 있는 Excel 파일 경로
            - hwp_dir : 별지 파일(hwp)들을 모아놓은 폴더 경로
            - working_dir : 작업용 파일을 저장해놓을 경로
            - pdf_dir : 수정된 공시용 파일(pdf)를 모아놓은 경로

        description
            - check_folder_exist : 필요한 파일과 폴더가 있는지 체크
            - save_modified_files_in_woring_dir : hwp_dir경로에 있는 한글파일들을 수정한 한글파일, pdf파일을 working_dir에 저장
            - get_ctr_mapping : 엑셀파일을 읽어서 주계약, 독립특약 mapping을 만듬
            - merge_pdf_files_by_mapping : ctr_mapping에 맞게 working_dr에 있는 pdf파일을 병합해서 pdf_dir에 저장
        """          
        cls.check_folder_exist(exel_file_path,hwp_dir,working_dir,pdf_dir)
        cls.save_modified_files_in_woring_dir(hwp_dir, working_dir)
        ctr_mapping = cls.get_ctr_mapping(exel_file_path)
        cls.merge_pdf_files_by_mapping(working_dir, ctr_mapping, pdf_dir)
    
    @classmethod
    def check_folder_exist(cls,exel_file_path,hwp_dir,working_dir,pdf_dir):
        """
        해당 경로에 폴더나 파일이 존재하는지 여부를 체크함
        """
        if not exists(exel_file_path):
            raise Exception("주계약/독특 mapping 별지 매핑용 Excel파일이 존재하지 않습니다....???")
        if not exists(hwp_dir):
            raise Exception("작업할 한글파일을 저장한 폴더가 안보입니다....???")
        for dir in [working_dir,pdf_dir]:
            if not exists(dir):
                mkdir(path=dir)

    @classmethod
    def save_modified_files_in_woring_dir(cls,hwp_dir,working_dir):
        """           
        한글파일들을 읽어서 검은글씨로 수정 후, hwp와 pdf 파일을 각각 작업용 파일 경로로 저장
        """
        print('한글파일 변환中...')
        for hwp_doc in tqdm(listdir(hwp_dir)):
            if '.hwp' in hwp_doc:
                hwp = cls.open_hwp_doc(join(hwp_dir, hwp_doc))
                cls.change_text_color(hwp)
                cls.save_hwp_doc(hwp, join(working_dir, hwp_doc))
                cls.convert_hwp_to_pdf(hwp, join(working_dir, hwp_doc.replace(".hwp",".pdf")))
                cls.close_hwp_doc(hwp)

    @classmethod
    def merge_pdf_files_by_mapping(cls, working_dir, ctr_mapping, pdf_dir, suffix = "공시용"):
        """
        list에 매핑에 맞게 pdf 파일들을 병합함
        """
        print('pdf 파일 병합 中...')
        for (k, v) in tqdm(ctr_mapping.items()):
            pdf_files = [k.replace('.hwp', '.pdf')] + [_v.replace('.hwp', '.pdf') for _v in v]
            pdf_save_path = join(pdf_dir, k.replace(".hwp", f"_{suffix}.pdf"))
            cls.merge_pdf(working_dir, pdf_files, pdf_save_path)

    @staticmethod
    def get_ctr_mapping(excel_file_path):
        """
        주계약&독립특약 매핑을 읽어오는 메써드
        엑셀 파일의 list라는 시트에 주계약/독립특약 이라는 컬럼에 파일명을 적어주어야 함
        """
        df = pd.read_excel(excel_file_path, sheet_name='list')
        return {k:df.loc[df['주계약'] == k]['독립특약'].values for k in set(df['주계약'].values)}

    @staticmethod
    def open_hwp_doc(hwp_file_path):
        """
        빈문서(아래한글)를 생성하는 메써드
        """
        hwp = win32.gencache.EnsureDispatch("HWPFrame.HwpObject")
        hwp.RegisterModule('FilePathCheckDLL', 'AutomationModule')
        hwp.XHwpWindows.Item(0).Visible
        hwp.Open(abspath(hwp_file_path))
        return hwp
    
    @staticmethod
    def save_hwp_doc(hwp, path):
        """
        한글 파일을 저장하는 메써드
        """
        hwp.SaveAs(abspath(path))

    @staticmethod
    def close_hwp_doc(hwp):
        """
        한글 파일을 닫는 메써드
        """
        hwp.XHwpDocuments.Close(isDirty=False) 
        hwp.Quit()  
    
    @staticmethod
    def change_text_color(hwp):
        """
        빨간글씨와 파란글씨를 검은글씨로 수정
        """
        option = hwp.HParameterSet.HFindReplace
        hwp.HAction.GetDefault("AllReplace", option.HSet)
        option.FindString = ""
        option.ReplaceString = ""
        option.IgnoreMessage = 1
        option.FindCharShape.TextColor = hwp.RGBColor(255, 0, 0)
        option.ReplaceCharShape.TextColor = hwp.RGBColor(0, 0, 0)
        hwp.HAction.Execute("AllReplace", option.HSet)

        option = hwp.HParameterSet.HFindReplace
        hwp.HAction.GetDefault("AllReplace", option.HSet)
        option.FindString = ""
        option.ReplaceString = ""
        option.IgnoreMessage = 1
        option.FindCharShape.TextColor = hwp.RGBColor(0, 0, 255)
        option.ReplaceCharShape.TextColor = hwp.RGBColor(0, 0, 0)
        hwp.HAction.Execute("AllReplace", option.HSet)

    @staticmethod
    def convert_hwp_to_pdf(hwp, pdf_file_path, printmethod=0):
        """
        한글 파일을 두쪽모음 해제 후 PDF 파일로 변환해주는 메써드
        """
        action = hwp.CreateAction("Print")
        print_setting = action.CreateSet()
        action.GetDefault(print_setting)
        print_setting.SetItem("PrintMethod", printmethod)  
        print_setting.SetItem("FileName", abspath(pdf_file_path)) 
        print_setting.SetItem("PrinterName", "Microsoft Print to PDF")
        action.Execute(print_setting)

    @staticmethod
    def merge_pdf(woriking_dir, pdf_files, save_file_path):
        """
        여러 pdf파일을 하나의 pdf 파일로 저장해주는 메써드
        """
        pdf_merger = PdfMerger(strict=False)
        pdf_files = [abspath(join(woriking_dir, p)) for p in pdf_files]
        for file in pdf_files:
            pdf_merger.append(file)
        pdf_merger.write(save_file_path)
        pdf_merger.close()

if __name__ == '__main__':

    rpa = Rpa()
    rpa.run(exel_file_path='./input/list.xlsx',hwp_dir='./input',working_dir='./work',pdf_dir='./output')
