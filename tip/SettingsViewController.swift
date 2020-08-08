//
//  SettingsViewController.swift
//  tip
//
//  Created by Haley Kell on 8/6/20.
//  Copyright © 2020 Codepath. All rights reserved.
//

import UIKit

class SettingsViewController: BaseViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var mode: UISwitch!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var currencyPicker: UIPickerView!
    var currencies: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.currencyPicker.delegate = self
        self.currencyPicker.dataSource = self
        
        currencies = ["USD", "Euro", "GBP", "CAD"]
        
        mode.isOn = UserDefaults.standard.bool(forKey: "dark_mode")
        tipControl.selectedSegmentIndex = UserDefaults.standard.integer(forKey: "default_tip")
        currencyPicker.selectRow(UserDefaults.standard.integer(forKey: "default_currency"), inComponent: 0, animated: false)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencies.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        UserDefaults.standard.set(row, forKey: "default_currency")
        return currencies[row]
    }
    
    @IBAction func toggleDarkMode(_ sender: Any) {
        UserDefaults.standard.set(mode.isOn, forKey: "dark_mode")
        overrideUserInterfaceStyle = mode.isOn ? .dark : .light
    }
    
    @IBAction func changeDefaultTip(_ sender: Any) {
        UserDefaults.standard.set(tipControl.selectedSegmentIndex, forKey: "default_tip")
    }
    
}
