import sys
from PyQt5.QtWidgets import QApplication, QWidget, QLabel, QLineEdit, QPushButton, QComboBox
from pytube import YouTube as yt

class MyApp(QWidget):
 
    def __init__(self):
        super().__init__()

        # Label 
        self.lbl = QLabel(self)
        self.lbl.setText("URL")
        self.lbl.move(10, 20)

        self.lbl2 = QLabel(self)
        self.lbl2.setText("-"*10)
        self.lbl2.move(10, 180)
 
        # QLineEdit 
        self.qle = QLineEdit(self)
        self.qle.setEchoMode(QLineEdit.Normal)
        self.qle.move(10, 60)

        # ComboBox
        self.cmb = QComboBox(self)
        self.cmb.addItem("음향")
        self.cmb.addItem("영상")
        self.cmb.move(10, 100)
 
        # Button
        self.btn = QPushButton("다운로드", self)	# 버튼 텍스트
        self.btn.clicked.connect(self.download)
        self.btn.move(10, 140)

        # 제목
        self.setWindowTitle('유튭다운')

        # 화면 위치 및 너비
        self.setGeometry(300, 150, 300, 300)    # x, y, w, h
        self.show()
 

    def download(self):
        self.btn.clicked = True
        url = self.qle.text()
        option = self.cmb.currentText()
        try:
            my_streams = yt(url).streams
            if option == "음향":   
                my_stream = my_streams.filter(only_audio=True)[0]
            else: 
                my_stream = my_streams.get_highest_resolution()
            my_stream.download()
            self.qle.setText("")
            self.lbl2.setText("다운 성공")
        except:
            self.lbl2.setText("다운 실패")
        # self.btn.text="다운로드"

 
if __name__ == '__main__':
    
    app = QApplication(sys.argv)
    ex = MyApp()
    sys.exit(app.exec_())