//
//  DrawingCellViewModel.swift
//  TalkSpace
//
//  Created by Teju Prasad on 7/25/20.
//  Copyright © 2020 Four Rooms. All rights reserved.
//

import Foundation
import UIKit

class DrawingCellViewModel {
    
    var drawing: Drawing
    
    init(drawing: Drawing) {
        self.drawing = drawing
    }
    
    func startTimeText() -> String {
        guard let startTime = drawing.startTime else { return "" }
        return startTime.startDateAndTimeString()
    }
    
    func drawingTimeText() -> String {
        guard let startTime = drawing.startTime else { return "" }
        guard let endTime = drawing.endTime else { return "" }
        
        var secondsString = ""
        var minutesString = ""
        
        if let (minutes, seconds) = endTime.timeFromEarlierDate(lhs: startTime) {
            secondsString = (seconds > 1) ? "\(seconds) seconds" : "1 second"
            
            if minutes > 0 {
                minutesString = (minutes > 1) ? "\(minutes) minutes" : "1 minute"
                return "\(minutesString), \(secondsString)"
            }
            
            return secondsString
        }
        return ""
    }
    
    func thumbnailImage() -> UIImage? {
        guard let imageData = drawing.imageData else { return nil }
        
        let image = UIImage(data: imageData)
        return image
    }

}
