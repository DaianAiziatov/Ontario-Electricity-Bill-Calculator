//
//  SplashViewController.swift
//  c0743383_OntarioElectricityBillCalculator
//
//  Created by Daian Aiziatov on 09/11/2018.
//  Copyright © 2018 Daian Aiziatov. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(self.splashTimeOut(sender:)), userInfo: nil, repeats: false)
    }
    
    @objc func splashTimeOut(sender : Timer) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "startNavigationVC")
        (UIApplication.shared.delegate as! AppDelegate).window?.rootViewController = vc
    }

}
