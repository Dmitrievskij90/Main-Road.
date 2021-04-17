//
//  ViewController.swift
//  Main Road
//
//  Created by Konstantin Dmitrievskiy on 09.04.2021.
//

import UIKit

class GameViewController: UIViewController {
    private var playerCar = UIImageView()
    private var lineView = UIView()
    private var secondlineView = UIView()
    private var thirdlineView = UIView()
    private var fourhtLineView = UIView()
    private var barrelImageView = UIImageView()
    private var secondbarrelImageView = UIImageView()
    private var leftTireTackImageView = UIImageView()
    private var rightTireTackImageView = UIImageView()
    private var firstBarrierImageView = UIImageView()
    private var secondBarrierImageView = UIImageView()

    override func loadView() {
        let view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = .gray
        self.view = view

        setupUI()

        view.addSubview(lineView)
        view.addSubview(secondlineView)
        view.addSubview(thirdlineView)
        view.addSubview(fourhtLineView)
        view.addSubview(barrelImageView)
        view.addSubview(secondbarrelImageView)
        view.addSubview(firstBarrierImageView)
        view.addSubview(secondBarrierImageView)
        view.addSubview(leftTireTackImageView)
        view.addSubview(rightTireTackImageView)
        view.addSubview(playerCar)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(onPan(_:)))
        playerCar.isUserInteractionEnabled = true
        playerCar.addGestureRecognizer(panRecognizer)

        let timer = Timer.scheduledTimer(timeInterval: 0.005, target: self, selector: #selector(self.amimateLineView), userInfo: nil, repeats: true)
        timer.fire()

        animateTireTracks()
    }

    override func viewWillLayoutSubviews() {
        setupUILayout()
        setupObstructionLayout()
    }

    func setupUILayout() {
        playerCar.translatesAutoresizingMaskIntoConstraints = false
        lineView.translatesAutoresizingMaskIntoConstraints = false
        secondlineView.translatesAutoresizingMaskIntoConstraints = false
        thirdlineView.translatesAutoresizingMaskIntoConstraints = false
        fourhtLineView.translatesAutoresizingMaskIntoConstraints = false
        firstBarrierImageView.translatesAutoresizingMaskIntoConstraints = false
        secondBarrierImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            playerCar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playerCar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            playerCar.widthAnchor.constraint(equalToConstant: 80),
            playerCar.heightAnchor.constraint(equalToConstant: 150),
            leftTireTackImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -20),
            leftTireTackImageView.topAnchor.constraint(equalTo: playerCar.topAnchor),
            leftTireTackImageView.widthAnchor.constraint(equalToConstant: 25),
            leftTireTackImageView.heightAnchor.constraint(equalToConstant: 100),
            rightTireTackImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 20),
            rightTireTackImageView.topAnchor.constraint(equalTo: playerCar.topAnchor),
            rightTireTackImageView.widthAnchor.constraint(equalToConstant: 25),
            rightTireTackImageView.heightAnchor.constraint(equalToConstant: 100),
            lineView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lineView.topAnchor.constraint(equalTo: view.topAnchor),
            lineView.widthAnchor.constraint(equalToConstant: 20),
            lineView.heightAnchor.constraint(equalToConstant: 100),
            secondlineView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            secondlineView.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 110),
            secondlineView.widthAnchor.constraint(equalToConstant: 20),
            secondlineView.heightAnchor.constraint(equalToConstant: 100),
            thirdlineView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            thirdlineView.topAnchor.constraint(equalTo: secondlineView.bottomAnchor, constant: 110),
            thirdlineView.widthAnchor.constraint(equalToConstant: 20),
            thirdlineView.heightAnchor.constraint(equalToConstant: 100),
            fourhtLineView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            fourhtLineView.topAnchor.constraint(equalTo: thirdlineView.bottomAnchor, constant: 110),
            fourhtLineView.widthAnchor.constraint(equalToConstant: 20),
            fourhtLineView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }

    func setupObstructionLayout() {
        barrelImageView.translatesAutoresizingMaskIntoConstraints = false
        secondbarrelImageView.translatesAutoresizingMaskIntoConstraints = false
        leftTireTackImageView.translatesAutoresizingMaskIntoConstraints = false
        rightTireTackImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            barrelImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 90),
            barrelImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            barrelImageView.widthAnchor.constraint(equalToConstant: 30),
            barrelImageView.heightAnchor.constraint(equalToConstant: 80),
            secondbarrelImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -150),
            secondbarrelImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 200),
            secondbarrelImageView.widthAnchor.constraint(equalToConstant: 30),
            secondbarrelImageView.heightAnchor.constraint(equalToConstant: 80),
            firstBarrierImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            firstBarrierImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            firstBarrierImageView.widthAnchor.constraint(equalToConstant: 80),
            firstBarrierImageView.heightAnchor.constraint(equalToConstant: 30),
            secondBarrierImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -30),
            secondBarrierImageView.topAnchor.constraint(equalTo: view.topAnchor),
            secondBarrierImageView.widthAnchor.constraint(equalToConstant: 80),
            secondBarrierImageView.heightAnchor.constraint(equalToConstant: 30)
        ])
    }

    func setupUI() {
        playerCar.image = UIImage(named: "ic_car")
        playerCar.contentMode = .scaleAspectFit
        playerCar.setImageShadowWithColor(color: UIColor.black.cgColor, opacity: 1.0, offset: CGSize.zero, radius: 20.0, masksToBounds: false)

        leftTireTackImageView.image = UIImage(named: "ic_tireTracks")
        leftTireTackImageView.contentMode = .scaleAspectFit

        rightTireTackImageView.image = UIImage(named: "ic_tireTracks")
        rightTireTackImageView.contentMode = .scaleAspectFit

        barrelImageView.image = UIImage(named: "ic_barrel")
        barrelImageView.contentMode = .scaleAspectFill

        secondbarrelImageView.image = UIImage(named: "ic_barrel")
        secondbarrelImageView.contentMode = .scaleAspectFill

        firstBarrierImageView.image = UIImage(named: "ic_barrier")
        firstBarrierImageView.contentMode = .scaleAspectFill

        secondBarrierImageView.image = UIImage(named: "ic_barrier")
        secondBarrierImageView.contentMode = .scaleAspectFill

        lineView.backgroundColor = .yellow
        secondlineView.backgroundColor = .yellow
        thirdlineView.backgroundColor = .yellow
        fourhtLineView.backgroundColor = .yellow
    }

    @objc func onPan(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: self.view)
        if let view = sender.view {
            view.center = CGPoint(x: view.center.x + translation.x, y: view.center.y + translation.y)
        }
        sender.setTranslation(CGPoint.zero, in: self.view)

        collisionHandler()
    }

    @objc func amimateLineView() {
        self.lineView.frame = CGRect(x: self.lineView.frame.origin.x, y: self.lineView.frame.origin.y + 1, width: 20, height: 100)
        if self.lineView.frame.origin.y == self.view.bounds.maxY {
            self.lineView.frame.origin.y = 0
        }

        self.secondlineView.frame = CGRect(x: self.secondlineView.frame.origin.x, y: self.secondlineView.frame.origin.y + 1, width: 20, height: 100)
        if self.secondlineView.frame.origin.y == self.view.bounds.maxY {
            self.secondlineView.frame.origin.y = 0
        }

        self.thirdlineView.frame = CGRect(x: self.thirdlineView.frame.origin.x, y: self.thirdlineView.frame.origin.y + 1, width: 20, height: 100)
        if self.thirdlineView.frame.origin.y == self.view.bounds.maxY {
            self.thirdlineView.frame.origin.y = 0
        }

        self.fourhtLineView.frame = CGRect(x: self.fourhtLineView.frame.origin.x, y: self.fourhtLineView.frame.origin.y + 1, width: 20, height: 100)
        if self.fourhtLineView.frame.origin.y == self.view.bounds.maxY {
            self.fourhtLineView.frame.origin.y = 0
        }

        self.barrelImageView.frame = CGRect(x: self.barrelImageView.frame.origin.x, y: self.barrelImageView.frame.origin.y + 1, width: 30, height: 80)
        if self.barrelImageView.frame.origin.y == self.view.bounds.maxY {
            self.barrelImageView.frame.origin.y = 0
        }

        self.secondbarrelImageView.frame = CGRect(x: self.secondbarrelImageView.frame.origin.x, y: self.secondbarrelImageView.frame.origin.y + 1, width: 30, height: 80)
        if self.secondbarrelImageView.frame.origin.y == self.view.bounds.maxY {
            self.secondbarrelImageView.frame.origin.y = 0
        }

        self.firstBarrierImageView.frame = CGRect(x: self.firstBarrierImageView.frame.origin.x, y: self.firstBarrierImageView.frame.origin.y + 1, width: 80, height: 30)
        if self.firstBarrierImageView.frame.origin.y == self.view.bounds.maxY {
            self.firstBarrierImageView.frame.origin.y = 0
        }

        self.secondBarrierImageView.frame = CGRect(x: self.secondBarrierImageView.frame.origin.x, y: self.secondBarrierImageView.frame.origin.y + 1, width: 80, height: 30)
        if self.secondBarrierImageView.frame.origin.y == self.view.bounds.maxY {
            self.secondBarrierImageView.frame.origin.y = 0
        }
    }

    private func collisionHandler() {
        if playerCar.frame.intersects(barrelImageView.frame) || playerCar.frame.intersects(secondbarrelImageView.frame)
            || playerCar.frame.intersects(firstBarrierImageView.frame) || playerCar.frame.intersects(secondBarrierImageView.frame) {
            navigationController?.popViewController(animated: true)
        }
    }

    private func animateTireTracks() {
        UIView.animate(withDuration: 2.5) {
            self.leftTireTackImageView.transform = CGAffineTransform(translationX: 0, y: 300)
            self.rightTireTackImageView.transform = CGAffineTransform(translationX: 0, y: 300)
        }
    }
}
