//
//  HistoryOfServiceProviderViewController.swift
//  collectionViewHome
//
//  Created by Rania Saad on 22/02/1441 AH.
//  Copyright © 1441 Nourah. All rights reserved.
//

import UIKit
import RealmSwift
class OrderHistory: UIViewController , UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var OrdersTabelView: UITableView!
    
    private let refreshControl = UIRefreshControl()
    
    let migrationBlock: MigrationBlock = { migration, oldSchemaVersion in
        //Leave the block empty
    }
    
    lazy var realm:Realm = {
        Realm.Configuration.defaultConfiguration = Realm.Configuration(schemaVersion: 15, migrationBlock: migrationBlock)
        return try! Realm()
    }()
    
    var providerArray : Array<String> = Array ()
    
    var serviceArray : Array<String> = Array ()
    var costArray : Array<String> = Array ()
    var statusArray : Array<Int> = Array()
    var cellArray : Array <CellOrder> = Array()
    //["HouseKeeping", "BabySitting", "Moving", "Assembly", "HandyMan","Painting"]
    
    //["$1", "$2", "$3", "$4", "$5","$6"]
        @IBOutlet weak var menuButton: UIBarButtonItem!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if cellArray.count > 0 {
           return cellArray.count
        }
        else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "orderHistory", for: indexPath) as!
        OrderTabelViewCell
        
        cell.serviceName.text = cellArray[indexPath.row].serviceNeme
        cell.serviceCost.text = cellArray[indexPath.row].cost
        cell.providerName.text = cellArray[indexPath.row].providerName
        if (cellArray [indexPath.row].status == 0){
            cell.statusLabel.text = "Pending"
            cell.statusLabel.backgroundColor = UIColor(red: 130.0 / 255.0, green: 201.0 / 255.0, blue: 179.0 / 255.0, alpha: 1.0)
            
        }
            
        else if (cellArray [indexPath.row].status == 1){
            cell.statusLabel.text = "On going"
            cell.statusLabel.backgroundColor =  UIColor(red: 130.0 / 255.0, green: 165.0 / 255.0, blue: 201.0 / 255.0, alpha: 1.0)
//            cell.cancelImg.isHidden = true
        }
        else if ( cellArray [indexPath.row].status == 2) {
            cell.statusLabel.text = "Done"
            cell.statusLabel.backgroundColor = UIColor(red: 130.0 / 255.0, green: 201.0 / 255.0, blue: 179.0 / 255.0, alpha: 1.0)
//            cell.cancelImg.isHidden = true
        }
        else if( cellArray [indexPath.row].status == 3 ) {
            cell.statusLabel.text = "Canceled"
            cell.statusLabel.backgroundColor = UIColor(red: 201.0 / 255.0, green: 130.0 / 255.0, blue: 146.0 / 255.0, alpha: 1.0)
//            cell.cancelImg.isHidden = true
        }
        else {
            cell.statusLabel.text = "Declined"
            cell.statusLabel.backgroundColor = UIColor(red: 201.0 / 255.0, green: 130.0 / 255.0, blue: 146.0 / 255.0, alpha: 1.0)
//             cell.cancelImg.isHidden = true
            
            
        }
        
        
        return cell
    }
    
    
    
    
    
    
    
    
   
    
    
    // go to order status !!!!!
    
    
    
    override func viewDidLoad() {
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        self.view.generalGradiantView()
        
        self.view.addGestureRecognizer((self.revealViewController()?.panGestureRecognizer() ?? nil)!)
        
        print(Realm.Configuration.defaultConfiguration.fileURL)
        OrdersTabelView.backgroundColor = .clear
        
       
        
        menuButton.target = self.revealViewController()
               menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
               self.view.addGestureRecognizer((self.revealViewController()?.panGestureRecognizer() ?? nil)!)
        ///////////
       
        
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
    }
    override func viewWillAppear(_ animated: Bool) {
        print("Here")
        super.viewWillAppear(animated)
        let orders = realm.objects(Order.self)
        let currentUser = realm.objects(CurrentUser.self)
        let customerEmail = String( currentUser[0].user_email)
        let services = realm.objects(Serviece1.self)
        _ = realm.objects(Provider.self)
        
        print (orders.count)
        for i in  0..<orders.count {
            
            guard let emailC =  orders[i].customerEmail else { return }
            print (emailC)
            if (emailC == customerEmail  ){
                let findP = realm.object(ofType: Provider.self, forPrimaryKey: orders[i].providerEmail)
                let newOrder = CellOrder (status: orders[i].orderStatus, providerName: findP?.name ?? "" , cost: orders[i].cost ?? "0", serviceNeme: orders[i].servieceTitle ?? "" , orderId: orders[i].orderNumber)
                cellArray.append(newOrder)
                
                                        providerArray.append(String (findP!.name!))
                
                
//               var id = orders[i].orderNumber
//                print(true)
//                statusArray.append(orders[i].orderStatus)
//                let serviceId = orders[i].servieceID
//                for j in  0..<services.count {
//                    print ("service")
//                    print(serviceId)
//                    print(services[j].servieceID)
//                    if ( serviceId == services[j].servieceID){
//                        print (serviceId)
//                        serviceArray.append( services[j].servieceTitle!)
//                        let serviceCost :String = String (services[j].cost)
//                        let costSAR : String =  serviceCost + " SAR"
//                        costArray.append(costSAR)
//                        let emailP = String (services[j].providerEmail!)
//                        let findP = realm.object(ofType: Provider.self, forPrimaryKey: emailP)
//                        providerArray.append(String (findP!.name!))
//
//
//
//                        //
//                        //                            for z in 0..<providers.count {
//                        //                                if(String (providers[z].email) == emailP){
//                        //                                    var nameP = String(providers[z].name!)
//                        //                                    providerArray.append(nameP)
//                        //                                }
//                        //                            }
//
//                        let newOrder = CellOrder (status: orders[i].orderStatus, providerName: findP!.name!, cost: costSAR, serviceNeme: services[j].servieceTitle! , orderId: id)
//                        cellArray.append(newOrder)
//                    print (newOrder)
//
//                    }
//
//                }
                print("I'm here")
            }
            
        }
        if cellArray.count == 0 {
                          let messageLabel : UILabel = {
                             let lbl = UILabel()
                              lbl.text = "No Services Yet"
                              lbl.textColor = #colorLiteral(red: 0.2027751207, green: 0.2251471281, blue: 0.3329623044, alpha: 1)
                              lbl.textAlignment = .center
                              lbl.font = UIFont(name: "Helvetica", size: 20)
                              //lbl.frame = CGRect(x: 0, y: 0, width: jobsTabelView.frame.size.width, height: jobsTabelView.frame.size.height)
                              return lbl
                          }()
                          OrdersTabelView.addSubview(messageLabel)
                          
                          messageLabel.translatesAutoresizingMaskIntoConstraints = false

                          messageLabel.centerYAnchor.constraint(equalTo: OrdersTabelView.centerYAnchor).isActive = true
                          messageLabel.centerXAnchor.constraint(equalTo: OrdersTabelView.centerXAnchor).isActive = true
                          messageLabel.widthAnchor.constraint(equalTo: OrdersTabelView.widthAnchor).isActive = true
                      }
        
        cellArray.sort(by: {$0.status < $1.status})
        OrdersTabelView.reloadData()
      
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        print(cellArray[indexPath.row].status)
        if(cellArray[indexPath.row].status == 0 ){
            let currentCellTxt = OrdersTabelView.cellForRow(at: indexPath)! as? OrderTabelViewCell
            let title1 = currentCellTxt?.serviceName?.text
            
            let cancel = UITableViewRowAction(style: .destructive, title: "Cancel") { (action, indexPath) in
                // delete item at indexPath
                let alert = UIAlertController(title: "Would you like to Cancel this Order?", message: nil, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
                
                
                alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
                    
                    
                    let orders = self.realm.objects(Order.self)
                    for i  in 0..<orders.count {
                                              
                        let titleFound = String (orders[i].servieceTitle!)
                        print("ltesrttttt?????????????????")
                                                

                        if( orders [i].orderStatus == 0 && orders[i].orderNumber == self.cellArray[indexPath.row].orderId  ){
                         
                         
                            do{
                                print ("Heeeeeeeere")
                                try! self.realm.write {
                                       orders[i].orderStatus = 3
                                    self.realm.add(orders[i], update: .modified )
                                
                                }
                                
                                //                                                   try! self.realm.write {
                                //                                                          self.realm.add(order)
                                //                                                   }
                            }
                            self.cellArray[indexPath.row].status = 3
                           currentCellTxt!.statusLabel.text = "Canceled"
                           currentCellTxt!.statusLabel.backgroundColor = UIColor(red: 201.0 / 255.0, green: 130.0 / 255.0, blue: 146.0 / 255.0, alpha: 1.0)
//                         currentCellTxt!.cancelImg.isHidden = true
                           

                          
//                            tableView.reloadRows(at: [indexPath], with: .none)
//
//                            NotificationCenter.default.post( Notification(name: NSNotification.Name(rawValue: "UserlistUpdate")))

                          
                          //  tableView.deleteRows(at: [indexPath], with: .fade)
                        }
                       
                    }
                    
                }))
                
                self.present(alert, animated: true)
             
                //print(self.tableArray)
                
            }
            return [cancel]
        }
        else
        {
            return nil }
        
    }
}


class OrderTabelViewCell : UITableViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
        self.backgroundColor = UIColor.clear
        statusLabel.layer.cornerRadius = 13
    }
   
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var serviceName: UILabel!
    @IBOutlet weak var providerName: UILabel!
    @IBOutlet weak var serviceCost: UILabel!
    
//    @IBOutlet weak var cancelImg: UIImageView!
}


//
//  CellOrder.swift
//  collectionViewHome
//
//  Created by Rania Saad on 03/04/1441 AH.
//  Copyright © 1441 Nourah. All rights reserved.
//

class CellOrder: NSObject {
    var providerName: String  = ""
    var status : Int = 0
    var cost : String = ""
    var serviceNeme: String  = ""
    var orderId: Int = 0
    
    init (status: Int , providerName: String , cost : String , serviceNeme: String , orderId : Int){
        self.status = status
        self.providerName = providerName
        self.cost = cost
        self.serviceNeme = serviceNeme
        self.orderId = orderId
    }
    
    func set (status: Int ){
        self.status = status
    }
}
