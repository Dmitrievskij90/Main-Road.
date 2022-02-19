//
//  String+extension.swift
//  Main Road
//
//  Created by Konstantin Dmitrievskiy on 09.06.2021.
//

import Foundation

extension String {
    func localize() -> String {
        return NSLocalizedString(self, comment: "")
    }
}
