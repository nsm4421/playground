from pytube import YouTube as yt
import time
import sys

print("YouTube Downloader")

#---- URL check ----#
error = True
while error:           
    url = input("Type URL : ")   # URL 입력 받기
    my_streams = yt(url).streams
    error = False


#---- option ----#
option = input("Audio only (Y) / Video (N) :")   # option 입력 받기
while option not in ("Y", "N"):   # 옵션이 Y, N중에 없으면 계속 다시 물어보기
    option = input("Audio only? : Y/N --> ") 
if option == "Y":   # 음향파일만 다운 받는 경우
    my_stream = my_streams.filter(only_audio=True)[0]
else:    # 영상+음향 받는경우
    my_stream = my_streams.get_highest_resolution()

#---- Download ----#
if my_stream is None:   # 다운 받을 영상이 없으면
    print("No video to download")
    sys.exit()   # 종료
else:
    start_time = time.time()   # 다운로드 시작시간
    print(f"Start to download {my_stream}")
    my_stream.download()   # 다운로드
    passed_time = time.time() - start_time   # 다운로드에 걸린시간
    print(f"Time passed : {int(passed_time/60)} min {int(passed_time%60)} sec")
