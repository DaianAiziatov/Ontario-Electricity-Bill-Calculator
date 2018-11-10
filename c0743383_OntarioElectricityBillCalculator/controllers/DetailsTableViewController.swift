//
//  DetailsTableViewController.swift
//  c0743383_OntarioElectricityBillCalculator
//
//  Created by Daian Aiziatov on 09/11/2018.
//  Copyright © 2018 Daian Aiziatov. All rights reserved.
//

import UIKit

class DetailsTableViewController: UITableViewController {
    
    @IBOutlet weak var accountNumberLabel: UILabel!
    @IBOutlet weak var meterNumberLabel: UILabel!
    @IBOutlet weak var electricityTitle1Label: UILabel!
    @IBOutlet weak var electricity1DetailLabel: UILabel!
    @IBOutlet weak var electricityTitle2Label: UILabel!
    @IBOutlet weak var electricity2DetailsLabel: UILabel!
    @IBOutlet weak var electricityTitle3Label: UILabel!
    @IBOutlet weak var electricity3DetailsLabel: UILabel!
    @IBOutlet weak var deliveryPriceLabel: UILabel!
    @IBOutlet weak var regulatoryChargeLabel: UILabel!
    @IBOutlet weak var totalElectricityLabel: UILabel!
    @IBOutlet weak var hstLabel: UILabel!
    @IBOutlet weak var rebateLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let electricityBill = ElectricityBill.getInstatnce()
        accountNumberLabel.text = "Account Number: \(electricityBill!.accountNumber ?? "")"
        meterNumberLabel.text = "Meter Number: \(electricityBill!.meterNumber ?? "")"
        let totalMonthlyUsage: Double
        if electricityBill?.pricePlan == ElectricityBill.PricePlan.tired {
            electricityTitle1Label.text = ""
            electricity1DetailLabel.text = ""
            if electricityBill?.contractRate != nil {
                electricityTitle2Label.text = "\(electricityBill!.monthlyUsage ?? 0) @ \(electricityBill!.contractRate ?? 0.0) c/kWh"
                totalMonthlyUsage = (Double(electricityBill!.monthlyUsage!) * electricityBill!.contractRate!)/100.0
            } else {
                if electricityBill!.monthlyUsage! > 600 {
                    electricityTitle2Label.text = "\(electricityBill!.monthlyUsage ?? 0) @ 8.9 c/kWh"
                    totalMonthlyUsage = (Double(electricityBill!.monthlyUsage!) * 8.9)/100.0
                } else {
                    electricityTitle2Label.text = "\(electricityBill!.monthlyUsage ?? 0) @ 7.7 c/kWh"
                    totalMonthlyUsage = (Double(electricityBill!.monthlyUsage!) * 7.7)/100.0
                }
            }
            electricity2DetailsLabel.text = "\(totalMonthlyUsage.Formatting())"
            electricityTitle3Label.text = "Global Adjustment"
            electricity3DetailsLabel.text = "\((totalMonthlyUsage * 0.2).Formatting())"
            
        } else {
            electricityTitle1Label.text = "Off-Peak @ 6.5 c/kWh"
            let offPeak = ((Double(electricityBill!.monthlyUsage!) * (electricityBill!.offPeak!/100.0) * 6.5)/100)
            electricity1DetailLabel.text = "\(offPeak.Formatting())"
            electricityTitle2Label.text = "Mid-Peak @ 9.4 c/kWh"
            let midPeak = ((Double(electricityBill!.monthlyUsage!) * (electricityBill!.midPeak!/100.0) * 9.4)/100)
            electricity2DetailsLabel.text = "\(midPeak.Formatting())"
            electricityTitle3Label.text = "On-Peak @ 13.2 c/kWh"
            let onPeak = ((Double(electricityBill!.monthlyUsage!) * (electricityBill!.onPeak!/100.0) * 13.2)/100)
            electricity3DetailsLabel.text = "\(onPeak.Formatting())"
            totalMonthlyUsage = onPeak + offPeak + midPeak
        }
        deliveryPriceLabel.text = "\((totalMonthlyUsage * 0.3).Formatting())"
        regulatoryChargeLabel.text = "\((totalMonthlyUsage * 0.032).Formatting())"
        totalElectricityLabel.text = "\((electricityBill?.totalElectricity ?? 0.0).Formatting())"
        hstLabel.text = "\((electricityBill!.totalElectricity! * 0.13).Formatting())"
        rebateLabel.text = "\((electricityBill?.OESPcredit ?? 0.0).Formatting())"
        totalLabel.text = "\((electricityBill?.totalElectricity ?? 0.0).Formatting())"
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12
    }

    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.cellForRow(at: indexPath)
//        if indexPath.row == 0 {
//            let userDefault = UserDefaults.standard
//            cell!.textLabel?.text = "Account Number: \(userDefault.string(forKey: "accountNumber") ?? "")"
//            cell!.detailTextLabel?.text = "Meter Number: \(userDefault.string(forKey: "meterNumber") ?? "")"
//            return cell!
//        } else if indexPath.row == 1 {
//            return cell!
//        } else if indexPath.row == 2 {
//            return cell!
//        } else if indexPath.row == 3 {
//            return cell!
//        } else if indexPath.row == 4 {
//            return cell!
//        } else if indexPath.row == 5 {
//            return cell!
//        } else if indexPath.row == 6 {
//            return cell!
//        } else if indexPath.row == 7 {
//            return cell!
//        } else if indexPath.row == 8 {
//            return cell!
//        } else if indexPath.row == 9 {
//            return cell!
//        } else if indexPath.row == 10 {
//            return cell!
//        } else if indexPath.row == 11 {
//            return cell!
//        } else {
//            return cell!
//        }
//    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
