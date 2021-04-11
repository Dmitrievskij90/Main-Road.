//
//  WelcomeViewController.swift
//  Main Road
//
//  Created by Konstantin Dmitrievskiy on 09.04.2021.
//

import UIKit

class WelcomeViewController: UIViewController {
    private let carImageView = UIImageView()
    private let startButton = UIButton(type: .system)
    private let titleLabel = UILabel()
    private let lineView = UIView()
    private let topView = UIView()
    private let bottomView = UIView()

    override func loadView() {
        let view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = .white
        self.view = view
        view.backgroundColor = UIColor.init(hex: 0x62AEC8)
        view.addSubview(lineView)
        view.addSubview(startButton)
        view.addSubview(carImageView)
        view.addSubview(topView)
        view.addSubview(bottomView)
        view.addSubview(carImageView)
        topView.addSubview(titleLabel)
        bottomView.addSubview(startButton)
        setupUI()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        hideNavigationItemBackground()
    }

    override func viewWillLayoutSubviews() {
        startButton.translatesAutoresizingMaskIntoConstraints = false
        lineView.translatesAutoresizingMaskIntoConstraints = false
        carImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        topView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            topView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topView.topAnchor.constraint(equalTo: view.topAnchor),
            topView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
            bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
            startButton.widthAnchor.constraint(equalToConstant: 130),
            startButton.heightAnchor.constraint(equalToConstant: 130),
            startButton.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor),
            startButton.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor),
            lineView.widthAnchor.constraint(equalToConstant: 100),
            lineView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lineView.topAnchor.constraint(equalTo: view.topAnchor),
            lineView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            carImageView.widthAnchor.constraint(equalToConstant: 200),
            carImageView.heightAnchor.constraint(equalToConstant: 200),
            carImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            carImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -10),
            titleLabel.heightAnchor.constraint(equalToConstant: 100),
            titleLabel.widthAnchor.constraint(equalToConstant: 400),
            titleLabel.centerXAnchor.constraint(equalTo: topView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: topView.centerYAnchor)
        ])
    }

    @objc func startButtonPressed() {
        let viewController = GameViewController()
        navigationController?.pushViewController(viewController, animated: true)
        //        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        //        let destinationVC = storyboard.instantiateViewController(identifier: "ViewController")
        //        present(destinationVC, animated: true, completion: nil)
    }

    func setupUI() {
        startButton.addTarget(self, action: #selector(startButtonPressed), for: .touchUpInside)
        startButton.backgroundColor = .white
        startButton.setTitle("START", for: .normal)
        startButton.setTitleColor(.black, for: .normal)
        startButton.titleLabel?.font = UIFont(name: "bodoni 72 smallcaps", size: 35)
        startButton.apllyButtonCornerRadius(65)
        startButton.layer.borderColor = UIColor.black.cgColor
        startButton.layer.borderWidth = 3

        lineView.backgroundColor = UIColor.init(hex: 0xED5B27)
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
