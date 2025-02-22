//
//  NetworkingManager.swift
//  CryptoApp
//
//  Created by Maulik Shah on 2/22/25.
//

import Foundation
import Combine

class NetworkingManager{
    enum NetworkingError : LocalizedError{
        case badUrlResponse(url: URL)
        case unknown
        
        var errorDescription: String? {
            switch self {
            case .badUrlResponse(let url):
                return "[🔥] Bad URL Response from url : \(url)"
            case .unknown:
                return "[⚠️]Unknown Error"
            }
        }
    }
    
    
    static func download(url: URL) -> AnyPublisher<Data, Error>{
      return  URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on:DispatchQueue.global(qos: .default))
            .tryMap({ try handleUrlResponse(output: $0,url: url) })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    static func handleUrlResponse(output: URLSession.DataTaskPublisher.Output,url : URL) throws -> Data{
        guard let response = output.response as? HTTPURLResponse,
              200..<300 ~= response.statusCode else {
            throw NetworkingError.badUrlResponse(url: url)
        }
        
        // Convert data to a JSON string and print it
//                if let jsonString = String(data: output.data, encoding: .utf8) {
//                    print("Raw JSON Response: \(jsonString)")
//                }
        
         return output.data
    }
    
    static func handleCompletion(completion: Subscribers.Completion<Error>){
        switch completion {
        case .finished:
            break
            
        case .failure(let error):
            print(error.localizedDescription)
            print("Decoding Error: \(error.localizedDescription)")
            if let decodingError = error as? DecodingError {
                //self.debugDecodingError(decodingError)
                
                print(decodingError)
            }
        }
    }
}
