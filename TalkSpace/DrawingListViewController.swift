//
//  DrawingListViewController.swift
//  TalkSpace
//
//  Created by Teju Prasad on 7/27/20.
//  Copyright © 2020 Four Rooms. All rights reserved.
//

import UIKit

class DrawingListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var decodedDrawings: [Drawing] = []
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "DrawingCell", bundle: nil), forCellReuseIdentifier: "DrawingCell")
        
        refreshControl.addTarget(self, action: #selector(refreshTable), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    @objc func addNewDrawing() {
        let drawingVC = DrawingViewController()
        let drawingViewModel = DrawingViewModel()
        drawingViewModel.drawing = Drawing()
        drawingVC.viewModel = drawingViewModel
        
        self.navigationController?.pushViewController(drawingVC, animated: true)
    }
    
    @objc func refreshTable() {
        decodedDrawings = UserDefaults.standard.fetchSavedDrawings()
        tableView.reloadData()
        refreshControl.endRefreshing()
    }
}


extension DrawingListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return decodedDrawings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DrawingCell", for: indexPath) as? DrawingCell else { fatalError("Could not dequeue cell") }
        let decodedDrawing = decodedDrawings[indexPath.row]
        let drawingCellViewModel = DrawingCellViewModel()
        drawingCellViewModel.drawing = decodedDrawing
        cell.configure(viewModel: drawingCellViewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            // First delete the drawing from the UserDefaults storage, then
            // reload the datasource array from the updated defaults, then
            // animate the row away.
            
            UserDefaults.standard.deleteDrawing(index: indexPath.row)
            decodedDrawings = UserDefaults.standard.fetchSavedDrawings()
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
