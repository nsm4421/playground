import sys
import os
import unittest

sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))

from data.provider.base_data_provider import CoinData
from data.provider.upbit_data_provider import UpbitDataProvider

class UpbitDataProviderTest(unittest.TestCase):
        
    def test_ifMarketIsNotGiven(self):
        instance = UpbitDataProvider(market="KRW-BTC", interval=1)
        data = instance.get_data()
        self.assertIsInstance(data, CoinData)
            
if __name__ == '__main__':
    unittest.main()