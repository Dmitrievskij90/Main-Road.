//
//  RecordTableViewCell.swift
//  Main Road
//
//  Created by Konstantin Dmitrievskiy on 15.05.2021.
//

import UIKit

class RecordTableViewCell: UITableViewCell {
//    @IBOutlet weak var levelMark: UILabel!
//    @IBOutlet weak var scoreMark: UILabel!
//    @IBOutlet weak var levelLabel: UILabel!
//    @IBOutlet weak var scoreLabel: UILabel!

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupLabel(label: userNameLabel)
        setupLabel(label: scoreLabel)
        setupLabel(label: dateLabel)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    private func setupLabel(label: UILabel) {
        label.backgroundColor = .init(hex:0xfaf2da)
        label.textColor = .black
        label.font = UIFont(name: "bodoni 72 smallcaps", size: 20)
        label.textAlignment = .center
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
        label.layer.borderColor = UIColor.black.cgColor
        label.layer.borderWidth = 1.5
    }
}
