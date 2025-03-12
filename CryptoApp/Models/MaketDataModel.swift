//
//  MaketDataModel.swift
//  CryptoApp
//
//  Created by Maulik Shah on 3/12/25.
//

import Foundation

struct GlobalDataModel : Codable {
    let data: MarketDataModel?
}

struct MarketDataModel : Codable {
    let totalMarketCap, totalVolume, marketCapPercentage: [String: Double]
    let marketCapChangePercentage24HUsd: Double
    
    enum CodingKeys : String, CodingKey {
        case totalMarketCap = "total_market_cap"
        case totalVolume = "total_volume"
        case marketCapPercentage = "market_cap_percentage"
        case marketCapChangePercentage24HUsd = "market_cap_change_percentage_24h_usd"
    }
    
    var marketCap : String{
        if let item = totalMarketCap.first(where: { $0.key == "usd" }){
            return "$" + item.value.formattedWithAbbreviations()
        }
           
        return ""
    }
    
    var volume : String{
        if let item = totalVolume.first(where: { $0.key == "usd" }){
            return "$" + item.value.formattedWithAbbreviations()
        }
           
        return ""
    }
    
    var btnDominance : String{
        if let item = marketCapPercentage.first(where: { $0.key == "btc" }){
            return "\(item.value.asPresentString())"
        }
           
        return ""
    }
}

// Json Data :
/*
 // https://api.coingecko.com/api/v3/global
 
 
 {
   "data": {
     "active_cryptocurrencies": 17169,
     "upcoming_icos": 0,
     "ongoing_icos": 49,
     "ended_icos": 3376,
     "markets": 1282,
     "total_market_cap": {
       "btc": 33595636.888722,
       "eth": 1453385060.54716,
       "ltc": 30702639268.3357,
       "bch": 8291856520.46917,
       "bnb": 4957216726.77237,
       "eos": 5648900076469.42,
       "xrp": 1267009251282.98,
       "xlm": 10892862416704.6,
       "link": 208725297441.866,
       "dot": 694589353769.211,
       "yfi": 551740246.848144,
       "usd": 2773412684463.61,
       "aed": 10186037569800.3,
       "ars": 2.95541789188153e+15,
       "aud": 4407402048467.56,
       "bdt": 336917947523302,
       "bhd": 1045485059424.19,
       "bmd": 2773412684463.61,
       "brl": 16112973014196.7,
       "cad": 3997533254894.1,
       "chf": 2447439624595.18,
       "clp": 2594943578218374,
       "cny": 20088937438643.7,
       "czk": 63540030020499.9,
       "dkk": 18964213205411.7,
       "eur": 2542429009038.06,
       "gbp": 2142674851524.84,
       "gel": 7696220199386.51,
       "hkd": 21547059157500.4,
       "huf": 1.01829495411809e+15,
       "idr": 45718282763401620,
       "ils": 10096428605965.3,
       "inr": 241903250142853,
       "jpy": 412378732052894,
       "krw": 4027145334349529,
       "kwd": 854566103638.402,
       "lkr": 819268389509189,
       "mmk": 5818619812004646,
       "mxn": 56121617022890.8,
       "myr": 12287604898516,
       "ngn": 4.26179233570785e+15,
       "nok": 29584262126203.7,
       "nzd": 4853416729557.62,
       "php": 158872180537051,
       "pkr": 776162625634326,
       "pln": 10666919595159.4,
       "rub": 240319553844469,
       "sar": 10401967161174.6,
       "sek": 27951063184814.8,
       "sgd": 3697153247277.9,
       "thb": 93880019369093.1,
       "try": 101501074537905,
       "twd": 91422775730658.3,
       "uah": 114948526167889,
       "vef": 277701812095.341,
       "vnd": 70615246549615350,
       "zar": 50810872861903.1,
       "xdr": 2083714871265.83,
       "xag": 83906771887.5083,
       "xau": 951308284.897862,
       "bits": 33595636888722,
       "sats": 3359563688872196
     },
     "total_volume": {
       "btc": 1706355.31645748,
       "eth": 73818851.3329557,
       "ltc": 1559417132.5976,
       "bch": 421151517.498243,
       "bnb": 251781894.910276,
       "eos": 286913169991.324,
       "xrp": 64352641359.0125,
       "xlm": 553259155578.724,
       "link": 10601362377.7634,
       "dot": 35278873875.3376,
       "yfi": 28023427.7632922,
       "usd": 140864347788.381,
       "aed": 517358829018.038,
       "ars": 150108570611994,
       "aud": 223856268660.079,
       "bdt": 17112392685709.9,
       "bhd": 53101210592.7427,
       "bmd": 140864347788.381,
       "brl": 818393687780.937,
       "cad": 203038631022.173,
       "chf": 124307856671.074,
       "clp": 131799727008199,
       "cny": 1020336816770.36,
       "czk": 3227260384807.45,
       "dkk": 963210970896.955,
       "eur": 129132460582.826,
       "gbp": 108828555221.304,
       "gel": 390898565112.757,
       "hkd": 1094396247620.1,
       "huf": 51720198501863.6,
       "idr": 2322076378877203,
       "ils": 512807501940.995,
       "inr": 12286503105055.6,
       "jpy": 20945119872654.4,
       "krw": 204542657553282,
       "kwd": 43404249755.3383,
       "lkr": 41611444268046,
       "mmk": 295533401660024,
       "mxn": 2850471919683.96,
       "myr": 624099492876.423,
       "ngn": 216460608672494,
       "nok": 1502613661700.4,
       "nzd": 246509791342.711,
       "php": 8069273721302.67,
       "pkr": 39422060283409.4,
       "pln": 541783298281.065,
       "rub": 12206065618266.7,
       "sar": 528326104543.798,
       "sek": 1419661887167.82,
       "sgd": 187782036106.257,
       "thb": 4768258172636.7,
       "try": 5155339032195.7,
       "twd": 4643452360496.2,
       "uah": 5838348277045.92,
       "vef": 14104747144.0506,
       "vnd": 3.5866175650131e+15,
       "zar": 2580734019983.99,
       "xdr": 105833920051.671,
       "xag": 4261707160.70273,
       "xau": 48317879.9348926,
       "bits": 1706355316457.48,
       "sats": 170635531645748
     },
     "market_cap_percentage": {
       "btc": 59.0428107773713,
       "eth": 8.29400045227682,
       "usdt": 5.16452589464436,
       "xrp": 4.58068320269667,
       "bnb": 2.94037105791386,
       "sol": 2.30005345273844,
       "usdc": 2.09926779928346,
       "ada": 0.956157893325121,
       "doge": 0.895160429858819,
       "trx": 0.757978392963383
     },
     "market_cap_change_percentage_24h_usd": -0.989933765726406,
     "updated_at": 1741778087
   }
 }
 
 */
