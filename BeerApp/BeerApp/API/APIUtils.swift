//
//  APIUtils.swift
//  BeerApp
//
//  Created by Dillon Massey on 18/08/2022.
//

import Foundation

class APIUtils {
    private static let timeoutInterval: TimeInterval = 5
    
    static func get(url: URL?, completion: @escaping (Data?) -> ()) {
        guard let url = url else {
            completion(nil)
            return
        }
        
        // URLRequest defaults to GET httpMethod
        let request = URLRequest(url: url, timeoutInterval: timeoutInterval)
        
        // Perform GET request on URL
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print(error!.localizedDescription)
                completion(nil)
                return
            }
            
            // Check success HTTP status code
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Response code failure")
                completion(nil)
                return
            }
            
            guard let data = data else
            {
                print("No data returned")
                completion(nil)
                return
            }

            completion(data)
        }.resume()
    }
}
