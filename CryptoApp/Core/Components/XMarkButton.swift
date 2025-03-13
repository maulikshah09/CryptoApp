//
//  XMarkButton.swift
//  CryptoApp
//
//  Created by Maulik Shah on 3/13/25.
//

import SwiftUI

struct XMarkButton: View {
    let action: () -> Void
    
    var body: some View {
        Button{
            action()
        } label: {
            Image(systemName: "xmark")
                .font(.headline)
        }
    }
}

#Preview {
    XMarkButton{
        
    }
}
