//
//  Provider.swift
//  collectionViewHome
//
//  Created by Rania Saad on 24/01/1441 AH.
//  Copyright © 1441 Nourah. All rights reserved.
//

import Foundation
import RealmSwift

class Provider : Object , PrimaryKeyAware {
    @objc dynamic var name : String?
       @objc dynamic  var email: String = ""
    @objc dynamic var password : String?
    @objc dynamic var phoneNumber : String?
    @objc dynamic var status : Int = 0
    override static func primaryKey() -> String? {
       return "email"}
    
}

class CurrentUser : Object  {
       @objc dynamic  var user_email: String = ""
        @objc dynamic var user_status : Int = 0
    
    override static func primaryKey() -> String? {
          return "user_email"}
}
