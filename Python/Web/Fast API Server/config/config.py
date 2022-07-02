from dataclasses import asdict, dataclass
from os import path

@dataclass
class BaseConfig:
    BASE_DIR: str = path.dirname(path.dirname(path.dirname(path.abspath(__file__))))
    DB_POOL_RECYCLE: int = 900
    DB_ECHO: bool = True
    DEBUG: bool = False
    TEST_MODE: bool = False
    DB_USER:str = 'karma'
    DB_PASSWORD:str = '1221'
    DB_IP:str = 'localhost'
    DB_NAME:str = 'myDB'
    DB_URL: str = 'mysql+pymysql://%s:%s@%s/%s?charset=%s' % (
        DB_USER, DB_PASSWORD, DB_IP, DB_NAME, 'utf8mb4'
    )        
    
@dataclass
class LocalConfig(BaseConfig):
    TRUSTED_HOSTS = ["*"]
    ALLOW_SITE = ["*"]
    DEBUG: bool = True

@dataclass
class ProdConfig(BaseConfig):
    TRUSTED_HOSTS = ["*"]
    ALLOW_SITE = ["*"]
    DEBUG: bool = False

@dataclass
class TestConfig(BaseConfig):
    TRUSTED_HOSTS = ["*"]
    ALLOW_SITE = ["*"]
    TEST_MODE: bool = True

def get_config(environment : str)->dict:
    if environment == 'prod':
        return asdict(ProdConfig())
    elif environment == 'local':
        return asdict(LocalConfig())
    return asdict(TestConfig())
