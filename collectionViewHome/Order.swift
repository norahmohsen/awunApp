
import Foundation
import RealmSwift
//protocol PrimaryKeyAwareOrder {
//  var orderNumber: Int { get }
//  static func primaryKey() -> Int?
//}
class Order : Object  {
    @objc dynamic var orderNumber : Int = 0
    @objc dynamic var lat : Double = 0
    @objc dynamic var long : Double = 0
    @objc dynamic var customerEmail : String?
    @objc dynamic var providerEmail : String?
    @objc dynamic var orderStatus : Int = 0
    @objc dynamic var time : String?
    @objc dynamic var Date : NSDate?
    @objc dynamic var day:String?
    @objc dynamic var hour: String?
    @objc dynamic var servieceID : Int = 0
    @objc dynamic var orderComment : String?
    @objc dynamic var orderLocation : String?
    @objc dynamic var servieceTitle : String?
    @objc dynamic var cost : String?
    @objc dynamic var servieceDescription : String?
    
    override static func primaryKey() -> String? {
        return "orderNumber"}
    
    
    
    
}
