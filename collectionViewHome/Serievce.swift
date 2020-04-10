//
//  Serievce.swift
//  collectionViewHome
//
//  Created by Rania Saad on 06/02/1441 AH.
//  Copyright © 1441 Nourah. All rights reserved.
//

import Foundation
import RealmSwift
//protocol PrimaryKeyAwareService {
//  var servieceID: Int { get }
//  static func primaryKey() -> Int?
//}
class Serviece : Object  {
    @objc dynamic var servieceID : Int=0
    @objc dynamic var sectionName : String?
    @objc dynamic var servieceTitle : String?
    @objc dynamic var cost : Double = 0.0
    @objc dynamic var servieceDescription : String?
    
   
    
     override static func primaryKey() -> String? {
        return "servieceID"}
    
    
     // not sure ....
    func incrementID() -> Int {
        let realm = try! Realm()
        return (realm.objects(Serviece.self).max(ofProperty: "servieceID") as Int? ?? 0) + 1
    }
}
