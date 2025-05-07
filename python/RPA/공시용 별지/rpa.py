import os
import win32com.client as win32
from PyPDF2 import PdfMerger
import os
import winreg
import shutil

class RPA:

    @staticmethod
    def remove_cache(gen_py_dir):
        if (os.path.isdir(gen_py_dir)):
            shutil.rmtree(os.path.abspath(gen_py_dir))

    @staticmethod
    def set_registry_key(secure_module_path, regostry_key_name ="AutomationModule", winup_path="Software\HNC\HwpAutomation\Modules"):
        winreg.CreateKey(winreg.HKEY_CURRENT_USER, winup_path)
        key_path = winreg.OpenKey(winreg.HKEY_CURRENT_USER, winup_path,  0, winreg.KEY_ALL_ACCESS)
        winreg.SetValueEx(key_path, regostry_key_name, 0, winreg.REG_SZ, os.path.abspath(secure_module_path))
        winreg.CloseKey(key_path)

    @staticmethod
    def open_hwp_doc(hwp_file_path: str, is_visible:bool = True) -> any:
        hwp = win32.gencache.EnsureDispatch("HWPFrame.HwpObject")
        try:
            hwp.RegisterModule('FilePathCheckDLL', 'AutomationModule')
            hwp.XHwpWindows.Item(0).Visible = is_visible     
            hwp.Open(os.path.abspath(hwp_file_path))               
            return hwp
        except:
            hwp.Quit()
            raise RuntimeError("Error occurs while opening hwp file")
    
    @staticmethod
    def close_hwp_doc(hwp) -> None:
        hwp.XHwpDocuments.Close(isDirty=False)
        hwp.Quit()

    @staticmethod
    def change_text_color(hwp: any) -> None:
        # red → black
        option = hwp.HParameterSet.HFindReplace
        hwp.HAction.GetDefault("AllReplace", option.HSet)
        option.FindString = ""
        option.ReplaceString = ""
        option.IgnoreMessage = 1
        option.FindCharShape.TextColor = hwp.RGBColor(255, 0, 0)
        option.ReplaceCharShape.TextColor = hwp.RGBColor(0, 0, 0)
        hwp.HAction.Execute("AllReplace", option.HSet)
        
        # blue → black
        option = hwp.HParameterSet.HFindReplace
        hwp.HAction.GetDefault("AllReplace", option.HSet)
        option.FindString = ""
        option.ReplaceString = ""
        option.IgnoreMessage = 1
        option.FindCharShape.TextColor = hwp.RGBColor(0, 0, 255)
        option.ReplaceCharShape.TextColor = hwp.RGBColor(0, 0, 0)
        hwp.HAction.Execute("AllReplace", option.HSet)

    @staticmethod
    def convert_hwp_to_pdf(hwp, path_to_save_pdf, printmethod=0) -> None:
        action = hwp.CreateAction("Print")
        print_setting = action.CreateSet()
        action.GetDefault(print_setting)
        print_setting.SetItem("PrintMethod", printmethod)
        print_setting.SetItem("FileName", os.path.abspath(path_to_save_pdf))
        print_setting.SetItem("PrinterName", "Microsoft Print to PDF")
        action.Execute(print_setting)

    @staticmethod
    def merge_pdf(pdf_files: list, save_file_path: str) -> None:
        pdf_merger = PdfMerger(strict=False)
        for file in pdf_files:
            pdf_merger.append(file)
        pdf_merger.write(save_file_path)
        pdf_merger.close()