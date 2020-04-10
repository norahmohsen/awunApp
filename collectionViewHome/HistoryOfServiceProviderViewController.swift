//
//  HistoryOfServiceProviderViewController.swift
//  collectionViewHome
//
//  Created by Rania Saad on 22/02/1441 AH.
//  Copyright © 1441 Nourah. All rights reserved.
//

import UIKit
import RealmSwift
class HistoryOfServicePRoviderViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    let migrationBlock: MigrationBlock = { migration, oldSchemaVersion in
        //Leave the block empty
    }
    
    lazy var realm:Realm = {
        Realm.Configuration.defaultConfiguration = Realm.Configuration(schemaVersion: 15, migrationBlock: migrationBlock)
        return try! Realm()
    }()
    var status : Array<Int>  = Array ()
    var jobsArray : Array<String> = Array ()
    //["HouseKeeping", "BabySitting", "Moving", "Assembly", "HandyMan","Painting"]
    var pricesArray : Array<String> = Array ()
    var customerArray : Array<String> = Array ()
    
    var dayArray : Array<String> = Array ()
    var hourArray : Array<String> = Array ()
    var locationArray : Array<String> = Array ()
    var cellArray : Array <CellService> = Array()
    //["$1", "$2", "$3", "$4", "$5","$6"]
//    var  descriptionArray: Array <String> = Array()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        if cellArray.count > 0 {
           return cellArray.count
        }
        else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: "serviceHistory", for: indexPath) as! ServiceTabelViewCellProvider
        cell.customerName.text = cellArray[indexPath.row].customerName
        cell.orderDay.text = cellArray[indexPath.row].day
        cell.orderTime.text = cellArray[indexPath.row].hour
        cell.customerLocation.text = cellArray[indexPath.row].location as String
        cell.ServiceTitle.text = cellArray[indexPath.row].serviceNeme
        cell.ServiceCost.text = cellArray[indexPath.row].cost
        
        if (cellArray [indexPath.row].status == 1){
                  cell.Status.text = "On going"
                  cell.Status.backgroundColor =  UIColor(red: 130.0 / 255.0, green: 165.0 / 255.0, blue: 201.0 / 255.0, alpha: 1.0)
                
              }
              else if ( cellArray [indexPath.row].status == 2) {
                  cell.Status.text = "Done"
                  cell.Status.backgroundColor = UIColor(red: 130.0 / 255.0, green: 201.0 / 255.0, blue: 179.0 / 255.0, alpha: 1.0)
                  
              }
              else if( (cellArray [indexPath.row].status == 4 )) {
                  cell.Status.text = "Declined"
                  cell.Status.backgroundColor = UIColor(red: 201.0 / 255.0, green: 130.0 / 255.0, blue: 146.0 / 255.0, alpha: 1.0)
               
              }
              
                
                            
        return cell
    }
    //!!!!!!!!!!!!!!!!!!!!!!!
    
    //   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //
    //            performSegue(withIdentifier: "acceptOrder", sender: self)
    //
    //
    //      }
    //
    //      override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //
    //          if let destination = segue.destination as? AcceptOrderViewController {
    //            destination.titleText = jobsArray [(ServiceTabelView.indexPathForSelectedRow?.row)!]
    //             destination.costText = pricesArray [(ServiceTabelView.indexPathForSelectedRow?.row)!]
    //
    //
    //        ServiceTabelView.deselectRow(at: ServiceTabelView.indexPathForSelectedRow!, animated: true)
    //
    //        }}
    
    
    
    
    //
    //@IBOutlet weak var viewAll: UIView!
    //
    
    
    @IBOutlet weak var ServiceTabelView: UITableView!
    
    

    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        if(cellArray [indexPath.row].status == 2 || cellArray [indexPath.row].status == 3 ){
        let currentCellTxt = ServiceTabelView.cellForRow(at: indexPath)! as? ServiceTabelViewCellProvider
        let title1 = currentCellTxt?.ServiceTitle?.text
        
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            // delete item at indexPath
            let alert = UIAlertController(title: "Would you like to delete this service?", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                
                
                let services = self.realm.objects(Serviece1.self)
                for i  in 0..<services.count {
                    let titleFound = String (services[i].servieceTitle!)
                    let idFound = services[i].servieceID
                    if(titleFound.isEqual(title1)){
                        try! self.realm.write {
                            self.realm.delete(services[i])
                        }
                        
                        self.jobsArray.remove(at: indexPath.row)
                        self.pricesArray.remove(at: indexPath.row)
                        tableView.deleteRows(at: [indexPath], with: .fade)
                    }
                }
                
            }))
            
            self.present(alert, animated: true)
            
            //print(self.tableArray)
            
            }
        
           
         return [delete]  }
        else {
            return nil
        }
     }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let services = realm.objects(Serviece1.self)
        let orders = realm.objects(Order.self)
        let currentProvider = realm.objects(CurrentUser.self)
        let providerEmail = currentProvider[0].user_email
        var found = false
        
        print(providerEmail)
        print(services[0].providerEmail)
        var customerName = ""
        
        
        for z in  0..<services.count {
            if (services[z].providerEmail ==  providerEmail ){
                let idFound = services[z].servieceID
                let serviceName = services[z].servieceTitle!
                let serviceCost : String  = String (services [z].cost)
                let serviceCostElement : String =  serviceCost + " SAR"
                for i in 0..<orders.count {
                    let  emailP = String (orders[i].providerEmail!)
                    if(emailP == providerEmail) {
                        
                        if(orders[i].servieceTitle == serviceName && orders [i] .orderStatus != 0 && orders[i].orderStatus != 3){
                            jobsArray.append(serviceName)
                            pricesArray.append(serviceCostElement)
                            status.append(orders[i].orderStatus)
                            let emailC = String (orders[i].customerEmail!)
                            var findC = realm.object(ofType: Customer.self, forPrimaryKey: emailC)
                            // customerArray.append(String (findC!.name!))
                            
                            
                            dayArray.append(orders[i].day!)
                            hourArray.append(orders[i].hour!)
                            locationArray.append( orders[i].orderLocation ?? "nil" )
                            
                            var service = CellService (status: orders[i].orderStatus, customerName: String (findC!.name!), cost: serviceCostElement, serviceNeme: serviceName, day: orders[i].day!, hour: orders[i].hour!, location: String (orders[i].orderLocation ?? "nil" ), serviceId: idFound)
                            cellArray.append(service)
                            
                        }
                    }
                    
                }
            }
            
            print("I'm here")
            found = true    }
        
        
        if (found == false){
            
            print ("I'm Here ?")
            jobsArray.append("Not Found")
            pricesArray.append("")
        }
           cellArray.sort(by: {$0.status < $1.status})
           ServiceTabelView.reloadData()
            
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
               self.navigationController?.navigationBar.shadowImage = UIImage()
               
               self.view.generalGradiantView()
        
        menuButton.target = self.revealViewController()
        menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
        self.view.addGestureRecognizer((self.revealViewController()?.panGestureRecognizer() ?? nil)!)
        print(Realm.Configuration.defaultConfiguration.fileURL)
        ServiceTabelView.backgroundColor = .clear
        
//          if(jobsArray.count == 0 ){
//                print("Trueeeeee")
//                        let cell = tableView.dequeueReusableCell(withIdentifier: "serviceHistory", for: indexPath) as! ServiceTabelViewCellProvider
//                            cell.ServiceTitle.text = "Not Found "
//                            cell.ServiceCost.text = " "
//                            cell.ServiceDescription.text = " "
//                             }
        //cellOutlet.setGradientBackground(colorOne: UIColor(hue: 0.0778, saturation: 0.06, brightness: 1, alpha: 1.0) , colorTwo: UIColor(hue: 0.9972, saturation: 0, brightness: 1, alpha: 1.0))
        //viewAll.setRadius(radius: CGFloat(signOf: 20, magnitudeOf: 20))
        //        view.setGradientBackground(colorOne: UIColor(hue: 0.0778, saturation: 0.06, brightness: 1, alpha: 1.0) , colorTwo: UIColor(hue: 0.9972, saturation: 0, brightness: 1, alpha: 1.0))
        // label.text = ""
        
        //               barMenu.target = self.revealViewController()
        //               barMenu.action = #selector(SWRevealViewController.revealToggle(_:))
        //
        //               self.view.addGestureRecognizer((self.revealViewController()?.panGestureRecognizer() ?? nil)!)
        //
        //               navigationItem.hidesBackButton = true
        //                        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain,target:nil,action: nil)
        //       //               revealViewController()?.panGestureRecognizer()
        //               setupUI()
        //       //        observeAndHandleOrientationMode()
        //               //self.view.addGestureRecognizer(revealViewController().panGestureRecognizer())
        //
        //       //        var uITapRec = UITapGestureRecognizer(target: self, action: Selector("tappedImage:"))
        //       //        uITapRec.delegate = self
        //
        //       //        self.imageView.addGestureRecognizer(uITapRec)
        //       //
        //       //        self.imageView.isUserInteractionEnabled = true
        //               print("SHITTTT4")
//
        
        // ++++++++++++++
//        let services = realm.objects(Serviece1.self)
//        let currentProvider = realm.objects(CurrentUser.self)
//        var providerEmail = currentProvider[0].user_email
//        print(providerEmail)
//        print(services[0].providerEmail)
//        if (services.count == 0){
//            jobsArray.append("NOT FOUND")
//            pricesArray.append("NOT FOUND")
//            descriptionArray.append("NOT FOUND")
//        }
//        else {
//
//
//            for i in  0..<services.count {
//                if (services[i].providerEmail ==  MyStatus.providerEmail ){
//                    var serviceName = services[i].servieceTitle!
//                    var serviceCost : String  = String (services [i].cost)
//                    var serviceCostElement : String =  serviceCost + " SAR"
//                    let serviceDescription0 = services[i].servieceDescription!;             jobsArray.append(serviceName)
//                    pricesArray.append(serviceCostElement)
//                    descriptionArray.append(serviceDescription0)
//                    print("I'm here")
//                }
//
//            }
//
//        }
    }
    
 
    
      }
   
    



class ServiceTabelViewCellProvider : UITableViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        self.backgroundColor = UIColor.clear
    }
    @IBOutlet weak var Status: UILabel!
    @IBOutlet weak var ServiceTitle: UILabel!
    @IBOutlet weak var ServiceCost: UILabel!
    @IBOutlet weak var orderTime: UILabel!
      @IBOutlet weak var orderDay: UILabel!
      @IBOutlet weak var customerLocation: UILabel!
    @IBOutlet weak var customerName: UILabel!
    @IBOutlet weak var swipeIcon: UIImageView!
}

//
//  CellService.swift
//  collectionViewHome
//
//  Created by Rania Saad on 03/04/1441 AH.
//  Copyright © 1441 Nourah. All rights reserved.
//

class CellService: NSObject {
var customerName: String  = ""
var status : Int = 0
var cost : String = ""
var serviceNeme: String  = ""
var day: String = ""
var hour: String = ""
var location: String = ""
    var serviceId : Int = 0
    
    init (status: Int , customerName: String , cost : String , serviceNeme: String , day: String , hour: String , location: String,serviceId : Int   ) {
        
       self.status = status
        self.customerName = customerName
        self.cost = cost
        self.serviceNeme = serviceNeme
        self.day = day
        self.hour = hour
        self.location = location
        self.serviceId = serviceId
    }
    
    func set (status: Int ){
        self.status = status
    }
}
