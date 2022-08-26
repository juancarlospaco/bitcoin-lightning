# https://legend.lnbits.org/devs/swagger.html
from std/uri import parseUri, Uri
from std/httpcore import HttpMethod

type
  BitcoinLightning* = object  ## Bitcoin Lightning client object.
    apiKey*: string           ## API Key for the API.

  Fiat* {.pure.} = enum       ## FIAT currencies.
    AED = "AED", AFN = "AFN", ALL = "ALL", AMD = "AMD", ANG = "ANG", AOA = "AOA", ARS = "ARS", AUD = "AUD", AWG = "AWG", AZN = "AZN", BAM = "BAM", BBD = "BBD", BDT = "BDT", BGN = "BGN", BHD = "BHD", BIF = "BIF", BMD = "BMD", BND = "BND", BOB = "BOB", BRL = "BRL", BSD = "BSD", BTN = "BTN", BWP = "BWP", BYN = "BYN", BYR = "BYR", BZD = "BZD", CAD = "CAD", CDF = "CDF", CHF = "CHF", CLF = "CLF", CLP = "CLP", CNH = "CNH", CNY = "CNY", COP = "COP", CRC = "CRC", CUC = "CUC", CVE = "CVE", CZK = "CZK", DJF = "DJF", DKK = "DKK", DOP = "DOP", DZD = "DZD", EGP = "EGP", ERN = "ERN", ETB = "ETB", EUR = "EUR", FJD = "FJD", FKP = "FKP", GBP = "GBP", GEL = "GEL", GGP = "GGP", GHS = "GHS", GIP = "GIP", GMD = "GMD", GNF = "GNF", GTQ = "GTQ", GYD = "GYD", HKD = "HKD", HNL = "HNL", HRK = "HRK", HTG = "HTG", HUF = "HUF", IDR = "IDR", ILS = "ILS", IMP = "IMP", INR = "INR", IQD = "IQD", IRT = "IRT", ISK = "ISK", JEP = "JEP", JMD = "JMD", JOD = "JOD", JPY = "JPY", KES = "KES", KGS = "KGS", KHR = "KHR", KMF = "KMF", KRW = "KRW", KWD = "KWD", KYD = "KYD", KZT = "KZT", LAK = "LAK", LBP = "LBP", LKR = "LKR", LRD = "LRD", LSL = "LSL", LYD = "LYD", MAD = "MAD", MDL = "MDL", MGA = "MGA", MKD = "MKD", MMK = "MMK", MNT = "MNT", MOP = "MOP", MRO = "MRO", MUR = "MUR", MVR = "MVR", MWK = "MWK", MXN = "MXN", MYR = "MYR", MZN = "MZN", NAD = "NAD", NGN = "NGN", NIO = "NIO", NOK = "NOK", NPR = "NPR", NZD = "NZD", OMR = "OMR", PAB = "PAB", PEN = "PEN", PGK = "PGK", PHP = "PHP", PKR = "PKR", PLN = "PLN", PYG = "PYG", QAR = "QAR", RON = "RON", RSD = "RSD", RUB = "RUB", RWF = "RWF", SAR = "SAR", SBD = "SBD", SCR = "SCR", SEK = "SEK", SGD = "SGD", SHP = "SHP", SLL = "SLL", SOS = "SOS", SRD = "SRD", SSP = "SSP", STD = "STD", SVC = "SVC", SZL = "SZL", THB = "THB", TJS = "TJS", TMT = "TMT", TND = "TND", TOP = "TOP", TRY = "TRY", TTD = "TTD", TWD = "TWD", TZS = "TZS", UAH = "UAH", UGX = "UGX", USD = "USD", UYU = "UYU", UZS = "UZS", VEF = "VEF", VES = "VES", VND = "VND", VUV = "VUV", WST = "WST", XAF = "XAF", XAG = "XAG", XAU = "XAU", XCD = "XCD", XDR = "XDR", XOF = "XOF", XPD = "XPD", XPF = "XPF", XPT = "XPT", YER = "YER", ZAR = "ZAR", ZMW = "ZMW", ZWL = "ZWL"

template defaultHeaders*(self: BitcoinLightning): array[3, (string, string)] =
  ## Generate default HTTP Headers, the API uses only `"application/json"` and `"X-API-Key"` so size is fixed for performance.
  [("Content-Type", "application/json"), ("Accept", "application/json"), ("X-API-Key", self.apiKey)]

func newBitcoinLightning*(apiKey: string): BitcoinLightning =
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
  ## * To understand whats `bolt11` see https://www.bolt11.org
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

proc getCurrencies*(self: BitcoinLightning): tuple[metod: HttpMethod, url: Uri, headers: array[3, (string, string)], body: string] =
  ## Get a list of all FIAT currencies supported by Bitcoin Lightning, API returns an array of strings.
  result = (metod: HttpGet, url: parseUri("https://legend.lnbits.com/api/v1/currencies"), headers: self.defaultHeaders(), body: "")

proc satToFiat*(self: BitcoinLightning; amount: Positive; currency: Fiat): tuple[metod: HttpMethod, url: Uri, headers: array[3, (string, string)], body: string] =
  ## Sats to FIAT.
  var bodi = """{"from":"sat","to":""""
  bodi.add $currency
  bodi.add """","amount":"""
  bodi.addInt amount
  bodi.add '}'
  result = (metod: HttpPost, url: parseUri("https://legend.lnbits.com/api/v1/conversion"), headers: self.defaultHeaders(), body: "")

proc fiatToSat*(self: BitcoinLightning; amount: Positive; currency: Fiat): tuple[metod: HttpMethod, url: Uri, headers: array[3, (string, string)], body: string] =
  ## FIAT to Sats.
  var bodi = """{"to":"sat","from":""""
  bodi.add $currency
  bodi.add """","amount":"""
  bodi.addInt amount
  bodi.add '}'
  result = (metod: HttpPost, url: parseUri("https://legend.lnbits.com/api/v1/conversion"), headers: self.defaultHeaders(), body: "")
