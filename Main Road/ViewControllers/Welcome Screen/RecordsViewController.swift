//
//  RecordsViewController.swift
//  Main Road
//
//  Created by Konstantin Dmitrievskiy on 15.05.2021.
//

import UIKit

class RecordsViewController: UIViewController {
    private let fileManager = FileManager.default
    private let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Results")
    private var gameRecords = [Results]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadRecords()
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
                if let raceResult = try? decoder.decode(Results.self, from: data ) {
                    gameRecords.append(raceResult)
                }
            }
        }
    }
}
