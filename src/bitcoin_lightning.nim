from std/uri import parseUri, Uri
from std/httpcore import HttpMethod

type BitcoinLightning* = object  ## Bitcoin Lightning client object.
    apiKey*: string              ## API Key for the API.

template defaultHeaders*(self: BitcoinLightning): array[3, (string, string)] =
  ## Generate default HTTP Headers, the API uses only `"application/json"` and `"X-API-Key"` so size is fixed for performance.
  [("Content-Type", "application/json"), ("Accept", "application/json"), ("X-API-Key", self.apiKey)]

func newBitcoinLightning*(apiKey: string): BitcoinLightning =
  assert apiKey.len >= 32, "Bitcoin Lightning API key must be >= 32 char."
  BitcoinLightning(apiKey: apiKey)

proc getWallet*(self: BitcoinLightning): tuple[metod: HttpMethod, url: Uri, headers: array[3, (string, string)], body: string] =
  ## Get a Bitcoin Lightning wallet details, API returns `id` and `name` strings, and `balance` integer.
  result = (metod: HttpGet, url: parseUri("https://legend.lnbits.com/api/v1/wallet"), headers: self.defaultHeaders(), body: "")

proc getInvoice*(self: BitcoinLightning; amount: Positive): tuple[metod: HttpMethod, url: Uri, headers: array[3, (string, string)], body: string] =
  ## Create 1 new Bitcoin Lightning incoming invoice, API returns `payment_hash` and `payment_request` strings.
  var bodi = """{"unit":"sat","out":false,"memo":"nim","amount":"""
  bodi.addInt amount
  bodi.add '}'
  result = (metod: HttpPost, url: parseUri("https://legend.lnbits.com/api/v1/payments"), headers: self.defaultHeaders(), body: bodi)

proc payInvoice*(self: BitcoinLightning; bolt11: string): tuple[metod: HttpMethod, url: Uri, headers: array[3, (string, string)], body: string] =
  ## Create 1 new Bitcoin Lightning incoming invoice, API returns `payment_hash` string.
  assert bolt11.len > 0, "paymentHash must not be empty string."
  var bodi = """{"out":true,"bolt11":""""
  bodi.add bolt11
  bodi.add '"'
  bodi.add '}'
  result = (metod: HttpPost, url: parseUri("https://legend.lnbits.com/api/v1/payments"), headers: self.defaultHeaders(), body: bodi)

proc checkInvoice*(self: BitcoinLightning; paymentHash: string): tuple[metod: HttpMethod, url: Uri, headers: array[3, (string, string)], body: string] =
  ## Check 1 existing Bitcoin Lightning invoice, invoice can be incoming or outgoing, API returns `paid` bool.
  assert paymentHash.len > 0, "paymentHash must not be empty string."
  result = (metod: HttpGet, url: parseUri("https://legend.lnbits.com/api/v1/payments/" & paymentHash), headers: self.defaultHeaders(), body: "")

proc renameWallet*(self: BitcoinLightning; name: string): tuple[metod: HttpMethod, url: Uri, headers: array[3, (string, string)], body: string] =
  ## Rename a Bitcoin Lightning wallet.
  assert name.len > 0, "name must not be empty string."
  result = (metod: HttpPut, url: parseUri("https://legend.lnbits.com/api/v1/wallet/" & name), headers: self.defaultHeaders(), body: "")

proc deleteWallet*(self: BitcoinLightning; name: string): tuple[metod: HttpMethod, url: Uri, headers: array[3, (string, string)], body: string] =
  ## Delete a Bitcoin Lightning wallet.
  assert name.len > 0, "name must not be empty string."
  result = (metod: HttpPut, url: parseUri("https://legend.lnbits.com/api/v1/wallet/" & name), headers: self.defaultHeaders(), body: "")

proc getCurrencies*(self: BitcoinLightning): tuple[metod: HttpMethod, url: Uri, headers: array[3, (string, string)], body: string] =
  ## Get a list of all FIAT currencies supported by Bitcoin Lightning, API returns an array of strings.
  result = (metod: HttpGet, url: parseUri("https://legend.lnbits.com/api/v1/currencies"), headers: self.defaultHeaders(), body: "")

proc sat2fiat*(self: BitcoinLightning; amount: Positive; fiatCurrency: string): tuple[metod: HttpMethod, url: Uri, headers: array[3, (string, string)], body: string] =
  ## Sats to FIAT currency conversion.
  var bodi = """{"from":"sat","to":""""
  bodi.add fiatCurrency
  bodi.add """","amount":"""
  bodi.addInt amount
  bodi.add '}'
  result = (metod: HttpPost, url: parseUri("https://legend.lnbits.com/api/v1/conversion"), headers: self.defaultHeaders(), body: "")

proc fiat2sat*(self: BitcoinLightning; amount: Positive; fiatCurrency: string): tuple[metod: HttpMethod, url: Uri, headers: array[3, (string, string)], body: string] =
  ## FIAT to Sats currency conversion.
  var bodi = """{"to":"sat","from":""""
  bodi.add fiatCurrency
  bodi.add """","amount":"""
  bodi.addInt amount
  bodi.add '}'
  result = (metod: HttpPost, url: parseUri("https://legend.lnbits.com/api/v1/conversion"), headers: self.defaultHeaders(), body: "")














