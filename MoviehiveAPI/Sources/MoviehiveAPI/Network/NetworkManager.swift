//
//  File.swift
//  
//
//  Created by Zeynep Gizem Gürsoy on 24.04.2022.
//

import Foundation
import Alamofire

public protocol NetworkManagerProtocol {
    func fetchData<T: Decodable>(
        request: URLRequestConvertible,
        expecting: T.Type,
        completion: @escaping (Result<T, Error>) -> Void)
}

public final class NetworkManager: NetworkManagerProtocol {
    
    public static let shared: NetworkManager = {
        let instance = NetworkManager()
        return instance
    }()
    
    public let reachabilityManager = NetworkReachabilityManager()?.isReachable
    
    public func isConnectedToInternet() -> Bool {
        return reachabilityManager ?? false
    }
    
    public func fetchData<T: Decodable>(request: URLRequestConvertible, expecting: T.Type, completion: @escaping  (Result<T, Error>) -> Void) {
        
        AF.request(request).responseData { response in
            
            switch response.result {
                
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(expecting, from: data)
                    completion(.success(response))
                } catch {
                    print("********** JSON DECODE ERROR *********")
                }
                
            case .failure(let error):
                print("****** GEÇİCİ BİR SORUN OLUŞTU: \(error.localizedDescription) ******")
                
            }
        }
    }
}
