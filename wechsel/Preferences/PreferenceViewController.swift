//
//  PreferenceViewController.swift
//  wechsel
//
//  Created by Friedrich Weise on 16.11.18.
//  Copyright © 2018 Friedrich Weise. All rights reserved.
//

import Cocoa
import MASShortcut

class PreferenceViewController: NSViewController {
    @IBOutlet weak var shortcutView: MASShortcutView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shortcutView.associatedUserDefaultsKey = Config.key
    }
    @IBAction func saveButtonClicked(_ sender: Any) {
        if let window = self.view.window {
            window.close()
        }
    }

}
