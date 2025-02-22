//
//  CoinImageView.swift
//  CryptoApp
//
//  Created by Maulik Shah on 2/22/25.
//

import SwiftUI
import Combine

struct CoinImageView: View {
    let documentManager = LocalFileManager(directoryType: .cachesDirectory)

    var url : URL
    var coinId : String
    
    
    var body: some View {
        if let image = loadSavedImage() {
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
                .frame(width: 30,height: 30)
        } else {
            loadAsyncImage()
        }
    }
    
    /// Load image from local storage
    private func loadSavedImage() -> UIImage? {
        guard let imageData = documentManager.loadFile(fileName: coinId) else {
            return nil }
        return UIImage(data: imageData)
    }
    
    private func loadAsyncImage() -> some View {
        AsyncImage(url: url) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .onAppear {
                        if let uiImage = image.getUIImage() {
                            saveImage(uiImage)
                        }else{
                            print("error")
                        }
                    }
            case .failure:
                errorView()
            case .empty:
                ProgressView()
            default:
                errorView()
            }
        }
    }
    
    /// Save UIImage to file manager
    private func saveImage(_ uiImage: UIImage) {
        guard let imageData = uiImage.pngData() else { return }
        documentManager.saveFile(data: imageData, fileName: coinId)
    }
    
    func errorView() -> some View{
        Image(systemName: "exclamationmark.triangle.fill") // Exclamation icon
            .resizable()
            .scaledToFit()
            .frame(width: 30, height: 30)
            .foregroundColor(.red)
    }
}

//#Preview {
//    CoinImageView(coin: dev.coin)
//}
//
//

extension Image {
    @MainActor
    func getUIImage() -> UIImage? {
        return ImageRenderer(content: self).uiImage
    }
}
