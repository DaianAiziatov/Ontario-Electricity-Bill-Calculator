//
//  Extensions.swift
//  c0743383_OntarioElectricityBillCalculator
//
//  Created by Daian Aiziatov on 09/11/2018.
//  Copyright © 2018 Daian Aiziatov. All rights reserved.
//

import Foundation

extension Double {
    
    func Formatting() -> String {
        let format = NumberFormatter()
        format.currencyCode = "CAD"
        format.numberStyle = .currency
        if let formatValue = format.string(from: self as NSNumber) {
            return "\(formatValue)"
        } else {
            return "\(self)"
        }
    }
    
}
