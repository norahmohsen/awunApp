//
//  Customer.swift
//  collectionViewHome
//
//  Created by Rania Saad on 24/01/1441 AH.
//  Copyright © 1441 Nourah. All rights reserved.
//

import Foundation
import RealmSwift
protocol PrimaryKeyAware {
  var email: String { get }
  static func primaryKey() -> String?
}
class Customer : Object , PrimaryKeyAware {
    @objc dynamic  var email: String = ""
    
   @objc dynamic var name : String?
    @objc dynamic var status : Int = 0 
    @objc dynamic var password : String?
   @objc dynamic var phoneNumber : String?
   @objc dynamic var location : String?
    
     override static func primaryKey() -> String? {
        return "email"}
    
    
    
}

import Foundation
import RealmSwift
//protocol PrimaryKeyAwareService {
//  var servieceID: Int { get }
//  static func primaryKey() -> Int?
//}
class Serviece1 : Object  {
    @objc dynamic var servieceID : Int=0
    @objc dynamic var sectionName : String?
    @objc dynamic var servieceTitle : String?
    @objc dynamic var cost : Double = 0.0
    @objc dynamic var servieceDescription : String?
    @objc dynamic var providerEmail : String?
    
   
    
     override static func primaryKey() -> String? {
        return "servieceID"}
    
    
     // not sure ....
 
}
