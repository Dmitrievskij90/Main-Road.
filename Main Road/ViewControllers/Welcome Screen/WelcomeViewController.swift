//
//  WelcomeViewController.swift
//  Main Road
//
//  Created by Konstantin Dmitrievskiy on 09.04.2021.
//

import UIKit

class WelcomeViewController: UIViewController {
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
    }

    @IBAction private func startButtonPressed(_ sender: UIButton) {
        let viewController = RaceViewController.instantiate()
        viewController.modalTransitionStyle = .coverVertical
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true, completion: nil)

        let car = UserDefaults.standard.value(forKey: "userCar") as? String
        let obstacles = UserDefaults.standard.value(forKey: "barrierType") as? String

        if let playerCar = car, let choosedObstacle = obstacles {
            viewController.user.image = UIImage(named: playerCar)
            viewController.firstObstacle.image = UIImage(named: choosedObstacle)
            viewController.secondObstacle.image = UIImage(named: choosedObstacle)
        } else {
            viewController.user.image = UIImage(named: Constants.yellowCar)
            viewController.firstObstacle.image = UIImage(named: Constants.hole)
            viewController.secondObstacle.image = UIImage(named: Constants.hole)
        }
    }

    @IBAction private func settingsButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: Constants.settingsID, sender: self)
    }

    @IBAction private func recordsButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: Constants.recordsID, sender: self)
    }

    private func setupUI() {
        startButton.backgroundColor = .init(hex:0xFFEDA3)
        startButton.setTitle(Constants.startButtonTitle, for: .normal)
        startButton.setTitleColor(.black, for: .normal)
        startButton.titleLabel?.font = UIFont(name: "bodoni 72 smallcaps", size: 35)
        startButton.layer.cornerRadius = 65
        startButton.layer.borderColor = UIColor.black.cgColor
        startButton.layer.borderWidth = 3
        startButton.clipsToBounds = true

        recordsButton.setTitle(Constants.recordsButtonTitle, for: .normal)
        recordsButton.setTitleColor(.black, for: .normal)
        recordsButton.titleLabel?.font = UIFont(name: "bodoni 72 smallcaps", size: 20)
        recordsButton.layer.cornerRadius = 12
        recordsButton.layer.borderColor = UIColor.black.cgColor
        recordsButton.layer.borderWidth = 3

        settingsButton.layer.cornerRadius = 40

        titleLabel.text = Constants.welcomeScreenTitle
        titleLabel.textColor = .black
        titleLabel.font = UIFont(name: "Ardeco", size: 80)
        titleLabel.textAlignment = .center

        carImageView.image = UIImage(named: Constants.mainCar)
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
