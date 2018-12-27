//
//  DeviceTableCellView.swift
//  wechsel
//
//  Created by Friedrich Weise on 29.11.18.
//  Copyright © 2018 Friedrich Weise. All rights reserved.
//

import Cocoa

class DeviceTableCellView: NSTableCellView {
    @IBOutlet weak var progressIndicator: NSProgressIndicator!
    @IBOutlet weak var imgView: NSImageView!
    @IBOutlet weak var nameTextField: NSTextField!
    @IBOutlet weak var lastUsedTextField: NSTextField!

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
    }
    
    func setConnectionState(connnected: Bool) {
        if connnected {
            self.imgView.image = NSImage.init(named: "statusEnabled")
        } else {
            self.imgView.image = NSImage.init(named: "statusInactive")
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
    func disabled() {
        self.alphaValue = 0.5
    }
    
    
}
