//
//  Model.swift
//  TalkSpace
//
//  Created by Teju Prasad on 7/25/20.
//  Copyright © 2020 Four Rooms. All rights reserved.
//

import Foundation
import UIKit

class Stroke: Codable {
    var points: [CGPoint]
    let colorData: Data
    let width: CGFloat
    
    init(points: [CGPoint], colorData: Data, width: CGFloat) {
        self.points = points
        self.width = width
        self.colorData = colorData
    }
}

class Drawing: Codable  {
    var strokes: [Stroke]
    var startTime: Date?
    var endTime: Date?
    var imageData: Data?
    
    init() {
        strokes = [Stroke]()
        startTime = nil
        endTime = nil
        imageData = nil
    }
}
