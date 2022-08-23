//
//  BeerDataStorageManager.swift
//  BeerApp
//
//  Created by Dillon Massey on 18/08/2022.
//

import Foundation

// Struct for decoding the JSON output from the Brewdog API
struct Beer: Codable {
    let id: Int
    let name: String?
    let tagline: String?
    let description: String?
    let image_url: String?
    let abv: Double?
    let food_pairing: [String?]
}

protocol BeerStorageManaging: DiskStorageManaging {
    func retrieveLatestBeerData(completion: @escaping ([Beer]) -> ())
}

class BeerStorageManager: BeerStorageManaging {
    var fileName: String = "beerStorageManager"
    
    static let shared = BeerStorageManager()
    private let endpoint = "https://api.punkapi.com/v2/beers"
    
    /**
     Attempts to GET the latest beer dat from the endpoint above and stores onto disk.
     The GET request can fail and the attempts to use the data already stored on disk from a previous load.
     
     - Parameter completion: Returns an Array of type [Beer] from the load call.
     */
    func retrieveLatestBeerData(completion: @escaping ([Beer]) -> ()) {
        // Call the API and store the latest data available
        retrieveAndStoreLatestServerData {
            // Decode to the Beer struct
            guard let data = self.load(),
                  let decodedData = try? JSONDecoder().decode([Beer].self, from: data) else
            {
                completion([])
                return
            }
            
            completion(decodedData)
            return
        }
    }
    
    /**
     Private function for 'retrieveLatestBeerData' to call.
     Calls the class endpoint and returns any data gathered.
     
     - Parameter completion: Void return so the caller of this function knows when the call has finished.
     */
    private func retrieveAndStoreLatestServerData(completion: @escaping () -> ()) {
        guard let url = URL(string: endpoint) else {
            completion()
            return
        }
        
        APIUtils.get(url: url) { data in
            // Nil check the response to make sure we don't overwrite whats on disk with nothing
            guard let data = data,
                  data.count > 0 else
            {
                print("Request failed, can't store data")
                completion()
                return
            }
            
            // Store data on disk
            // Potential for optimisation by loading whats stored, doing a compare and returning the load. Stops us doing unnecessary saves
            self.store(data: data)
            completion()
        }
    }
}
