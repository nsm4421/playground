
from pytube import YouTube
clip_link = "https://www.youtube.com/watch?v=kEH-ABsHbFI"
yt = YouTube(clip_link)
streams = yt.streams
best_stream = streams.get_highest_resolution()
best_stream.download()

