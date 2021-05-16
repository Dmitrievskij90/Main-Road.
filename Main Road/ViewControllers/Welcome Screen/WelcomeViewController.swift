//
//  WelcomeViewController.swift
//  Main Road
//
//  Created by Konstantin Dmitrievskiy on 09.04.2021.
//

import UIKit

class WelcomeViewController: UIViewController {
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var carImageView: UIImageView!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var recordsButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .init(hex: 0x62AEC8)
        hideNavigationItemBackground()
        setupUI()
//
//        print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as String)
//        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//        print(documentsDirectory)
    }

    @IBAction private func startButtonPressed(_ sender: UIButton) {
        let viewController = RaceViewController.instantiate()
        viewController.modalTransitionStyle = .coverVertical
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true, completion: nil)

        let car = UserDefaults.standard.value(forKey: "userCar") as? String
        let obstacles = UserDefaults.standard.value(forKey: "barrierType") as? String

        if let playerCar = car, let choosedObstacle = obstacles {
            viewController.playerCarImageView.image = UIImage(named: playerCar)
            viewController.firstObstacle.image = UIImage(named: choosedObstacle)
            viewController.secondObstacle.image = UIImage(named: choosedObstacle)
        } else {
            viewController.playerCarImageView.image = UIImage(named: "ic_yellowCar")
            viewController.firstObstacle.image = UIImage(named: "ic_hole")
            viewController.secondObstacle.image = UIImage(named: "ic_hole")
        }
    }

    @IBAction private func settingsButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "SettingsID", sender: self)
    }

    @IBAction func recordsButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "RecordsID", sender: self)
    }
    

    private func setupUI() {
        startButton.backgroundColor = .init(hex:0xfaf2da)
        startButton.setTitle("START", for: .normal)
        startButton.setTitleColor(.black, for: .normal)
        startButton.titleLabel?.font = UIFont(name: "bodoni 72 smallcaps", size: 35)
        startButton.layer.cornerRadius = 65
        startButton.layer.borderColor = UIColor.black.cgColor
        startButton.layer.borderWidth = 3

        recordsButton.setTitle("RECORDS", for: .normal)
        recordsButton.setTitleColor(.black, for: .normal)
        recordsButton.titleLabel?.font = UIFont(name: "bodoni 72 smallcaps", size: 15)
        recordsButton.layer.cornerRadius = 25
        recordsButton.layer.borderColor = UIColor.black.cgColor
        recordsButton.layer.borderWidth = 3

        settingsButton.layer.cornerRadius = 40

        lineView.backgroundColor = .init(hex: 0xF15A25)

        titleLabel.text = "Main road"
        titleLabel.textColor = .black
        titleLabel.font = UIFont(name: "Snell roundhand", size: 80)
        titleLabel.textAlignment = .center

        carImageView.image = UIImage(named: "ic_mainCar")
        carImageView.contentMode = .scaleAspectFill
    }

    private func hideNavigationItemBackground() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .clear
        navigationController?.navigationBar.tintColor = .label
    }
}
