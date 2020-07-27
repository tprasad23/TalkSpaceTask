//
//  MainViewController.swift
//  TalkSpace
//
//  Created by Teju Prasad on 7/25/20.
//  Copyright © 2020 Four Rooms. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add table view controller.
        setupViewDidLoad()
    }

    func setupViewDidLoad() {
        
        // Setup Nav Bar
        
        title = "Drawings"
        edgesForExtendedLayout = []
        
        // If any drawings exist, present them, otherwise
        // present "No Drawings" Screen
        
        let testingDrawing = true
        
        let decodedDrawings = UserDefaults.standard.fetchSavedDrawings()
        print("# of drawings is \(decodedDrawings.count)")
        if decodedDrawings.count > 0 && !testingDrawing {
            let listVC = DrawingListViewController()
            listVC.decodedDrawings = decodedDrawings
            view.addSubview(listVC.view)
            self.addChild(listVC)
            listVC.didMove(toParent: self)
        } else {
            let ndVC = NoDrawingViewController()
            view.addSubview(ndVC.view)
            self.addChild(ndVC)
            ndVC.didMove(toParent: self)
        }
    }
}
