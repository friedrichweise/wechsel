//
//  DeviceTableCellView.swift
//  wechsel
//
//  Created by Friedrich Weise on 21.11.18.
//  Copyright © 2018 Friedrich Weise. All rights reserved.
//

import Cocoa

class DeviceTableCellView: NSTableCellView {
    @IBOutlet weak var imgView: NSImageView!
    @IBOutlet weak var nameTextField: NSTextField!
    @IBOutlet weak var lastUsedTextField: NSTextField!    
    @IBOutlet weak var progressIndicator: NSProgressIndicator!

    func setConnectionState(connnected: Bool) {
        if connnected {
            self.imgView.image = NSImage.init(named: "statusEnabled")
        } else {
            self.imgView.image = NSImage.init(named: "statusDisabled")
        }
    }
    
    func indicateProgress() {
        self.imgView.isHidden = true
        self.progressIndicator.startAnimation(nil)
    }
    func indicateState() {
        self.progressIndicator.stopAnimation(nil)
        self.imgView.isHidden  = false
    }
}
