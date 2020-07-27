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
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "DrawingCell", bundle: nil), forCellReuseIdentifier: "DrawingCell")
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
}
