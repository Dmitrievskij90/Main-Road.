//
//  RaceViewController.swift
//  Main Road
//
//  Created by Konstantin Dmitrievskiy on 06.05.2021.
//

import UIKit

class RaceViewController: UIViewController {
    var playerCarImageView = UIImageView()
    var firstObstacle = UIImageView()
    var secondObstacle = UIImageView()
    private var policeCarImageView = UIImageView()
    private var points = 0
    private var isEmpty = 5
    private var animationTimer: Timer?
    private var updateTimer: Timer?
    private let level = UserDefaults.standard.value(forKey: "gameLavel") as? Double
    private var gameResult = [Results]()

    @IBOutlet weak var leftGrassView: UIView!
    @IBOutlet weak var rightGrassView: UIView!
    @IBOutlet weak var startCountLabel: UILabel!
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var levelMark: UILabel!
    @IBOutlet weak var pointsMark: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5), execute: {
            let timer = Timer.scheduledTimer(timeInterval: self.level ?? 0.04, target: self, selector: #selector(self.amimateEnemy), userInfo: nil, repeats: true)
            timer.fire()
        })

        _ = Timer.scheduledTimer(timeInterval: 0.8, target: self, selector: #selector(updateStartCountLabel), userInfo: nil, repeats: true)

        let carMoveGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(playerPressed))
        carMoveGestureRecognizer.minimumPressDuration = 0.001
        view.addGestureRecognizer(carMoveGestureRecognizer)

        createObstacles()
        createPoliceCar()
        createPlayerCar()
        setupUI()
    }

    private func createPlayerCar() {
        playerCarImageView = UIImageView(image: UIImage(named: "ic_yellowCar"))
        playerCarImageView.frame = CGRect(x: 0, y: 0, width: 70, height: 130)
        playerCarImageView.frame.origin.y = view.bounds.height - playerCarImageView.frame.size.height - 60
        playerCarImageView.center.x = CGFloat(self.view.bounds.midX)
        view.addSubview(playerCarImageView)
    }

    private func createObstacles() {
        firstObstacle.frame = CGRect(x: view.frame.midX - 110, y: view.frame.midY - 200, width: 25, height: 60)
        view.addSubview(firstObstacle)

        secondObstacle.frame = CGRect(x: view.frame.midX + 85, y: view.frame.midY + 200, width: 25, height: 60)
        view.addSubview(secondObstacle)
    }

    private func createPoliceCar() {
        //        policeCarImageView.frame = CGRect(x: 0, y: 0, width: 70, height: 130)
        let randomPoliceX = CGFloat.random(in: view.frame.minX + 100...view.frame.maxX - 100)
        policeCarImageView.frame = CGRect(x: randomPoliceX, y: -150, width: 70, height: 130)
        view.addSubview(policeCarImageView)
    }

    private  func setupUI() {
        startCountLabel.textAlignment = .center
        startCountLabel.font = UIFont(name: "TitilliumWeb-Bold", size: 150)
        startCountLabel.adjustsFontSizeToFitWidth = true
        let attributes: [NSAttributedString.Key: Any] = [
            .strokeWidth: 5.0,
            .strokeColor: UIColor(hex: 0x201E1F)
        ]
        let attributedString = NSAttributedString(string: "5", attributes: attributes)
        startCountLabel.attributedText = attributedString

        leftGrassView.layer.borderColor = UIColor.black.cgColor
        leftGrassView.layer.borderWidth = 3

        rightGrassView.layer.borderColor = UIColor.black.cgColor
        rightGrassView.layer.borderWidth = 3

        policeCarImageView.image = UIImage(named: "ic_policeCar")
        policeCarImageView.contentMode = .scaleAspectFill

        firstObstacle.image = UIImage(named: "ic_hole")
        firstObstacle.contentMode = .scaleAspectFill

        secondObstacle.image = UIImage(named: "ic_hole")
        secondObstacle.contentMode = .scaleAspectFill

//        let levelName = UserDefaults.standard.value(forKey: "levelName") as? String
//        levelLabel.text = levelName ?? "easy"
    }

    @objc func playerPressed(recognizer: UILongPressGestureRecognizer) {
        if recognizer.state == .ended {
            if animationTimer != nil {
                animationTimer?.invalidate()
            }
        } else if recognizer.state == .began {
            let touchPoint = recognizer.location(in: view)
            if touchPoint.x > playerCarImageView.frame.midX {
                animationTimer = Timer.scheduledTimer(timeInterval: 0.005, target: self, selector: #selector(moveCar), userInfo: "right", repeats: true)
            } else {
                animationTimer = Timer.scheduledTimer(timeInterval: 0.005, target: self, selector: #selector(moveCar), userInfo: "left", repeats: true)
            }
        }
        collisionHandler()
    }

    @objc func moveCar(timer: Timer) {
        if let direction = timer.userInfo as? String {
            var playerCarFrame = playerCarImageView.frame

            if direction == "right" {
                if playerCarFrame.origin.x < rightGrassView.frame.minX - 70 {
                    playerCarFrame.origin.x += 2
                }
            } else {
                if playerCarFrame.origin.x > leftGrassView.frame.maxX {
                    playerCarFrame.origin.x -= 2
                }
            }
            playerCarImageView.frame = playerCarFrame
        }
    }

    private func collisionHandler() {
        if playerCarImageView.layer.frame.intersects(policeCarImageView.layer.frame) || playerCarImageView.layer.frame.intersects(firstObstacle.layer.frame)
            || playerCarImageView.layer.frame.intersects(secondObstacle.layer.frame) {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    private func animateObstacle(obstacle: UIImageView) {
        obstacle.frame = CGRect(x: obstacle.frame.origin.x, y: obstacle.frame.origin.y + 10, width: obstacle.frame.width, height: obstacle.frame.height)
        if obstacle.frame.origin.y >= self.view.bounds.maxY {
            obstacle.frame.origin.y = 0
        }
    }

    private func animatePoliceCar(car: UIImageView) {
        let randomPoliceX = CGFloat.random(in: view.frame.minX + 100...view.frame.maxX - 100)
        car.frame = CGRect(x: car.frame.origin.x, y: car.frame.origin.y + 12, width: car.frame.width, height: car.frame.height)
        if car.frame.origin.y >= self.view.bounds.maxY {
            car.frame.origin.y = 0
            car.frame.origin.x = randomPoliceX
        }
    }

    @objc func amimateEnemy() {
        animateObstacle(obstacle: firstObstacle)
        animateObstacle(obstacle: secondObstacle)
        animatePoliceCar(car: policeCarImageView)
    }

    @objc private func updateStartCountLabel() {
        if isEmpty > 0 {
            isEmpty -= 1
            startCountLabel.text = String(isEmpty)
        } else {
            startCountLabel.text = ""
        }
    }
}
