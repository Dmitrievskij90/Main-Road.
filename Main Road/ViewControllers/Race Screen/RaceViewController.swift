//
//  RaceViewController.swift
//  Main Road
//
//  Created by Konstantin Dmitrievskiy on 06.05.2021.
//

import UIKit

class RaceViewController: UIViewController {
    var user = UIImageView()
    var firstObstacle = UIImageView()
    var secondObstacle = UIImageView()

    private var soundManager = SoundManager()
    private var isPlaying = true
    private var policeCar = UIImageView()
    private var firstMoto = UIImageView()
    private var secondMoto = UIImageView()
    private var points = 0
    private var counter = 5
    private var animationTimer: Timer?
    private var updateTimer: Timer?
    private let level = UserDefaults.standard.value(forKey: "gameLavel") as? Double
    private var userName = UserDefaults.standard.value(forKey: "userName") as? String
    private var gameResult = [Records]()
    private var collisionTimer = Timer()
    private lazy var dateFormatter = DateFormatter()

    @IBOutlet weak var leftGrassView: UIView!
    @IBOutlet weak var rightGrassView: UIView!
    @IBOutlet weak var startCountLabel: UILabel!
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var levelMark: UILabel!
    @IBOutlet weak var pointsMark: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createObjects()
        setupUI()
        startCountdown()
        animateGame()
        movePlayerCarWithLongPress()
        collisionHandler()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        saveRecords()
    }

    // MARK: - setup user interface methods
    // MARK: -
    private func createObjects() {
        let randomX = CGFloat.random(in: view.frame.minX + 100...view.frame.maxX - 100)

        firstObstacle.frame = CGRect(x: leftGrassView.frame.maxX, y: view.frame.midY - 250, width: 20, height: 45)
        firstObstacle.setImageShadowWithColor()
        view.addSubview(firstObstacle)

        secondObstacle.frame = CGRect(x: rightGrassView.frame.minX - 40, y: view.frame.midY + 200, width: 20, height: 45)
        secondObstacle.setImageShadowWithColor()
        view.addSubview(secondObstacle)

        policeCar.frame = CGRect(x: randomX, y: view.frame.minY - 150, width: 45, height: 100)
        policeCar.setImageShadowWithColor()
        view.addSubview(policeCar)

        firstMoto.frame = CGRect(x: randomX, y: view.frame.minY - 300, width: 35, height: 100)
        firstMoto.setImageShadowWithColor()
        view.addSubview(firstMoto)

        secondMoto.frame = CGRect(x: randomX, y: view.frame.midY - 100, width: 35, height: 100)
        secondMoto.setImageShadowWithColor()
        view.addSubview(secondMoto)

        user = UIImageView(image: UIImage(named: Constants.yellowCar))
        user.frame = CGRect(x: 0, y: 0, width: 50, height: 110)
        user.frame.origin.y = view.bounds.height - user.frame.size.height - 60
        user.center.x = CGFloat(self.view.bounds.midX)
        user.setImageShadowWithColor()
        view.addSubview(user)
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

        firstObstacle.image = UIImage(named: Constants.hole)
        firstObstacle.contentMode = .scaleAspectFill

        secondObstacle.image = UIImage(named: Constants.hole)
        secondObstacle.contentMode = .scaleAspectFill

        let levelName = UserDefaults.standard.value(forKey: "levelName") as? String
        levelLabel.text = levelName ?? Constants.easy

        pointsMark.text = Constants.raceScreenPointsLabelText
        levelMark.text = Constants.raceScreenLevelLabelText

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

    // MARK: - move player's car methods
    // MARK: -
    private func movePlayerCarWithLongPress() {
        let carMoveGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(playerPressed))
        carMoveGestureRecognizer.minimumPressDuration = 0.001
        view.addGestureRecognizer(carMoveGestureRecognizer)
    }

    @objc func playerPressed(recognizer: UILongPressGestureRecognizer) {
        if recognizer.state == .ended {
            if animationTimer != nil {
                animationTimer?.invalidate()
            }
        } else if recognizer.state == .began {
            let touchPoint = recognizer.location(in: view)
            if touchPoint.x > user.frame.midX {
                animationTimer = Timer.scheduledTimer(timeInterval: 0.005, target: self, selector: #selector(moveCar), userInfo: "right", repeats: true)
            } else {
                animationTimer = Timer.scheduledTimer(timeInterval: 0.005, target: self, selector: #selector(moveCar), userInfo: "left", repeats: true)
            }
        }
        collisionHandler()
    }

    @objc func moveCar(timer: Timer) {
        if isPlaying {
        if let direction = timer.userInfo as? String {
            var playerCarFrame = user.frame

            if direction == "right" {
                if playerCarFrame.origin.x < rightGrassView.frame.minX - 50 {
                    playerCarFrame.origin.x += 2
                }
            } else {
                if playerCarFrame.origin.x > leftGrassView.frame.maxX {
                    playerCarFrame.origin.x -= 2
                }
            }
            user.frame = playerCarFrame
        }
        }
    }

    // MARK: - collision handling method
    // MARK: -
    private func collisionHandler() {
        collisionTimer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: false, block: { _ in
            if self.user.frame.intersects(self.policeCar.frame) || self.user.frame.intersects(self.firstObstacle.frame)
                || self.user.frame.intersects(self.secondObstacle.frame) || self.user.frame.intersects(self.firstMoto.frame) || self.user.frame.intersects(self.secondMoto.frame) {
                self.isPlaying = false
                self.gameOver()
                self.collisionTimer.invalidate()
                self.showGameOverAlert()
            }
        })
    }

    private func gameOver() {
        self.soundManager.playSound(fileName: Constants.explosionSound)
        self.soundManager.stopLoopingSound(fileName: Constants.backGroundSound)

        self.policeCar.removeFromSuperview()
        self.firstMoto.removeFromSuperview()
        self.secondMoto.removeFromSuperview()
        self.firstObstacle.removeFromSuperview()
        self.secondObstacle.removeFromSuperview()

        UIView.animate(withDuration: 1) {
            self.user.image = UIImage(named: "ic_crash")
            self.user.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
            self.user.frame.origin.y = self.view.bounds.height - self.user.frame.size.height - 60
            self.user.center.x = CGFloat(self.view.bounds.midX)
            self.user.contentMode = .scaleAspectFit
        }
    }

    private func showGameOverAlert() {
        let alert = UIAlertController(title: "Game over", message: "You crashed your car", preferredStyle: .alert)
        let action = UIAlertAction(title: "Try again", style: .cancel) { _ in
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

    // MARK: - animation methods
    // MARK: -
    private func animateGame() {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5), execute: {
            let timer = Timer.scheduledTimer(timeInterval: self.level ?? 0.04, target: self, selector: #selector(self.amimateEnemy), userInfo: nil, repeats: true)
            timer.fire()
            self.soundManager.startLoopingSound(fileName: Constants.backGroundSound, volume: 0.1)
        })
    }

    @objc func amimateEnemy() {
        if isPlaying {
        animateObstacle(firstObstacle)
        animateObstacle(secondObstacle)
        animatePoliceCar(policeCar)
        animateFirstMotorcycle(firstMoto)
        animateSecondMotorcycle(secondMoto)
        collisionHandler()
        }
    }

    private func animateObstacle(_ obstacle: UIImageView) {
        obstacle.frame = CGRect(x: obstacle.frame.origin.x, y: obstacle.frame.origin.y + 11, width: obstacle.frame.width, height: obstacle.frame.height)
        if obstacle.frame.origin.y >= self.view.bounds.maxY {
            obstacle.frame.origin.y = 0
        }
    }

    private func animatePoliceCar(_ car: UIImageView) {
        let randomPoliceX = CGFloat.random(in: view.frame.minX + 100...view.frame.maxX - 100)
        car.frame = CGRect(x: car.frame.origin.x, y: car.frame.origin.y + 10, width: car.frame.width, height: car.frame.height)
        if car.frame.origin.y >= self.view.bounds.maxY {
            car.frame.origin.y = 0
            car.frame.origin.x = randomPoliceX
            points += 1
            pointsLabel.text = "\(points)"
        }
    }

    private func animateFirstMotorcycle(_ moto: UIImageView) {
        guard let imageName = Constants.firstMotoArray.randomElement() else {
            assert(true, "Can't find image name")
            return
        }

        let randomPoliceX = CGFloat.random(in: view.frame.minX + 100...view.frame.maxX - 100)
        moto.frame = CGRect(x: moto.frame.origin.x, y: moto.frame.origin.y + 9.8, width: moto.frame.width, height: moto.frame.height)
        if moto.frame.origin.y >= self.view.bounds.maxY {
            moto.frame.origin.y = 0
            moto.frame.origin.x = randomPoliceX
            firstMoto.image = UIImage(named: imageName)
            points += 1
            pointsLabel.text = "\(points)"
        }
    }

    private func animateSecondMotorcycle(_ moto: UIImageView) {
        guard let imageName = Constants.secondMotoArray.randomElement() else {
            assert(true, "Can't find image name")
            return
        }
        let randomPoliceX = CGFloat.random(in: view.frame.minX + 100...view.frame.maxX - 100)
        moto.frame = CGRect(x: moto.frame.origin.x, y: moto.frame.origin.y + 9.9, width: moto.frame.width, height: moto.frame.height)
        if moto.frame.origin.y >= self.view.bounds.maxY {
            moto.frame.origin.y = 0
            moto.frame.origin.x = randomPoliceX
            secondMoto.image = UIImage(named: imageName)
            points += 1
            pointsLabel.text = "\(points)"
        }
    }

    // MARK: - countdown methods
    // MARK: -
    private func startCountdown() {
        Timer.scheduledTimer(timeInterval: 0.8, target: self, selector: #selector(updateStartCountLabel), userInfo: nil, repeats: true)
    }

    @objc private func updateStartCountLabel() {
        if counter > 0 {
            counter -= 1
            startCountLabel.text = String(counter)
        } else {
            startCountLabel.text = ""
        }
    }

    // MARK: - save records methods
    // MARK: -
    private func saveRecords() {
        var folderPath = FileManager.getDocumentsDirectory()
        folderPath.appendPathComponent("Records")

        try? FileManager.default.createDirectory(at: folderPath, withIntermediateDirectories: false, attributes: nil)

        let fileName = getCurrentDate("yyyy MMM dd HH:mm:ss")

        let car = UserDefaults.standard.value(forKey: "userCar") as? String
        let date = getCurrentDate("dd.MM.yyyy")

        if let level = levelLabel.text {
            let results = Records(level: level, points: points, gameDate: date, userName: userName ?? Constants.defaultUserName, userCar: car ?? Constants.yellowCar)
            let data = try? JSONEncoder().encode(results)
            let dataPath = folderPath.appendingPathComponent("\(fileName).json")
            FileManager.default.createFile(atPath: dataPath.path, contents: data, attributes: nil)
        }
    }

    private func getCurrentDate(_ dateFormat: String) -> String {
        dateFormatter.dateFormat = dateFormat
        let dataString = dateFormatter.string(from: Date())
        return dataString
    }
}
