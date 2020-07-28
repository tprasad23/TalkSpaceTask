//
//  DrawPadView.swift
//  TalkSpace
//
//  Created by Teju Prasad on 7/26/20.
//  Copyright © 2020 Four Rooms. All rights reserved.
//

import Foundation
import UIKit

class DrawPadView: UIView {
    
    // Injected variables
    
    var drawing: Drawing
    var strokeColor: UIColor = .black
    var lineWidth: CGFloat = 5
    var markStartTimeIfNeeded: (()->())?
    var presentationMode: PresentationMode
    
    // Internal State Variables
    
    var lastPointTouched: CGPoint = CGPoint(x: 0, y: 0)
    var tempImageView: UIImageView
    
    init(frame: CGRect, drawing: Drawing, presentationMode: PresentationMode,  markStartTimeIfNeeded: (()->())?) {
        self.tempImageView = UIImageView(frame: frame)
        self.drawing = drawing
        self.presentationMode = presentationMode
        self.markStartTimeIfNeeded = markStartTimeIfNeeded
        
        super.init(frame: frame)
        self.backgroundColor = .white
        self.addSubview(tempImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: Touch methods (for drawing mode)
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if presentationMode == .drawing {
            createNewStroke(touches)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if presentationMode == .drawing {
            guard let currentPoint = touches.first?.location(in: self) else { return }
            drawLineToPoint(currentPoint: currentPoint)
            storeLastPointToLastStroke()
        }
    }
    
    // MARK: Playing Mode methods
    func playImage() {
        if presentationMode == .playback, drawing.strokes.count > 0 {
            for stroke in drawing.strokes {
                lastPointTouched = stroke.points[0]
                strokeColor = stroke.colorData.colorRepresentation() ?? .black
                lineWidth = stroke.width
                
                for (i, point) in stroke.points.enumerated() {
                    if i > 0 {
                        self.drawLineToPoint(currentPoint: point)
                    }
                }
            }
        }
    }
    
    // Drawing Methods
    
    func drawLineToPoint(currentPoint: CGPoint) {
        let imageFrame = CGRect(origin: .zero, size: self.frame.size)
       
        // Draw out the line
        UIGraphicsBeginImageContext(imageFrame.size)
        let context = UIGraphicsGetCurrentContext()
       
        context?.setLineCap(.round)
        context?.setStrokeColor(strokeColor.cgColor)
        context?.setLineWidth(lineWidth)
       
        tempImageView.image?.draw(in: imageFrame)
        context?.move(to: lastPointTouched)
        context?.addLine(to: currentPoint)
        context?.setBlendMode(.normal)
        context?.strokePath()
       
        if let cgImage = context?.makeImage() {
            self.tempImageView.image = UIImage(cgImage: cgImage)
        }
       
        lastPointTouched = currentPoint
    }
    
    // MARK: Stroke Capturing Methods
    func createNewStroke(_ touches: Set<UITouch>) {
        guard let lastPointTouched = touches.first?.location(in: self) else { return }
        
        // Generate new stroke variable
        
        self.lastPointTouched = lastPointTouched
        if let colorData = strokeColor.dataRepresentation() {
            let stroke = Stroke(points: [CGPoint](), colorData: colorData, width: lineWidth)
            stroke.points.append(lastPointTouched)
            drawing.strokes.append(stroke)
            markStartTimeIfNeeded?()
        } else {
            print("Error getting data representation for stroke color")
        }
    }
    
    // This function assumes at least one stroke variable exists
    // Save the point in the "lastPountTouched" variable to the
    // last stroke in the array.
    func storeLastPointToLastStroke() {
        if let lastStroke = drawing.strokes.popLast() {
            lastStroke.points.append(lastPointTouched)
            drawing.strokes.append(lastStroke)
        } else {
            print("Need at least one stroke variable created")
        }
    }
}
