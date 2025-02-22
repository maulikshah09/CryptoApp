//
//  SearchBarView.swift
//  CryptoApp
//
//  Created by Maulik Shah on 2/22/25.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String
    
    var body: some View {
      
        HStack{
            Image(systemName: "magnifyingglass")
                .foregroundStyle(
                    searchText.isEmpty ? .secondaryText:
                    .accent)
            TextField("Search by name or symbol...",text: $searchText)
                .foregroundStyle(.accent)
                .autocorrectionDisabled()
           
            if !searchText.isEmpty{
                Button {
                    UIApplication.shared.endEditing()
                    searchText = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(.accent)
                }
            }
        }
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.background)
                .shadow(color: .accent.opacity(0.15), radius: 10)
        )
        .padding()
    }
}

#Preview {
    SearchBarView(searchText: .constant(""))
}
