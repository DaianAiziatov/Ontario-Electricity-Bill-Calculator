//
//  User.swift
//  c0743383_OntarioElectricityBillCalculator
//
//  Created by Daian Aiziatov on 09/11/2018.
//  Copyright © 2018 Daian Aiziatov. All rights reserved.
//

import Foundation

struct User {
    
    static let allUsers = loadUsers();
    
    private(set) var email: String
    private(set) var password: String
    private(set) var accountNumber: String
    private(set) var meterNumber: String
    
    private init(email: String, password: String, accountNumber: String, meterNumber: String) {
        self.email = email
        self.password = password
        self.accountNumber = accountNumber
        self.meterNumber = meterNumber
    }
    
    //load users from plist
    private static func loadUsers() -> [User] {
        var users = [User]()
        if let path = Bundle.main.path(forResource: "Users", ofType: "plist") {
            let content = NSDictionary(contentsOfFile: path) as? [String: Any]
            //print(content)
            if let userInfoArray = content?["Users"] as? [AnyObject] {
                print("User List")
                for userInfo in userInfoArray {
                    if let userInfoDict = userInfo as? [String: AnyObject] {
                        let email = userInfoDict["email"] as? String ?? "No email"
                        let password = userInfoDict["password"] as? String ?? "No password"
                        let accountNumber = userInfoDict["accountNumber"] as? String ?? "No account number"
                        let meterNumber = userInfoDict["meterNumber"] as? String ?? "No meter number"
                        users.append(User(email: email, password: password, accountNumber: accountNumber, meterNumber: meterNumber))
                    }
                    
                }
            } else {
                print("Error while reading Userlist")
            }
            
        } else {
            print("Error while reading plist file")
        }
        
        return users
    }
    
}
