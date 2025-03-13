//
//  PortfolioView.swift
//  CryptoApp
//
//  Created by Maulik Shah on 3/13/25.
//

import SwiftUI

struct PortfolioView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject private var vm : HomeViewModel
    
    @State private var selectedCoin : CoinModel? = nil
    @State private var quantityText : String = ""
    
    @State private var showCheckmark: Bool = false
    
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack(alignment: .leading, spacing: 0) {
                    SearchBarView(searchText: $vm.searchText)
                    coinLogoList
                    
                    if selectedCoin != nil{
                        portfolioInputViewSection
                    }
                }
            }
            .navigationTitle("Edit Potfolio")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    XMarkButton {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    saveButton
                }
            }
        }
    }
}

extension PortfolioView {
    private var coinLogoList: some View{
        ScrollView(.horizontal,showsIndicators: true) {
            LazyHStack(spacing: 10){
                ForEach(vm.allCoins) { coin in
                    CoinLogoView(coin: coin)
                        .frame(width: 75)
                        .padding(4)
                        .onTapGesture{
                            withAnimation {
                                selectedCoin  = coin
                            }
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(selectedCoin?.id == coin.id ? Color.txtGreen : .clear
                                    ,lineWidth: 1)
                        )
                }
            }
            .frame(height: 120)
            .padding(.leading)
        }
    }
    
    private var portfolioInputViewSection: some View{
        VStack(spacing: 20) {
            HStack{
                Text("Current price of \(selectedCoin?.symbol.uppercased() ?? "") : ")
                Spacer()
                Text(selectedCoin?.currentPrice.asCurrencyWith6Decimals() ?? "")
                
            }
            
            Divider()
            
            HStack{
                Text("Amount Holding:")
                Spacer()
                TextField("Ex: 1.4",text: $quantityText)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
            }
            
            Divider()
            
            HStack{
                Text("Current Value : ")
                Spacer()
                Text(getCurrentValue().asCurrencyWith2Decimals())
            }
            
        }
        .animation(.none)
        .padding(.horizontal)
        .font(.headline)
    }
    
    private var saveButton : some View{
        HStack(spacing: 10) {
            Image(systemName: "checkmark")
                .opacity(showCheckmark ? 1.0: 0.0)
            
            Button {
                saveButtonPressed()
            }label: {
                Text("Save".uppercased())
            }
            .opacity(
                (selectedCoin != nil && selectedCoin?.currentHoldings != Double (quantityText)) ? 1.0 : 0.0
                )
           
        }
        .font(.headline)
    }
    
    private func saveButtonPressed() {
        guard let coin = selectedCoin else { return}
        
        // save to portfolio
        
        // show checkmark
        
        withAnimation {
            showCheckmark = true
            removeSelectedCoin()
        }
        
        UIApplication.shared.endEditing()
        
        // hide checkmark
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            withAnimation {
                showCheckmark = false
            }
        }
    }

    private func removeSelectedCoin () {
        selectedCoin = nil
        vm.searchText = ""
    }
    
    private func getCurrentValue () -> Double{
        if let qty = Double(quantityText){
            return qty * (selectedCoin?.currentPrice ?? 0)
        }
        return 0
    }
}

 

#Preview {
    PortfolioView()
        .environmentObject(HomeViewModel() )
}
