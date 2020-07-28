//
//  NoDrawingViewController.swift
//  TalkSpace
//
//  Created by Teju Prasad on 7/26/20.
//  Copyright © 2020 Four Rooms. All rights reserved.
//

import UIKit

class NoDrawingViewController: UIViewController {
    @IBOutlet weak var noDrawingsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        noDrawingsButton.titleLabel?.numberOfLines = 0
        noDrawingsButton.titleLabel?.lineBreakMode = .byWordWrapping
        noDrawingsButton.titleLabel?.textAlignment = .center
        noDrawingsButton.setTitle("No Drawings Yet\nCreate One!", for: .normal)
    }

    @IBAction func noDrawingsButtonAction(_ sender: Any) {
        let drawingViewModel = DrawingViewModel(drawing: Drawing(), drawingMode: .pencil, presentationMode: .drawing)
        let drawingVC = DrawingViewController()
        
        drawingVC.viewModel = drawingViewModel
        self.navigationController?.pushViewController(drawingVC, animated: true)
    }
}
