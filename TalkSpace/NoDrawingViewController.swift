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
        let drawingVC = DrawingViewController()
        let drawingViewModel = DrawingViewModel()
        drawingViewModel.drawing = Drawing()
        
        drawingVC.viewModel = drawingViewModel
        self.navigationController?.pushViewController(drawingVC, animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
