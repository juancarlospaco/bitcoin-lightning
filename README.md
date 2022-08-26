# Bitcoin Lightning client

- Open-source zero-fee no-download offline-capable anonymous instant micropayments platform with plugins.

![](https://camo.githubusercontent.com/073fa39391eedc7e9ecfaa28086d04c053f53b5f3661aecbb33a7a97cf2b7b5c/68747470733a2f2f692e696d6775722e636f6d2f4548764b364c712e706e67 "Add micropayments to any software with a one-liner")

![](https://raw.githubusercontent.com/juancarlospaco/bitcoin-lightning/nim/screenshot.png "Send, receive, withdraw and more")

![](https://raw.githubusercontent.com/juancarlospaco/bitcoin-lightning/nim/plugins.jpg "Tips, Donos, Paywalls, Bots, Tickets, Livestreams, Offline-Shop via plugins")

![](https://img.shields.io/github/languages/top/juancarlospaco/bitcoin-lightning?style=for-the-badge)
![](https://img.shields.io/github/stars/juancarlospaco/bitcoin-lightning?style=for-the-badge)
![](https://img.shields.io/github/languages/code-size/juancarlospaco/bitcoin-lightning?style=for-the-badge)
![](https://img.shields.io/github/issues-raw/juancarlospaco/bitcoin-lightning?style=for-the-badge "Bugs")
![](https://img.shields.io/github/issues-pr-raw/juancarlospaco/bitcoin-lightning?style=for-the-badge "PRs")
![](https://img.shields.io/github/last-commit/juancarlospaco/bitcoin-lightning?style=for-the-badge "Commits")


# Offline

- DIY cardboard offline Bitcoin ATMs, Arduino/RaspberryPi.

![](https://camo.githubusercontent.com/2103250a9d68b0afe02ddd6f455666355a3fda21fd90862645ec043efea92055/68747470733a2f2f692e696d6775722e636f6d2f476936626e334c2e6a7067 "DIY cardboard offline Bitcoin ATMs")

https://user-images.githubusercontent.com/1653275/136722218-10bc7a5a-7194-4a38-8a54-86825bab704e.mp4


# Shop

- Rural or mobile shops just need 1 QR, works even without internet (invoice via SMS) or electricity (QR or URL).

https://user-images.githubusercontent.com/1653275/166477530-63653087-dd5e-4843-ab64-79cfcb339fcf.mp4


# Example

```nim
import bitcoinlightning
let client: BitcoinLightning = newBitcoinLightning(apiKey = "YOUR_API_KEY_HERE")
echo client.getWallet()                        # Get your wallet.
echo client.getInvoice(amount = 666.Positive)  # Receive (Sell).
echo client.payInvoice("YOUR_INVOICE_HERE")    # Send (Pay).
```


# ELI5

- **Receive money** with 1 new Bitcoin Lightning incoming invoice, thats just 1 `string` (or Link, or QR).
- **Send money** with 1 new Bitcoin Lightning outgoing invoice, thats just 1 `string` (or Link, or QR).


# Design

- It does not use anything from Nim standard library, very future-proof.
- HTTPS JSON REST API, KISS. 1 file, <100 lines, zero dependencies, any target.
- Simple minimal API, all functions with 2 arguments max.

<details>
  <summary> Disclaimer </summary>
  Bitcoin Lightning is decentralized, so theres multiple services,
  but this way was the simplest and recommended approach as of 2022,
  if you just want to build something that can be monetized quickly.
  I investigated to use lntxbot but it has no HTTP API.
  I investigated to use Bitrefill but it has no HTTP API.
  I investigated to use Binance but it has no Lightning API.
  Anyway the idea of the Lightning network is that the API server does not really matter,
  because you can just send to any other Lightning wallet anywhere.
  In the future, if better services appear, then the library can be changed.
</details>


# See also

- https://github.com/juancarlospaco/binance#binance
- https://github.com/juancarlospaco/tradingview#tradingview
- https://github.com/juancarlospaco/cloudbet#cloudbet


# 💰➡️🍕

<details>
<summary title="Send Bitcoin"><kbd> Bitcoin BTC </kbd></summary>

**BEP20 Binance Smart Chain Network BSC**
```
0xb78c4cf63274bb22f83481986157d234105ac17e
```
**BTC Bitcoin Network**
```
1Pnf45MgGgY32X4KDNJbutnpx96E4FxqVi
```
**Lightning Network**
```
juancarlospaco@bitrefill.me
```
</details>

<details>
<summary title="Send Ethereum and DAI"><kbd> Ethereum ETH </kbd> <kbd> Dai DAI </kbd> <kbd> Uniswap UNI </kbd> <kbd> Axie Infinity AXS </kbd> <kbd> Smooth Love Potion SLP </kbd> <kbd> Uniswap UNI </kbd> <kbd> USDC </kbd> </summary>

**BEP20 Binance Smart Chain Network BSC**
```
0xb78c4cf63274bb22f83481986157d234105ac17e
```
**ERC20 Ethereum Network**
```
0xb78c4cf63274bb22f83481986157d234105ac17e
```
</details>
<details>
<summary title="Send Tether"><kbd> Tether USDT </kbd></summary>

**BEP20 Binance Smart Chain Network BSC**
```
0xb78c4cf63274bb22f83481986157d234105ac17e
```
**ERC20 Ethereum Network**
```
0xb78c4cf63274bb22f83481986157d234105ac17e
```
**TRC20 Tron Network**
```
TWGft53WgWvH2mnqR8ZUXq1GD8M4gZ4Yfu
```
</details>
<details>
<summary title="Send Solana"><kbd> Solana SOL </kbd></summary>

**BEP20 Binance Smart Chain Network BSC**
```
0xb78c4cf63274bb22f83481986157d234105ac17e
```
**SOL Solana Network**
```
FKaPSd8kTUpH7Q76d77toy1jjPGpZSxR4xbhQHyCMSGq
```
</details>
<details>
<summary title="Send Cardano"><kbd> Cardano ADA </kbd></summary>

**BEP20 Binance Smart Chain Network BSC**
```
0xb78c4cf63274bb22f83481986157d234105ac17e
```
**ADA Cardano Network**
```
DdzFFzCqrht9Y1r4Yx7ouqG9yJNWeXFt69xavLdaeXdu4cQi2yXgNWagzh52o9k9YRh3ussHnBnDrg7v7W2hSXWXfBhbo2ooUKRFMieM
```
</details>
<details>
<summary title="Send Sandbox"><kbd> Sandbox SAND </kbd> <kbd> Decentraland MANA </kbd></summary>

**ERC20 Ethereum Network**
```
0xb78c4cf63274bb22f83481986157d234105ac17e
```
</details>
<details>
<summary title="Send Algorand"><kbd> Algorand ALGO </kbd></summary>

**ALGO Algorand Network**
```
WM54DHVZQIQDVTHMPOH6FEZ4U2AU3OBPGAFTHSCYWMFE7ETKCUUOYAW24Q
```
</details>
<details>
<summary title="Send Polkadot"><kbd> Polkadot DOT </kbd></summary>

**DOT Network**
```
13GdxHQbQA1K6i7Ctf781nQkhQhoVhGgUnrjn9EvcJnYWCEd
```
**BEP20 Binance Smart Chain Network BSC**
```
0xb78c4cf63274bb22f83481986157d234105ac17e
```
</details>
<details>
<summary title="Send via Binance Pay"> Binance </summary>

[https://pay.binance.com/en/checkout/e92e536210fd4f62b426ea7ee65b49c3](https://pay.binance.com/en/checkout/e92e536210fd4f62b426ea7ee65b49c3 "Send via Binance Pay")
</details>


# Stars

![](https://starchart.cc/juancarlospaco/bitcoin-lightning.svg)
:star: [@luisacosta828](https://github.com/luisacosta828 '2022-08-26')	
:star: [@juancarlospaco](https://github.com/juancarlospaco '2022-08-26')	
