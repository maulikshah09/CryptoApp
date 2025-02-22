//
//  UIApplication.swift
//  CryptoApp
//
//  Created by Maulik Shah on 2/22/25.
//

import Foundation
import SwiftUI

extension UIApplication{
    func endEditing(){
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
