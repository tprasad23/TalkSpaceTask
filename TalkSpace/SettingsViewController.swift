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
    
    var lineWidth: Int?
    var colorChosen: ((UIColor)->())?
    var lineWidthChosen: ((Int)->())?
    
    
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
    }
    
    func initializeSliderUI() {
        slider.minimumValue = 1.0
        slider.maximumValue = 10.0
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
    
    @IBAction func sliderMoved(_ sender: Any) {
        let widthValue: Int = Int(slider.value)
        lineWidthLabel.text = "Line Width: \(widthValue)"
        lineWidthChosen?(widthValue)
    }
}
