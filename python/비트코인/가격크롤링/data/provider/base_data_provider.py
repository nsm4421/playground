from abc import ABC, abstractmethod
from dataclasses import dataclass
from enum import Enum

@dataclass
class CoinData:
    type:str
    market: str
    date_time: str
    opening_price: float
    high_price: float
    low_price: float
    closing_price: float
    acc_price: float
    acc_volume: float

class CoinDataProvider(ABC):
    def __init__(self, **kwargs):
        market = kwargs.get('market')
        interval = kwargs.get('interval', 1)
        
        if(not isinstance(market, str)) or not(market in ["KRW-BTC", "KRW-ETH", "KRW-XRP"]):
            raise UserWarning("market is out of option")
        elif (not isinstance(interval, int) or not (interval in [1, 3, 5, 10])):
            raise UserWarning("interval is out of option")
        
        self.market : str = market
        self.interval : int = interval

    @abstractmethod
    def get_data(self) -> CoinData:
        pass