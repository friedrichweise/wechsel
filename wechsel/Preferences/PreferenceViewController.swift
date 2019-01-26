//
//  PreferenceViewController.swift
//  wechsel
//
//  Created by Friedrich Weise on 16.11.18.
//  Copyright © 2018 Friedrich Weise. All rights reserved.
//

import Cocoa
import MASShortcut
import LaunchAtLogin

class PreferenceViewController: NSViewController {
    @IBOutlet weak var shortcutView: MASShortcutView!
    @IBOutlet weak var openAtLoginCheckbox: NSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shortcutView.associatedUserDefaultsKey = Config.key
        openAtLoginCheckbox.state = LaunchAtLogin.isEnabled ? .on : .off
    }
    @IBAction func saveButtonClicked(_ sender: Any) {
        LaunchAtLogin.isEnabled = openAtLoginCheckbox.state == .on ? true : false
        if let window = self.view.window {
            window.close()
        }
    }
}
