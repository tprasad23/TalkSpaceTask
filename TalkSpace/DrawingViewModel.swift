//
//  DrawingViewModel.swift
//  TalkSpace
//
//  Created by Teju Prasad on 7/25/20.
//  Copyright © 2020 Four Rooms. All rights reserved.
//

import Foundation
import UIKit

class DrawingViewModel {
    
    // Model Object
    var drawing: Drawing
    
    // State variables
    var drawingMode: DrawingMode? = .pencil
    var presentationMode: PresentationMode
    
    init(drawing: Drawing, drawingMode: DrawingMode? = .pencil, presentationMode: PresentationMode) {
        self.drawing = drawing
        self.drawingMode = drawingMode
        self.presentationMode = presentationMode
    }
    
    func togglePencilEraser(toPencil: Bool = false, completion: (DrawingMode)->Void) {
        if toPencil || drawingMode == .eraser {
            drawingMode = .pencil
        } else {
            drawingMode = .eraser
        }
        completion(drawingMode!)
    }
    
    // Only save drawing if the drawing has begun (i.e. a start time was set)
    func saveDrawing(image: UIImage?) {
        if let _ = drawing.startTime, let image = image {
            markEndTime()
            collectImageData(image: image)
            
            // Save Drawing to UserDefaults
            print("***Saving Drawing to UserDefaults*** ")
            UserDefaults.standard.addToSavedDrawings(drawing: drawing)
            print("Stroke Count is \(drawing.strokes.count)")
        }
    }
    
    func markStartTimeIfNeeded() {
        if drawing.startTime == nil {
            drawing.startTime = Date()
        }
    }
    
    func markEndTime() {
        drawing.endTime = Date()
    }
    
    func collectImageData(image: UIImage) {
        drawing.imageData = image.jpegData(compressionQuality: 0.8)
    }
}
