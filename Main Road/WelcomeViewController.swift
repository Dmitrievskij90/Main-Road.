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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .init(hex: 0x62AEC8)
        hideNavigationItemBackground()
        setupUI()
    }

    @IBAction private func startButtonPressed(_ sender: UIButton) {
        //        let viewController = RaceViewController.instantiate()
        //        viewController.modalTransitionStyle = .coverVertical
        //        viewController.modalPresentationStyle = .fullScreen
        //        present(viewController, animated: true, completion: nil)
    }

    private func setupUI() {
        startButton.backgroundColor = .white
        startButton.setTitle("START", for: .normal)
        startButton.setTitleColor(.black, for: .normal)
        startButton.titleLabel?.font = UIFont(name: "bodoni 72 smallcaps", size: 35)
        startButton.layer.cornerRadius = 65
        startButton.layer.borderColor = UIColor.black.cgColor
        startButton.layer.borderWidth = 3

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
