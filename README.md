# Miniwallet
This is a ruby console script based on:
- gem `bitcoin-ruby`
- `https://blockstream.info/testnet` API

## Installation
```sh
bundle
```
## Usage
### Key
Generates private key and saves it into file
```sh
ruby miniwallet.rb key
```
### Balance
Displays balance of address connected with private key
```sh
ruby miniwallet.rb balance
```
### Address
Prints address connected with private key
```sh
ruby miniwallet.rb address
```
### Send
Send amount of tBTC to specified address
```sh
ruby miniwallet.rb send tb1q0v47kzs36at4r43n7m0pukc6zmrftulelz32azlda76avycf6vwqj5wtm2 0.0004
```
## Run tests
There are no many of them :)
```sh
bundle exec rspec
```
