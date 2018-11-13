//
//  WindowController.swift
//  Connect
//
//  Created by Friedrich Weise on 13.11.18.
//  Copyright © 2018 Friedrich Weise. All rights reserved.
//

import Cocoa

class WindowController: NSWindowController {

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        shouldCascadeWindows = true
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
        guard let window = window else { return }
        
        window.makeKey()
    }

}
