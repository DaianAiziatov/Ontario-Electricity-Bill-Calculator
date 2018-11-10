//
//  ElectricityBill.swift
//  c0743383_OntarioElectricityBillCalculator
//
//  Created by Daian Aiziatov on 09/11/2018.
//  Copyright © 2018 Daian Aiziatov. All rights reserved.
//

import Foundation

class ElectricityBill {
    
    private static var instatnce: ElectricityBill? = nil
    
    private(set) var customerEmail: String?
    private(set) var accountNumber: String?
    private(set) var meterNumber: String?
    private(set) var monthlyUsage: Int?
    private(set) var pricePlan: PricePlan?
    private(set) var offPeak: Double?
    private(set) var midPeak: Double?
    private(set) var onPeak: Double?
    private(set) var OESPcredit: Double?
    private(set) var contractRate: Double?
    private(set) var totalElectricity: Double?
    private(set) var totalBillPrice: Double?
    
    enum PricePlan {
        case tired
        case timeOfUsage
    }
    
    private init(){
        
    }
    
    private init(customerEmail: String, accountNumber: String, meterNumber: String, monthlyUsage: Int, pricePlan: PricePlan, OESPcredit: Double?, contractRate: Double?) {
        self.customerEmail = customerEmail
        self.accountNumber = accountNumber
        self.meterNumber = meterNumber
        self.monthlyUsage = monthlyUsage
        self.pricePlan = pricePlan
        self.OESPcredit = OESPcredit
        self.contractRate = contractRate
        self.totalElectricity = self.totalElectricityCalculation()
        self.totalBillPrice = totalBillCalculation()
    }
    
    private init(customerEmail: String, accountNumber: String, meterNumber: String, monthlyUsage: Int, pricePlan: PricePlan, offPeak: Double, midPeak: Double, onPeak: Double, OESPcredit: Double?) {
        self.customerEmail = customerEmail
        self.accountNumber = accountNumber
        self.meterNumber = meterNumber
        self.monthlyUsage = monthlyUsage
        self.pricePlan = pricePlan
        self.offPeak = offPeak
        self.midPeak = midPeak
        self.onPeak = onPeak
        self.OESPcredit = OESPcredit
        self.totalElectricity = self.totalElectricityCalculation()
        self.totalBillPrice = self.totalBillCalculation()
        
    }
    
    private func totalElectricityCalculation() -> Double {
        var total: Double
        let delivery: Double
        let regulatory: Double
        if self.pricePlan == PricePlan.tired {
            let globalAdjustment: Double
            if self.contractRate != nil {
                total = self.contractRate! * Double(self.monthlyUsage!)
            } else {
                if monthlyUsage! > 600 {
                    total = 7.7 * Double(self.monthlyUsage!)
                    let difference = Int(self.monthlyUsage!) - 600
                    total += 8.9 * Double(difference)
                } else {
                    total = 7.7 * Double(self.monthlyUsage!)
                }
            }
            globalAdjustment = total * 0.2
            delivery = total * 0.3
            regulatory = total * 0.032
            total = total + globalAdjustment + delivery + regulatory
            return total/100.0
        } else {
            let offPeakPrice = Double(self.monthlyUsage!) * (self.offPeak! / 100.0) * 6.5
            let onPeakPrice = Double(self.monthlyUsage!) * (self.offPeak! / 100.0) * 13.2
            let midPeakPrice = Double(self.monthlyUsage!) * (self.offPeak! / 100.0) * 9.4
            total = offPeakPrice + onPeakPrice + midPeakPrice
            delivery = total * 0.3
            regulatory = total * 0.032
            total = total + delivery + regulatory
            return total/100.0
        }
    }
    
    private func totalBillCalculation() -> Double {
        var total = totalElectricityCalculation()
        let hst = total * 0.13
        if self.OESPcredit != nil {
            total = total + hst - OESPcredit!
            return total/100.0
        } else {
            total = total + hst
            return total/100.0
        }
    }
    
    static func setInstatnceAsTimeOfUse(customerEmail: String, accountNumber: String, meterNumber: String, monthlyUsage: Int, offPeak: Double, midPeak: Double, onPeak: Double, OESPcredit: Double?) {
        
        instatnce = ElectricityBill(customerEmail: customerEmail, accountNumber: accountNumber, meterNumber: meterNumber, monthlyUsage: monthlyUsage, pricePlan: ElectricityBill.PricePlan.timeOfUsage, offPeak: offPeak, midPeak: midPeak, onPeak: onPeak, OESPcredit: OESPcredit)
    }
    
    static func setInstatnceAsTired(customerEmail: String, accountNumber: String, meterNumber: String, monthlyUsage: Int, OESPcredit: Double?, contractRate: Double?) {
        instatnce = ElectricityBill(customerEmail: customerEmail, accountNumber: accountNumber, meterNumber: meterNumber, monthlyUsage: monthlyUsage, pricePlan: ElectricityBill.PricePlan.tired, OESPcredit: OESPcredit, contractRate: contractRate)
    }
    
    static func getInstatnce() -> ElectricityBill? {
        return instatnce
    }
}
