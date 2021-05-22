//
//  RecordsViewController.swift
//  Main Road
//
//  Created by Konstantin Dmitrievskiy on 15.05.2021.
//

import UIKit

class RecordsViewController: UIViewController {
    private var gameRecords = [Records]()
    @IBOutlet weak var recordsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .init(hex:0xfaf2da)
        recordsTableView.backgroundColor = .init(hex:0xfaf2da)
        recordsTableView.delegate = self
        recordsTableView.dataSource = self
        loadRecords()
        recordsTableView.register(UINib(nibName: "RecordTableViewCell", bundle: nil), forCellReuseIdentifier: "cellID")
    }
    
    private func loadRecords() {
        guard let folderPath = FileManager.getPathOfDirectory(named: "Records") else {
            return
        }

        if let results = try? FileManager.default.contentsOfDirectory(at: folderPath, includingPropertiesForKeys: [.nameKey], options: .includesDirectoriesPostOrder) {
            for result in results {
                guard let data = try? Data(contentsOf: result) else {
                    return
                }

                let decoder = JSONDecoder()
                if let raceResult = try? decoder.decode(Records.self, from: data ) {
                    gameRecords.append(raceResult)
                }
            }
        }
    }
}

extension RecordsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        gameRecords.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as? RecordTableViewCell else {
            return UITableViewCell()
        }

        let sortedRecords = gameRecords.sorted { $0.points > $1.points }
        
        cell.userNameLabel.text = sortedRecords[indexPath.row].userName
        cell.scoreLabel.text = "Score: \(sortedRecords[indexPath.row].points)"
        cell.dateLabel.text = sortedRecords[indexPath.row].gameDate
        cell.userCarImageView.image = UIImage(named: sortedRecords[indexPath.row].userCar) 
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
