//
//  RecordsViewController.swift
//  Main Road
//
//  Created by Konstantin Dmitrievskiy on 15.05.2021.
//

import UIKit

class RecordsViewController: UIViewController {
    private let fileManager = FileManager.default
    private let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Records")
    private var gameRecords = [Records]()

    @IBOutlet weak var recordsTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        recordsTableView.delegate = self
        recordsTableView.dataSource = self
        loadRecords()
        recordsTableView.register(UINib(nibName: "RecordTableViewCell", bundle: nil), forCellReuseIdentifier: "cellID")
    }

    private func loadRecords() {
        guard let path = documentsPath else {
            return
        }
        if let results = try? fileManager.contentsOfDirectory(at: path, includingPropertiesForKeys: [.nameKey], options: .includesDirectoriesPostOrder) {
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

        //        let sotedResults = gameRecords.sorted {$0.gameDate > $1.gameDate}
        //        cell.levelLabel.text = "Level: \(sotedResults[indexPath.row].level)"
        //        cell.scoreLabel.text = "Score: \(sotedResults[indexPath.row].points)"
        //        cell.dateLabel.text = sotedResults[indexPath.row].gameDate

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    @objc func showDateOfRace(_ date: String) {
        presentOneButtonAlert(withTitle: "Date of Race", message: "")
    }
}
