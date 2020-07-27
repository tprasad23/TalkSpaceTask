//
//  DrawingViewModel.swift
//  TalkSpace
//
//  Created by Teju Prasad on 7/25/20.
//  Copyright © 2020 Four Rooms. All rights reserved.
//

import Foundation

class DrawingViewModel {
    
    // Model Object
    var drawing: Drawing?
    
    // State variables
    var drawingMode: DrawingMode? = .pencil
    var presentationMode: PresentationMode?
    
    func togglePencilEraser(toPencil: Bool = false, completion: (DrawingMode)->Void) {
        if toPencil || drawingMode == .eraser {
            drawingMode = .pencil
        } else {
            drawingMode = .eraser
        }
        completion(drawingMode!)
    }
    
    // Only save drawing if the drawing has begun (i.e. a start time was set)
    func saveDrawing() {
        if let drawing = drawing, let _ = drawing.startTime {
            markEndTime()
            
            
            
            // Save Image to UserDefaults
            print("***Saving Drawing to UserDefaults*** ")
            UserDefaults.standard.addToSavedDrawings(drawing: drawing)
            print("Stroke Count is \(drawing.strokes.count)")
        }
    }
    
    func markStartTimeIfNeeded() {
        if let _ = drawing {
            // force unwrap because we know it's not nil.
            if drawing!.startTime == nil {
                drawing!.startTime = Date()
            }
        }
    }
    
    func markEndTime() {
        if let _ = drawing {
            drawing!.endTime = Date()
        }
    }
}
