//
//  SettingsViewController.swift
//  Main Road
//
//  Created by Konstantin Dmitrievskiy on 07.05.2021.
//

import UIKit

class SettingsViewController: UIViewController {
    private let defaults = UserDefaults.standard
    private var index = 0
    private var selectedImage = "ic_barrel"
    private var level:Double = 0.04
    private var levelName = ""
    private var cars = [UIImage(named: "ic_yellowCar"), UIImage(named: "ic_silverCar"), UIImage(named: "ic_redCar")]
    private var carName = ["ic_yellowCar", "ic_silverCar", "ic_redCar"]

    @IBOutlet weak var carImageView: UIImageView!
    @IBOutlet weak var barrelImageView: UIImageView!
    @IBOutlet weak var holeImageView: UIImageView!
    @IBOutlet weak var tyresImageView: UIImageView!
    @IBOutlet weak var easyLevelLabel: UILabel!
    @IBOutlet weak var mediumLevelLabel: UILabel!
    @IBOutlet weak var hardLavelLabel: UILabel!
    @IBOutlet weak var selectButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func selectButtonPressed(_ sender: UIButton) {
    }
    
}
