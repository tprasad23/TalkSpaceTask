//
//  SettingsViewController.swift
//  TalkSpace
//
//  Created by Teju Prasad on 7/25/20.
//  Copyright © 2020 Four Rooms. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var buttonStackView: UIStackView!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var lineWidthLabel: UILabel!
    
    let colorArray: [UIColor] = [.black, .cyan, .green, .blue, .purple]
    
    var colorChosen: ((UIColor)->())?
    var lineWidthChosen: ((Int)->())?
    
    var initialColor: UIColor?
    var initialLineWidth: CGFloat?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initializeButtonUI()
        initializeSliderUI()
    }

    @IBAction func colorButtonTapped(_ sender: UIButton) {
        let tag = sender.tag
        colorChosen?(colorArray[tag])
        updateButtonUI(tag: tag)
    }
    
    func initializeButtonUI() {
        buttonStackView.backgroundColor = .gray
        let buttons = buttonStackView.arrangedSubviews
        for button in buttons {
            if button is UIButton {
                button.clipsToBounds = true
                button.layer.cornerRadius = 20
                button.backgroundColor = colorArray[button.tag]
            }
        }
        
        if let initialColor = initialColor {
            if let tag = colorArray.firstIndex(of: initialColor) {
                updateButtonUI(tag: tag)
            }
        }
    }
    
    func initializeSliderUI() {
        slider.minimumValue = 1.0
        slider.maximumValue = 10.0
        
        if let lineWidth = initialLineWidth {
            slider.value = Float(lineWidth)
            updateSliderUI(widthVal: Int(lineWidth))
        }
    }
    
    func updateButtonUI(tag: Int) {
        let buttons = buttonStackView.arrangedSubviews
        for button in buttons {
            if button is UIButton {
                if button.tag == tag {
                    button.layer.borderColor = UIColor.red.cgColor
                    button.layer.borderWidth = 4.0
                } else {
                    button.layer.borderColor = UIColor.clear.cgColor
                    button.layer.borderWidth = 0.0
                }
            }
        }
    }
    
    func updateSliderUI(widthVal: Int) {
        lineWidthLabel.text = "Line Width: \(widthVal)"
    }
    
    @IBAction func sliderMoved(_ sender: Any) {
        let widthValue: Int = Int(slider.value)
        updateSliderUI(widthVal: widthValue)
        lineWidthChosen?(widthValue)
    }
}
