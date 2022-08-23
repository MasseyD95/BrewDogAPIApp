//
//  DiskStorageManager.swift
//  BeerApp
//
//  Created by Dillon Massey on 18/08/2022.
//

import Foundation

protocol DiskStorageManaging {
    var fileName: String { get }
}

extension DiskStorageManaging {
    // Directory for storing is inside the users document directory
    func defaultDirectory() -> URL? {
        try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    }
    
    /**
     Stores the supplied data on disk at the directory defined on the class.
     Data is stored encoded to utf8 with no encryption.
     
     - Returns: Whether the store was successful
     */
    @discardableResult func store(data: Data) -> Bool {
        guard let directory = defaultDirectory() else {
            return false
        }
        let url = directory.appendingPathComponent(fileName).appendingPathExtension("txt")
        
        func saveToFile() -> Bool {
            var error: NSError?
            var success = false
            
            // This block is synchronous
            NSFileCoordinator().coordinate(writingItemAt: url, error: &error) { url in
                do {
                    try data.write(to: url)
                    success = true
                } catch {
                    print(error.localizedDescription)
                }
            }
            
            guard success,
                  error == nil else
            {
                return false
            }
            return true
        }
        
        if FileManager.default.fileExists(atPath: url.path) {
            return saveToFile()
        } else {
            if FileManager.default.createFile(atPath: url.path, contents: nil, attributes: nil) {
                return saveToFile()
            }
            return false
        }
    }
    
    /**
     Loads the latest data stored on disk for that storage manager
     
     - Returns: Type Data which was stored at the file destination, nil if load failed or empty Data object if nothing to load.
     */
    func load() -> Data? {
        guard let directory = defaultDirectory() else {
            return nil
        }
        
        let url = directory.appendingPathComponent(fileName).appendingPathExtension("txt")
        var error: NSError?
        var success = false
        var data: Data?
        
        // This block is synchronous
        NSFileCoordinator().coordinate(readingItemAt: url, error: &error) { url in
            do {
                // Throws if url cannot be read
                data = try Data(contentsOf: url)
                success = true
            } catch {
                print(error.localizedDescription)
            }
        }
        
        guard success,
              error == nil else
        {
            return nil
        }
        return data
    }
}

class DiskStorageManager: DiskStorageManaging {
    var fileName: String = "diskStorage"
    
    static let shared = DiskStorageManager()
}
