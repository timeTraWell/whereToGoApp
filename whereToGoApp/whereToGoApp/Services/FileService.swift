//
//  SaveFileService.swift
//  whereToGoApp
//
//  Created by Nickolay Nickitin on 04/09/2019.
//  Copyright © 2019 Nickolay Nickitin. All rights reserved.
//

import Foundation

class FileService {
    
    //MARK:- Properties
    private let fileName = "cityInfo.json"
    
    //MARK:- Public methods
    public func saveToFile(city: City) -> Bool {
        guard let data = try? JSONSerialization.data(withJSONObject: city.json, options: JSONSerialization.WritingOptions.prettyPrinted) else {
            return false
        }
        
        let path = getDocumentsDirectory().appendingPathComponent(fileName)
        
        do {
            try data.write(to: path)
        } catch {
            return false
        }
        
        return true
    }
    
    public func loadFromFile() -> City? {
        let path = getDocumentsDirectory().appendingPathComponent(fileName)
        
        do {
            let fileContent = try String(contentsOf: path, encoding: .utf8)
            
            guard let data = fileContent.data(using: .utf8) else {
                return nil
            }
            
            guard let json = try JSONSerialization.jsonObject(with: data, options : .allowFragments) as? [String: Any] else {
                return nil
            }
            
            guard let city = City.parse(json: json) else {
                return nil
            }
            
            return city
        }
        catch {
            return nil
        }
    }
    
    //MARK:- Private helper
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
}
