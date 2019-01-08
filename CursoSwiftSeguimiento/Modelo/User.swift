//
//  User.swift
//  CursoSwiftSeguimiento
//
//  Created by usuario on 1/7/19.
//  Copyright © 2019 usuario. All rights reserved.
//

import Foundation

class User: NSObject {
    var email: String
    var pass: String
    var name: String
    var phone: String
    var birthday: Date
    var empNumber: String
    
    
    override init() {
        email = ""
        pass = ""
        name = ""
        phone = ""
        birthday = Date()
        empNumber = ""
    }
}

class Configurations {
    public static var users: [User] = [User]()
}
