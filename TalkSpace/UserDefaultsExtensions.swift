//
//  UserDefaultsExtensions.swift
//  TalkSpace
//
//  Created by Teju Prasad on 7/27/20.
//  Copyright © 2020 Four Rooms. All rights reserved.
//

import Foundation

extension UserDefaults {
    struct Keys {
        static let savedDrawings = "savedDrawings"
    }
    
    func addToSavedDrawings(drawing: Drawing) {
        do {
            let drawingData = try JSONEncoder().encode(drawing)
            if var savedDrawings = UserDefaults.standard.array(forKey: UserDefaults.Keys.savedDrawings) as? [Data] {
                savedDrawings.append(drawingData)
                UserDefaults.standard.set(savedDrawings, forKey: UserDefaults.Keys.savedDrawings)
            } else {
                var savedDrawings = [Data]()
                savedDrawings.append(drawingData)
                UserDefaults.standard.set(savedDrawings, forKey: UserDefaults.Keys.savedDrawings)
            }
            
        } catch let error {
            print("Error encoding drawing \(error.localizedDescription)")
        }
    }
    
    func fetchSavedDecodedDrawings() -> [Drawing] {
        var decodedDrawings = [Drawing]()
        
        do {
            if let savedDrawings = UserDefaults.standard.array(forKey: UserDefaults.Keys.savedDrawings) as? [Data] {
                for savedDrawing in savedDrawings {
                    let decodedDrawing = try JSONDecoder().decode(Drawing.self, from: savedDrawing)
                    decodedDrawings.append(decodedDrawing)
                }
                return decodedDrawings
            }
        } catch let error {
            print("decoding error is \(error.localizedDescription)")
        }

        return []
    }
    
    func deleteDrawing(index: Int) {
        if var savedDrawings = UserDefaults.standard.array(forKey: UserDefaults.Keys.savedDrawings) as? [Data] {
            savedDrawings.remove(at: index)
            UserDefaults.standard.set(savedDrawings, forKey: UserDefaults.Keys.savedDrawings)
        }
    }
}
