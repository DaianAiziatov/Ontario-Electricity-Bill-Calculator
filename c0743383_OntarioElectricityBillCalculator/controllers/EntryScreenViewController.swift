//
//  EntryScreenViewController.swift
//  c0743383_OntarioElectricityBillCalculator
//
//  Created by Daian Aiziatov on 09/11/2018.
//  Copyright © 2018 Daian Aiziatov. All rights reserved.
//

import UIKit

class EntryScreenViewController: UIViewController {
    
    

    @IBOutlet weak var monthlyUsageTextField: UITextField!
    @IBOutlet weak var offPeakTextField: UITextField!
    @IBOutlet weak var midPeakTextField: UITextField!
    @IBOutlet weak var onPeakTextField: UITextField!
    @IBOutlet weak var OESPTextField: UITextField!
    @IBOutlet weak var retailContractTextField: UITextField!
    @IBOutlet weak var calculateButtonOutlet: UIButton!
    @IBOutlet weak var timeOfUseSwitch: UISwitch!
    @IBOutlet weak var tiredSwitch: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //rounded borders button
        //self.navigationItem.backBarButtonItem?.title = "Log Out"
        calculateButtonOutlet.layer.cornerRadius = 5
        calculateButtonOutlet.layer.borderWidth = 1
    }
    

    @IBAction func calculate(_ sender: UIButton) {
        if validation() {
            let userDefault = UserDefaults.standard
            let customerEmail = userDefault.string(forKey: "email")
            let accountNumber = userDefault.string(forKey: "accountNumber")
            let meterNumber = userDefault.string(forKey: "meterNumber")
            let monthlyUsage = Int(monthlyUsageTextField?.text ?? "0")
            let OESP = Double(OESPTextField?.text ?? "0.0")
            if tiredSwitch.isOn {
                if let conractRate = retailContractTextField.text {
                    let contactRateDouble = Double(conractRate)
                    ElectricityBill.setInstatnceAsTired(customerEmail: customerEmail!, accountNumber: accountNumber!, meterNumber: meterNumber!, monthlyUsage: monthlyUsage!, OESPcredit: OESP, contractRate: contactRateDouble)
                } else {
                    ElectricityBill.setInstatnceAsTired(customerEmail: customerEmail!, accountNumber: accountNumber!, meterNumber: meterNumber!, monthlyUsage: monthlyUsage!, OESPcredit: OESP, contractRate: nil)
                }
            } else {
                let offPeak = Double(offPeakTextField?.text ?? "0.0")
                let midPeak = Double(midPeakTextField?.text ?? "0.0")
                let onPeak = Double(onPeakTextField?.text ?? "0.0")
                ElectricityBill.setInstatnceAsTimeOfUse(customerEmail: customerEmail!, accountNumber: accountNumber!, meterNumber: meterNumber!, monthlyUsage: monthlyUsage!, offPeak: offPeak!, midPeak: midPeak!, onPeak: onPeak!, OESPcredit: OESP)
            }
            goToDetailsScreen()
        } else {
            let alert = UIAlertController(title: "Neccesary fields are empty or sum of time usage not equal 100", message: "Please try again", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(defaultAction)
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func timeOfUseAction(_ sender: UISwitch) {
        if tiredSwitch.isOn {
            tiredSwitch.setOn(false, animated: true)
            areTimeOfUseFields(enable: true)
        } else {
            tiredSwitch.setOn(true, animated: true)
            areTimeOfUseFields(enable: false)
        }
    }
    
    @IBAction func tieredAction(_ sender: UISwitch) {
        if timeOfUseSwitch.isOn {
            timeOfUseSwitch.setOn(false, animated: true)
            areTimeOfUseFields(enable: false)
        } else {
            timeOfUseSwitch.setOn(true, animated: true)
            areTimeOfUseFields(enable: true)
        }
    }
    
    private func validation() -> Bool {
        if tiredSwitch.isOn {
            return monthlyUsageTextField.hasText
        } else {
            let fieldsValid = offPeakTextField.hasText && onPeakTextField.hasText && midPeakTextField.hasText
            let off = Int(offPeakTextField.text ?? "0")
            let on = Int(midPeakTextField.text ?? "0")
            let mid = Int(onPeakTextField.text ?? "0")
            let sum = off! + on! + mid!
            return fieldsValid && (sum == 100)
        }
    }
    
    private func areTimeOfUseFields(enable : Bool) {
        if enable {
            offPeakTextField.isEnabled = true
            midPeakTextField.isEnabled = true
            onPeakTextField.isEnabled = true
            retailContractTextField.isEnabled = false
            retailContractTextField.text = ""
        } else {
            offPeakTextField.isEnabled = false
            offPeakTextField.text = ""
            midPeakTextField.isEnabled = false
            midPeakTextField.text = ""
            onPeakTextField.isEnabled = false
            onPeakTextField.text = ""
            retailContractTextField.isEnabled = true
        }
    }
    
    private func goToDetailsScreen() {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let detailsVC = sb.instantiateViewController(withIdentifier: "detailsVC")
        navigationController?.pushViewController(detailsVC, animated: true)
    }
    
}
