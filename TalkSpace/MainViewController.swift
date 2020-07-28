//
//  MainViewController.swift
//  TalkSpace
//
//  Created by Teju Prasad on 7/25/20.
//  Copyright © 2020 Four Rooms. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    var listVC: DrawingListViewController?
    var ndVC: NoDrawingViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add table view controller.
        setupViewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupViewWillAppear()
    }
    
    func setupViewDidLoad() {
        // Setup Nav Bar
        title = "Drawings"
        edgesForExtendedLayout = []
    }
    
    func setupViewWillAppear() {
        let decodedDrawings = UserDefaults.standard.fetchSavedDecodedDrawings()
        
        if decodedDrawings.count > 0 {
            // Need this check for the first drawing added, a "no drawing"
            // view controller exists, we must remove it.
            if let ndVC = ndVC {
                ndVC.willMove(toParent: nil)
                ndVC.view.removeFromSuperview()
                ndVC.removeFromParent()
            }
            
            if let listVC = listVC {
                // list is already present, simply update
                // the drawing list and refresh the table.
                listVC.decodedDrawings = decodedDrawings
                listVC.refreshTable()
            } else {
                addNewDrawingNavButton()
                listVC = DrawingListViewController()
                listVC?.decodedDrawings = decodedDrawings
               
                view.addSubview(listVC!.view)
                self.addChild(listVC!)
                listVC?.didMove(toParent: self)
            }
        } else {
            ndVC = NoDrawingViewController()
            view.addSubview(ndVC!.view)
            self.addChild(ndVC!)
            ndVC?.didMove(toParent: self)

        }
    }
    
    func addNewDrawingNavButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewDrawing))
    }
    
    @objc func addNewDrawing() {
        let drawingViewModel = DrawingViewModel(drawing: Drawing(), drawingMode: .pencil, presentationMode: .drawing)
        let drawingVC = DrawingViewController()
        
        drawingVC.viewModel = drawingViewModel
        self.navigationController?.pushViewController(drawingVC, animated: true)
    }
}
