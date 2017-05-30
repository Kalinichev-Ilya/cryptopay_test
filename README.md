> Сделать описание, какие будут необходимы тесты для проверки корректной работы
Exchange Transfers через API.

# Test suite "Exchange Transfers":

#### Тест-кейс №1. Проверка на вводимое значение `Amount`

###### Шаги:
 1. Создать Post запрос:
 ```ruby
	url = https://sandbox.cryptopay.me/api/v2/exchange_transfers
	headers: { 'Content Type': 'application/x-www-form-urlencoded',
            'X-Api-Key': API Key пользователя.}
	body: { 'amount': сумма перевода,
		    'amount_currency': валюта поля Amount в формате BTC\EUR\USD\GBP,
		    'from_account': UUID аккаунта пользователя, с которого делается перевод,
		    'to_account': UUID аккаунта пользователя, на который делается перевод}
```
 2. Заполнить поле `amount` данными (см. Ожидаемый результат)
 3. Заполнить поля `amount_currency` = `BTC`, `from_account` = `BTC_UUID`, `to_account` = `EUR_UUID` (см. Приложение)
 4. Отправить запрос
 5. Получить ответ
 6. Сравнить ответ с ожидаемым результатом (см. Ожидаемый результат)

##### Ожидаемый результат:
---
| Входные данные                  | Ожидаемый результат |
|:--------------------------------|:--------------------|
| `amount` поле не заполнено      | Ошибка с текстом: `Amount must be greater than 0`|
| `amount = 0.00001`              | Ошибка с текстом: `Amount must be greater than 0`|
| `amount = 0.0001`               | Ошибка с текстом: `Amount must be greater than 0`|
| `amount = 0`                    | Ошибка с текстом: `Amount must be greater than 0`     |
| `amount = -1`                   | Ошибка с текстом: `Amount must be greater than 0`|
| `amount = [/D]` (Any non-digit) | Ошибка с текстом: `Amount must be a number`|
| `amount` больший чем на счете 'from_account'   | Ошибка с текстом: `Amount balance is not enough.`|
| `amount` меньший чем на счете 'from_account'   | Подтверждение операции, сообщение `Transfer successful`|

#### Тест-кейс №2. `from_account` и `to_account` не могут быть равны

###### Шаги:
1. Создать Post запрос:
 ```ruby
	url = https://sandbox.cryptopay.me/api/v2/exchange_transfers
	headers: { 'Content Type': 'application/x-www-form-urlencoded',
            'X-Api-Key': API Key пользователя.}
	body: { 'amount': сумма перевода,
		    'amount_currency': валюта поля Amount в формате BTC\EUR\USD\GBP,
		    'from_account': UUID аккаунта пользователя, с которого делается перевод,
		    'to_account': UUID аккаунта пользователя, на который делается перевод}
```
 2. Заполнить поле `amount`, число должно быть меньше, чем кол-во денег на счете
 3. Заполнить поля `amount_currency` = `USD`, `from_account` = `USD_UUID`, `to_account` = `USD_UUID` (см. Приложение)
 4. Отправить запрос
 5. В ответе получить сообщение о невозможности проведении транзакции `Account currencies must be different`


#### Тест-кейс №3. Проверка на изменение значений при совершении транзакции

###### Шаги:
1. Создать Post запрос:
 ```ruby
	url = https://sandbox.cryptopay.me/api/v2/exchange_transfers
	headers: { 'Content Type': 'application/x-www-form-urlencoded',
            'X-Api-Key': API Key пользователя.}
	body: { 'amount': сумма перевода,
		    'amount_currency': валюта поля Amount в формате BTC\EUR\USD\GBP,
		    'from_account': UUID аккаунта пользователя, с которого делается перевод,
		    'to_account': UUID аккаунта пользователя, на который делается перевод}
```
 2. Заполнить поле `amount`, число должно быть меньше, чем кол-во денег на счете
 3. Заполнить поля `amount_currency` = `GBP`, `from_account` = `GBP_UUID`, `to_account` = `EUR_UUID` (см. Приложение)
 4. Отправить запрос
 5. Получить ответ
 6. Сравнить ответ с ожидаемым результатом (см. Ожидаемый результат)
 ---
| Ожидаемый результат |
|:--------------------|
| сумма на `from_account` уменьшилась на `amount + (amount * 0,01)` |
| сумма на `to_account` увеличилась на `amount * текущий курс` |
