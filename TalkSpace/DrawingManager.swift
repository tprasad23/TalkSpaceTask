//
//  DrawingManager.swift
//  TalkSpace
//
//  Created by Teju Prasad on 7/25/20.
//  Copyright © 2020 Four Rooms. All rights reserved.
//

import Foundation


class DrawingManager {
    static let shared = DrawingManager()
    
    var drawings: [Drawing] = []
    var hasDrawings: Bool {
        return drawings.count > 0
    }
    
    func saveDrawing() {
        
    }
    
    
    
}
