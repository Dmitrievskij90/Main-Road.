//
//  RaceViewController.swift
//  Main Road
//
//  Created by Konstantin Dmitrievskiy on 06.05.2021.
//

import UIKit

class RaceViewController: UIViewController {
    var player = UIImageView()
    var firstObstacle = UIImageView()
    var secondObstacle = UIImageView()
    private var policeCar = UIImageView()
    private var firstMoto = UIImageView()
    private var secondMoto = UIImageView()
    private var points = 0
    private var isEmpty = 5
    private var animationTimer: Timer?
    private var updateTimer: Timer?
    private let level = UserDefaults.standard.value(forKey: "gameLavel") as? Double
    private var userName = UserDefaults.standard.value(forKey: "userName") as? String
    private var gameResult = [Records]()
    private var collisionTimer = Timer()

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
        createMoto()
        createPlayerCar()
        setupUI()

        collisionHandler()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        saveResult()
    }

    private func createPlayerCar() {
        player = UIImageView(image: UIImage(named: "ic_yellowCar"))
        player.frame = CGRect(x: 0, y: 0, width: 50, height: 110)
        player.frame.origin.y = view.bounds.height - player.frame.size.height - 60
        player.center.x = CGFloat(self.view.bounds.midX)
        view.addSubview(player)
    }

    private func createObstacles() {
        firstObstacle.frame = CGRect(x: view.frame.midX - 140, y: view.frame.midY - 250, width: 20, height: 45)
        view.addSubview(firstObstacle)

        secondObstacle.frame = CGRect(x: view.frame.midX + 115, y: view.frame.midY + 250, width: 20, height: 45)
        view.addSubview(secondObstacle)
    }

    private func createPoliceCar() {
        let randomPoliceX = CGFloat.random(in: view.frame.minX + 100...view.frame.maxX - 100)
        policeCar.frame = CGRect(x: randomPoliceX, y: -150, width: 50, height: 110)
        view.addSubview(policeCar)
    }

    private func createMoto() {
        let randomPoliceX = CGFloat.random(in: view.frame.minX + 100...view.frame.maxX - 100)
        firstMoto.frame = CGRect(x: randomPoliceX, y: view.frame.maxY, width: 40, height: 110)
        view.addSubview(firstMoto)

        secondMoto.frame = CGRect(x: randomPoliceX, y: -500, width: 40, height: 110)
        view.addSubview(secondMoto)
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

        policeCar.image = UIImage(named: Constants.policeCar)
        policeCar.contentMode = .scaleAspectFill

        firstMoto.image = UIImage(named: Constants.firstMotoArray[0])
        firstMoto.contentMode = .scaleAspectFill

        secondMoto.image = UIImage(named: Constants.secondMotoArray[3])
        secondMoto.contentMode = .scaleAspectFill

        firstObstacle.image = UIImage(named: "ic_hole")
        firstObstacle.contentMode = .scaleAspectFill

        secondObstacle.image = UIImage(named: "ic_hole")
        secondObstacle.contentMode = .scaleAspectFill

        let levelName = UserDefaults.standard.value(forKey: "levelName") as? String
        levelLabel.text = levelName ?? "easy"

        setupLabel(label: levelLabel)
        setupLabel(label: pointsLabel)
        setupLabel(label: levelMark)
        setupLabel(label: pointsMark)
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
        view.addSubview(pointsLabel)
        view.addSubview(pointsMark)
        view.addSubview(levelLabel)
        view.addSubview(levelMark)
    }

    @objc func playerPressed(recognizer: UILongPressGestureRecognizer) {
        if recognizer.state == .ended {
            if animationTimer != nil {
                animationTimer?.invalidate()
            }
        } else if recognizer.state == .began {
            let touchPoint = recognizer.location(in: view)
            if touchPoint.x > player.frame.midX {
                animationTimer = Timer.scheduledTimer(timeInterval: 0.005, target: self, selector: #selector(moveCar), userInfo: "right", repeats: true)
            } else {
                animationTimer = Timer.scheduledTimer(timeInterval: 0.005, target: self, selector: #selector(moveCar), userInfo: "left", repeats: true)
            }
        }
        collisionHandler()
    }

    @objc func moveCar(timer: Timer) {
        if let direction = timer.userInfo as? String {
            var playerCarFrame = player.frame

            if direction == "right" {
                if playerCarFrame.origin.x < rightGrassView.frame.minX - 70 {
                    playerCarFrame.origin.x += 2
                }
            } else {
                if playerCarFrame.origin.x > leftGrassView.frame.maxX {
                    playerCarFrame.origin.x -= 2
                }
            }
            player.frame = playerCarFrame
        }
    }

    private func collisionHandler() {
        collisionTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { _ in
            if self.player.frame.intersects(self.policeCar.frame) || self.player.frame.intersects(self.firstObstacle.frame)
                || self.player.frame.intersects(self.secondObstacle.frame) || self.player.frame.intersects(self.firstMoto.frame) || self.player.frame.intersects(self.secondMoto.frame) {
                self.collisionTimer.invalidate()
                self.dismiss(animated: true, completion: nil)
            }
        })
    }

    private func animateObstacle(obstacle: UIImageView) {
        obstacle.frame = CGRect(x: obstacle.frame.origin.x, y: obstacle.frame.origin.y + 11, width: obstacle.frame.width, height: obstacle.frame.height)
        if obstacle.frame.origin.y >= self.view.bounds.maxY {
            obstacle.frame.origin.y = 0
        }
    }

    private func animatePoliceCar(car: UIImageView) {
        let randomPoliceX = CGFloat.random(in: view.frame.minX + 100...view.frame.maxX - 100)
        car.frame = CGRect(x: car.frame.origin.x, y: car.frame.origin.y + 10, width: car.frame.width, height: car.frame.height)
        if car.frame.origin.y >= self.view.bounds.maxY {
            car.frame.origin.y = 0
            car.frame.origin.x = randomPoliceX
            points += 1
            pointsLabel.text = "\(points)"
        }
    }

    private func animateFirstMotorcycle(car: UIImageView) {
        guard let imageName = Constants.firstMotoArray.randomElement() else {
            assert(true, "Can't find image name")
            return
        }

        let randomPoliceX = CGFloat.random(in: view.frame.minX + 100...view.frame.maxX - 100)
        car.frame = CGRect(x: car.frame.origin.x, y: car.frame.origin.y + 9, width: car.frame.width, height: car.frame.height)
        if car.frame.origin.y >= self.view.bounds.maxY {
            car.frame.origin.y = 0
            car.frame.origin.x = randomPoliceX
            firstMoto.image = UIImage(named: imageName)
            points += 1
            pointsLabel.text = "\(points)"
        }
    }

    private func animateSecondMotorcycle(car: UIImageView) {
        guard let imageName = Constants.secondMotoArray.randomElement() else {
            assert(true, "Can't find image name")
            return
        }
        let randomPoliceX = CGFloat.random(in: view.frame.minX + 100...view.frame.maxX - 100)
        car.frame = CGRect(x: car.frame.origin.x, y: car.frame.origin.y + 12, width: car.frame.width, height: car.frame.height)
        if car.frame.origin.y >= self.view.bounds.maxY {
            car.frame.origin.y = 0
            car.frame.origin.x = randomPoliceX
            secondMoto.image = UIImage(named: imageName)
            points += 1
            pointsLabel.text = "\(points)"
        }
    }

    @objc func amimateEnemy() {
            animateObstacle(obstacle: firstObstacle)
            animateObstacle(obstacle: secondObstacle)
            animatePoliceCar(car: policeCar)
            animateFirstMotorcycle(car: firstMoto)
            animateSecondMotorcycle(car: secondMoto)
    }

    @objc private func updateStartCountLabel() {
        if isEmpty > 0 {
            isEmpty -= 1
            startCountLabel.text = String(isEmpty)
        } else {
            startCountLabel.text = ""
        }
    }

    private func saveResult() {
        var folderPath = FileManager.getDocumentsDirectory()
        folderPath.appendPathComponent("Records")

        try? FileManager.default.createDirectory(at: folderPath, withIntermediateDirectories: false, attributes: nil)

        let fileName = getCurrentDate("yyyy MMM dd HH:mm:ss")

        let car = UserDefaults.standard.value(forKey: "userCar") as? String

        if let level = levelLabel.text {
            let results = Records(level: level, points: points, gameDate: getCurrentDate("dd.MM.yyyy"), userName: userName ?? "User", userCar: car ?? "ic_yellowCar")
            let data = try? JSONEncoder().encode(results)
            let dataPath = folderPath.appendingPathComponent("\(fileName).json")
            FileManager.default.createFile(atPath: dataPath.path, contents: data, attributes: nil)
        }
    }

    private func getCurrentDate(_ dateFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        let dataString = dateFormatter.string(from: Date())
        return dataString
    }
}
