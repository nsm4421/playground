from os import path, environ
from dataclasses import dataclass

current_file_path = path.abspath(__file__)
depth = 3   # 프로젝트 root기준으로 현재 파일까지 Depth
for _ in range(depth):
    base_dir = path.dirname(current_file_path)
    
@dataclass
class CommonConfig:
    BASE_DIR = base_dir
    DB_POOL_RECYCLE:int = 900
    DB_ECHO:bool = True

@dataclass
class LocalConfig(CommonConfig):
    PROJECT_RELOAD:bool = True
    # username : karma / password : 1221 / database name : chat
    DB_URL:str="postgresql://karma:1221@localhost/chat" 
    
@dataclass
class ProductionConfig(CommonConfig):
    PROJECT_RELOAD:bool = False
    
def get_config():
    """
    현재 설정값을 가져오는 함수
    """
    config = dict(prod=ProductionConfig(), local=LocalConfig())
    return config.get(environ.get('API_ENV', 'local'))