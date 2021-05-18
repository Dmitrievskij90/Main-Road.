//
//  RecordTableViewCell.swift
//  Main Road
//
//  Created by Konstantin Dmitrievskiy on 15.05.2021.
//

import UIKit

class RecordTableViewCell: UITableViewCell {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var contentVIew: UIView!
    @IBOutlet weak var userCarImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        contentVIew.backgroundColor = .init(hex:0xfaf2da)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}


