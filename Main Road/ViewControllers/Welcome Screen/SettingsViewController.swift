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
    private var level: Double = 0.04
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
        setupUI()
        setupSwipeGestureRecognizer()
        setupObstacleGesterRecognizer()
    }

    @IBAction private func selectButtonPressed(_ sender: UIButton) {
    }

    private func setupUI() {
        selectButton.backgroundColor = .init(hex: 0xF15A25)
        selectButton.setTitle("select", for: .normal)
        selectButton.setTitleColor(.white, for: .normal)
        selectButton.titleLabel?.font = UIFont(name: "bodoni 72 smallcaps", size: 20)
        selectButton.layer.cornerRadius = 10
        selectButton.layer.borderColor = UIColor.black.cgColor
        selectButton.layer.borderWidth = 1.5

        barrelImageView.image = UIImage(named: "ic_barrel")
        barrelImageView.contentMode = .scaleAspectFit
//
        holeImageView.image = UIImage(named: "ic_hole")
        holeImageView.contentMode = .scaleAspectFit
//
        tyresImageView.image = UIImage(named: "ic_tyres")
        tyresImageView.contentMode = .scaleAspectFit

        setupLabel(label: easyLevelLabel, title: "easy")
        setupLabel(label: mediumLevelLabel, title: "medium")
        setupLabel(label: hardLavelLabel, title: "hard")
    }

    private func setupLabel(label: UILabel, title: String) {
        label.backgroundColor = .white
        label.text = title
        label.textColor = .black
        label.font = UIFont(name: "bodoni 72 smallcaps", size: 20)
        label.textAlignment = .center
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
        label.layer.borderColor = UIColor.black.cgColor
        label.layer.borderWidth = 1.5
    }

    func setupSwipeGestureRecognizer() {
        let swipeGestureLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_ :)))
        let swipeGestureRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_ :)))
        swipeGestureLeft.direction = .left
        swipeGestureRight.direction = .right
        view.addGestureRecognizer(swipeGestureLeft)
        view.addGestureRecognizer(swipeGestureRight)
    }

    @objc func handleSwipe(_ sender: UISwipeGestureRecognizer) {
        if sender.state == .ended {
            switch sender.direction {
            case .left:
                index += 1
                checkIndex()
                carImageView.transform = CGAffineTransform(translationX: 300, y: 0)
                carImageView.transform = carImageView.transform.rotated(by: .pi)
                applyAnimation()
            case .right:
                index -= 1
                checkIndex()
                carImageView.transform = CGAffineTransform(translationX: -300, y: 0)
                carImageView.transform = carImageView.transform.rotated(by: .pi)
                applyAnimation()
            default:
                break
            }
        }
    }

   private func checkIndex() {
        if index >= cars.count {
            index = 0
        } else if index <= -1 {
            index = cars.count - 1
        }
        upDateUI()
    }

   private func upDateUI() {
        carImageView.image = cars[index]
    }

   private func applyAnimation() {
        UIView.animate(withDuration: 1.0) {
            self.carImageView.transform = CGAffineTransform(rotationAngle: .pi * 2.0)
        } completion: { _ in
            UIView.animate(withDuration: 0.3) {
                self.carImageView.transform = CGAffineTransform.identity.scaledBy(x: 1.5, y: 1.5)
            }
        }
    }

    private func setupObstacleGesterRecognizer() {
        let barrelTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(fitrstimageTapped(tapGestureRecognizer:)))
        let holeTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(secondimageTapped(tapGestureRecognizer:)))
        let tyresTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(thirdimageTapped(tapGestureRecognizer:)))

        barrelImageView.isUserInteractionEnabled = true
        holeImageView.isUserInteractionEnabled = true
        tyresImageView.isUserInteractionEnabled = true

        barrelImageView.addGestureRecognizer(barrelTapGestureRecognizer)
        holeImageView.addGestureRecognizer(holeTapGestureRecognizer)
        tyresImageView.addGestureRecognizer(tyresTapGestureRecognizer)
    }

    @objc func fitrstimageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        selectedImage = "ic_barrel"


//        barrelImageView.backgroundColor = .init(hex: 0xf0e3ca)

        barrelImageView.layer.cornerRadius = 25
        barrelImageView.clipsToBounds = true
        barrelImageView.layer.borderColor = UIColor.darkGray.cgColor
        barrelImageView.layer.borderWidth = 1.5

        resetImageViewSettings(imageView: tyresImageView)
        resetImageViewSettings(imageView: holeImageView)
    }

    @objc func secondimageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        selectedImage = "ic_hole"

//        holeImageView.backgroundColor = .init(hex: 0xf0e3ca)
        holeImageView.layer.cornerRadius = 25
        holeImageView.clipsToBounds = true
        holeImageView.layer.borderColor = UIColor.darkGray.cgColor
        holeImageView.layer.borderWidth = 1.5

        resetImageViewSettings(imageView: barrelImageView)
        resetImageViewSettings(imageView: tyresImageView)
    }

    @objc func thirdimageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        selectedImage = "ic_tyres"

//        tyresImageView.backgroundColor = .init(hex: 0xf0e3ca)
        tyresImageView.layer.cornerRadius = 25
        tyresImageView.clipsToBounds = true
        tyresImageView.layer.borderColor = UIColor.darkGray.cgColor
        tyresImageView.layer.borderWidth = 1.5

        resetImageViewSettings(imageView: barrelImageView)
        resetImageViewSettings(imageView: holeImageView)
    }

    private func resetImageViewSettings(imageView: UIImageView) {
        imageView.backgroundColor = .white

        imageView.layer.borderWidth = 0
    }

}
