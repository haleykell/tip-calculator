//
//  ViewController.swift
//  tip
//
//  Created by Haley Kell on 8/6/20.
//  Copyright © 2020 Codepath. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let isDarkOn = UserDefaults.standard.bool(forKey: "dark_mode")
        
        overrideUserInterfaceStyle = isDarkOn ? .dark : .light
    }
    
    
}

