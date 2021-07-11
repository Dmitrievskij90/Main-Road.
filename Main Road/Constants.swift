//
//  Constants.swift
//  Main Road
//
//  Created by Konstantin Dmitrievskiy on 06.06.2021.
//

import Foundation

enum Constants {
    // MARK: - Car image names
    // MARK: -
    static let yellowCar = "ic_yellowCar"
    static let redCar = "ic_redCar"
    static let silverCar = "ic_silverCar"
    static let policeCar = "ic_policeCar"
    static let mainCar = "ic_mainCar"

    // MARK: - Obstacle image names
    // MARK: -
    static let cone = "ic_cone"
    static let hole = "ic_hole"
    static let barrier = "ic_barrier"

    // MARK: - Motorcycle image names
    // MARK: -
    static let firstMotoArray = ["ic_firstMotorcycle", "ic_secondMotorcycle", "ic_thirdMotorcycle", "ic_fourthMotorcycle"]
    static let secondMotoArray = ["ic_fifthMotorcycle", "ic_sixthMotorcycle", "ic_seventhMotorcycle", "ic_eighthMotorcycle"]

    // MARK: - Level names
    // MARK: -
    static let easy = "easy_level_label_title".localize()
    static let medium = "medium_level_label_title".localize()
    static let hard = "hard_level_label_title".localize()

    // MARK: - Storyboard segue ID
    // MARK: -
    static let settingsID = "SettingsID"
    static let recordsID = "RecordsID"

    // MARK: - Welcome screen strings
    // MARK: -
    static let welcomeScreenTitle = "start_screen_title".localize()
    static let startButtonTitle = "start_screen_startButton_title".localize()
    static let recordsButtonTitle = "start_screen_recordsButton_title".localize()

    // MARK: - Settings screen strings
    // MARK: -
    static let selectButtonTitle = "settings_screen_selectButton_title".localize()
    static let userNameTextFieldPlaceholder = "settings_screen_userNameTextField_placeholder".localize()
    static let settingsScreenNavigationItemTitle = "settings_screen_navigationItem_title".localize()
    static let defaultUserName = "settings_screen_defaultUserName".localize()

    // MARK: - Records screen strings
    // MARK: -
    static let recordsScreenNavigationItemTitle = "records_screen_navigationItem_title".localize()

    // MARK: - Race screen strings
    // MARK: -
    static let raceScreenLevelLabelText = "level_label_title".localize()
    static let raceScreenPointsLabelText = "points_level_label_title".localize()

    static let backGroundSound = "background.mp3"
    static let boomSound = "bum.mp3"
}
