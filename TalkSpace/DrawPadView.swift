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
    var drawing: Drawing?
    var strokeColor: UIColor? = .black
    var lineWidth: CGFloat? = 5
    var markStartTimeIfNeeded: (()->())?
    
    // Internal State Variables
    
    var lastPointTouched: CGPoint = CGPoint(x: 0, y: 0)
    var tempImageView: UIImageView
    
    override init(frame: CGRect) {
        let imageFrame = CGRect(origin: .zero, size: frame.size)
        self.tempImageView = UIImageView(frame: imageFrame)
        super.init(frame: frame)
        self.addSubview(tempImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let lastPointTouched = touches.first?.location(in: self) else { return }
        guard let strokeColor = strokeColor else { return }
        guard let lineWidth = lineWidth else { return }
        self.lastPointTouched = lastPointTouched
        
        // Generate new stroke variable
        
        if let colorData = strokeColor.dataRepresentation() {
            let stroke = Stroke(points: [CGPoint](), colorData: colorData, width: lineWidth)
            stroke.points.append(lastPointTouched)
            drawing?.strokes.append(stroke)
            markStartTimeIfNeeded?()
        } else {
            print("Error getting data representation for stroke color")
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let currentPoint = touches.first?.location(in: self) else { return }
        guard let strokeColor = strokeColor else { return }
        guard let lineWidth = lineWidth else { return }
        
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
            tempImageView.image = UIImage(cgImage: cgImage)
        }
        
        lastPointTouched = currentPoint
        
        guard let lastStroke = drawing?.strokes.popLast() else { return }
        lastStroke.points.append(lastPointTouched)
        drawing?.strokes.append(lastStroke)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
       
    }

}
