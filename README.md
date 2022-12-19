# CryptoTest

Glade Assessment Test. 

This little project aims at showing updated price action for some cryptocurrency in the market and also a feature for converting any value of any crptocurrency to the current naira market value.

 public APIs uesed in this project:

- [ApiLayer Currency Data Api](https://apilayer.com/marketplace/currency_data-api?utm_source=apilayermarketplace&utm_medium=featured): for exchange rate between Dollar and Naira
- [Coinmarketcap](https://coinmarketcap.com/api/documentation/v1/#operation/getV2CryptocurrencyQuotesLatest): for the current prices of the cryptocurrencies
  
Packages Used in this project:

- [Dio](https://pub.dev/packages/dio): for  http calls 
- [Riverpod](https://riverpod.dev/) : for app's state management
- [Http Mock Adapter](https://pub.dev/packages/http_mock_adapter): mocking package for Dio for testing. and to mock request-response communication.