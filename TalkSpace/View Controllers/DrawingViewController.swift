//
//  DrawingViewController.swift
//  TalkSpace
//
//  Created by Teju Prasad on 7/23/20.
//  Copyright © 2020 Four Rooms. All rights reserved.
//

import UIKit

enum DrawingMode {
    case pencil
    case eraser
}

enum PresentationMode {
    case playback
    case drawing
}

class DrawingViewController: UIViewController {
    
    // Outlets
    
    @IBOutlet weak var pencilButton: UIButton!
    @IBOutlet weak var eraserButton: UIButton!
    @IBOutlet weak var padContainerView: UIView!
    var drawPadView: DrawPadView?
    
    // Dependency Injected Variables
    var viewModel: DrawingViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Drawing"
        toggleUI(viewModel?.drawingMode)
        
        
        let imageFrame = CGRect(x: 0, y: 0, width: padContainerView.frame.width, height: padContainerView.frame.height)
        drawPadView = DrawPadView(frame: imageFrame)
        drawPadView?.markStartTimeIfNeeded = {
            guard let viewModel = self.viewModel else { return }
            viewModel.markStartTimeIfNeeded()
        }
        
        drawPadView?.backgroundColor = .white
        drawPadView?.drawing = viewModel?.drawing
        padContainerView.addSubview(drawPadView!)
    }
    
    override func viewWillDisappear(_ animated: Bool)  {
        super.viewWillDisappear(animated)
        guard let viewModel = viewModel else { return }
        guard let drawPadView = drawPadView else { return }
        viewModel.saveDrawing(image: drawPadView.tempImageView.image)
    }
    
    // MARK: Button Actions
    
    @IBAction func eraserButtonAction(_ sender: Any) {
       handleToggle()
    }
    @IBAction func pencilButtonAction(_ sender: Any) {
       handleToggle()
    }
    
    @IBAction func settingsButtonAction(_ sender: Any) {
        let settingsVC = SettingsViewController()
        settingsVC.colorChosen = { color in
            self.drawPadView?.strokeColor = color
        }
        settingsVC.lineWidthChosen = { lineWidth in
            self.drawPadView?.lineWidth = CGFloat(lineWidth)
        }
        present(settingsVC, animated: true, completion: nil)
    }
    
    // MARK: Toggle support
    
    func handleToggle() {
        guard let viewModel = viewModel else { return }
        viewModel.togglePencilEraser { drawingMode in
            toggleUI(drawingMode)
        }
    }
    
    func toggleUI(_ drawingMode: DrawingMode?) {
        // Default to showing pencil if no mode set.
        let drawingMode = drawingMode ?? .pencil
        if drawingMode == .pencil {
            drawPadView?.strokeColor = .black
            pencilButton.layer.borderColor = UIColor.red.cgColor
            pencilButton.layer.borderWidth = 1.0
            
            eraserButton.layer.borderColor = UIColor.clear.cgColor
            eraserButton.layer.borderWidth = 0.0
        } else {
            drawPadView?.strokeColor = .white
            eraserButton.layer.borderColor = UIColor.red.cgColor
            eraserButton.layer.borderWidth = 1.0
            
            pencilButton.layer.borderColor = UIColor.clear.cgColor
            pencilButton.layer.borderWidth = 0.0
        }
    }
}
