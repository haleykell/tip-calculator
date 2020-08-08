//
//  TipViewController.swift
//  tip
//
//  Created by Haley Kell on 8/6/20.
//  Copyright © 2020 Codepath. All rights reserved.
//

import UIKit

class TipViewController: BaseViewController {

    @IBOutlet weak var billAmountTextField: UITextField!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var tipPercentageLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var peopleLabel: UILabel!
    @IBOutlet weak var numberStepper: UIStepper!
    @IBOutlet weak var perPersonTotal: UILabel!
    
    var currencySymbols: [String] = []
    let tipPercentages = [0.15, 0.18, 0.2, 0.25]
    var defaultTip: Int = 0
    var defaultCurrency: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        currencySymbols = ["$", "€", "£", "$"]
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        
        defaultTip = UserDefaults.standard.integer(forKey: "default_tip")
        tipControl.selectedSegmentIndex = defaultTip
        defaultCurrency = UserDefaults.standard.integer(forKey: "default_currency")
        guard let lastOpened = UserDefaults.standard.object(forKey: "LastOpened") as? Date else {
            return
        }
        let elapsed = Calendar.current.dateComponents([.minute], from: lastOpened, to: Date())
        if elapsed.minute! < 10 {
            if (UserDefaults.standard.string(forKey: "billAmount") != nil && UserDefaults.standard.string(forKey: "billAmount") != "") {
                billAmountTextField.text = UserDefaults.standard.string(forKey: "billAmount")
            }
        }
        else {
            billAmountTextField.text = ""
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let isDarkOn = UserDefaults.standard.bool(forKey: "dark_mode")
        overrideUserInterfaceStyle = isDarkOn ? .dark : .light
        defaultCurrency = UserDefaults.standard.integer(forKey: "default_currency")
        calculateTotals()
    }
    
    @IBAction func onTap(_ sender: Any) {
    }
    
    @IBAction func calculateTip(_ sender: Any) {
        calculateTotals()
    }
    
    @IBAction func changePeople(_ sender: Any) {
        peopleLabel.text = String(format: "%.0f", numberStepper.value)
        
        calculateTotals()
    }
    
    @IBAction func billAmountChanged(_ sender: Any) {
        calculateTotals()
        UserDefaults.standard.set(billAmountTextField.text, forKey: "billAmount")
    }
    
    func calculateTotals() {
        let bill = Double(billAmountTextField.text!) ?? 0
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
        let total = bill + tip
        
        tipPercentageLabel.text = String(format: "%@%.2f", currencySymbols[defaultCurrency], tip)
        totalLabel.text = String(format: "%@%.2f", currencySymbols[defaultCurrency], total)
        perPersonTotal.text = String(format: "%@%.2f", currencySymbols[defaultCurrency], total / numberStepper.value)
    }
}

