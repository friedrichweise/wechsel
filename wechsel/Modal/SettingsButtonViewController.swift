//
//  SettingsButtonViewController.swift
//  wechsel
//
//  Created by Friedrich Weise on 24.02.19.
//  Copyright © 2019 Friedrich Weise. All rights reserved.
//

import Foundation

class SettingsButtonViewController: NSTitlebarAccessoryViewController {
    var preferenceWindowController: PreferenceWindowController!

    @IBAction func saveButtonClicked(_ sender: Any) {
        // @todo: should use the instanciated Window from MainMenuController
        preferenceWindowController = PreferenceWindowController()
        preferenceWindowController.showWindow(nil)
    }
}
