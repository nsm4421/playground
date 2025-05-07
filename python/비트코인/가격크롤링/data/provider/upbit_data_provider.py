import requests

from .base_data_provider import CoinDataProvider, CoinData

class UpbitDataProvider(CoinDataProvider):
    
    def __init__(self, **kwargs):
        super().__init__(**kwargs)
        self.base_url = 'https://api.upbit.com/v1/candles/minutes/1'
    
    def get_data(self):
        try:            
            response = requests.get(self.base_url, params={'market':self.market, 'interval':self.interval})
            response.raise_for_status()
            data = response.json()[0]
            parsed = {
                "type": "primary_candle",
                "market": self.market,
                "date_time": data["candle_date_time_kst"],
                "opening_price": data["opening_price"],
                "high_price": data["high_price"],
                "low_price": data["low_price"],
                "closing_price": data["trade_price"],
                "acc_price": data["candle_acc_trade_price"],
                "acc_volume": data["candle_acc_trade_volume"]
            }
            return CoinData(**parsed)
        except ValueError as e:
            raise UserWarning("Invalid response format from the server. Could not parse JSON") from e
        except requests.exceptions.HTTPError as e:
            raise UserWarning(f"HTTP error occurred: {e.response.status_code} {e.response.reason}") from e
        except requests.exceptions.RequestException as e:
            raise UserWarning("Network-related error occurred while fetching data") from e
        except KeyError as e:
            raise UserWarning(f"Missing expected data in the response: {e.args[0]}") from e
        except Exception as e:
            raise UserWarning("Unknwon") from e
        
        