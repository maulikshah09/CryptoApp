//
//  Double.swift
//  CryptoApp
//
//  Created by Maulik Shah on 2/21/25.
//

import Foundation

extension Double{
    
    /// Convert a Double into a currency with 2 decimal Places
    /// ```
    /// Convert 1234.56 to $1,234.56
    ///
    /// ```
    private var currencyFormatter2 : NumberFormatter{
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
//        formatter.locale = .current
//        formatter.currencyCode = "usd"
//        formatter.currencySymbol = "$"
        
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    /// Convert a Double into a currency as a string with 2-6 decimal places
    /// ```
    /// Convert 1234.56 to "$1,234.56"
    ///
    /// ```
    func asCurrencyWith2Decimals() -> String{
        let number = NSNumber(value: self)
        return currencyFormatter2.string(from: number) ?? "$0.00"
    }
    
    /// Convert a Double into a currency with 2-6 Places
    /// ```
    /// Convert 1234.56 to $1,234.56
    /// Convert 12.3456 to $12.3456
    /// Convert 0.123456 to $0.123456
    ///
    /// ```
    private var currencyFormatter : NumberFormatter{
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
//        formatter.locale = .current
//        formatter.currencyCode = "usd"
//        formatter.currencySymbol = "$"
        
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 6
        return formatter
    }
    
    /// Convert a Double into a currency as a string with 2-6 decimal places
    /// ```
    /// Convert 1234.56 to "$1,234.56"
    /// Convert 12.3456 to "$12.3456"
    /// Convert 0.123456 to "$0.123456"
    ///
    /// ```
    func asCurrencyWith6Decimals() -> String{
        let number = NSNumber(value: self)
        return currencyFormatter.string(from: number) ?? "$0.00"
    }
    
    /// Convert a Double into a string representation
    /// ```
    /// Convert 1.2345 to "1.23"
    ///
    /// ```
    func asNumberString() -> String{
        return String(format: "%.2f",self)
    }
    
    /// Convert a Double into a string representation with percent Symobol
    /// ```
    /// Convert 1.2345 to "1.23%"
    ///
    /// ```
    func asPresentString() -> String{
        asNumberString() + "%"
    }
}
