//
//  DrawingCell.swift
//  TalkSpace
//
//  Created by Teju Prasad on 7/25/20.
//  Copyright © 2020 Four Rooms. All rights reserved.
//

import UIKit

class DrawingCell: UITableViewCell {

    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var drawingTimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(viewModel: DrawingCellViewModel) {
        startDateLabel.text = viewModel.startTimeText()
        drawingTimeLabel.text = viewModel.drawingTimeText()
        thumbImageView.image = viewModel.thumbnailImage()
    }
}
