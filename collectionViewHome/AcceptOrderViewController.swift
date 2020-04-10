//
//  HistoryOfServiceProviderViewController.swift
//  collectionViewHome
//
//  Created by Rania Saad on 22/02/1441 AH.
//  Copyright © 1441 Nourah. All rights reserved.
//

import UIKit
import RealmSwift
class AcceptOrderViewController: UIViewController  {
    
    let migrationBlock: MigrationBlock = { migration, oldSchemaVersion in
        //Leave the block empty
    }
    
    lazy var realm:Realm = {
        Realm.Configuration.defaultConfiguration = Realm.Configuration(schemaVersion: 15, migrationBlock: migrationBlock)
        return try! Realm()
    }()
    var serviceArray : Array<String> = Array()
    var customerArray : Array<String> = Array ()
    var orderId = [Int]()
    var dayArray : Array<String> = Array ()
    var hourArray : Array<String> = Array ()
    var locationArray : Array<String> = Array ()
    var orderArray : Array<Int> = Array ()
    //["HouseKeeping", "BabySitting", "Moving", "Assembly", "HandyMan","Painting"]
    
    //["$1", "$2", "$3", "$4", "$5","$6"]
    
    
    
    @IBOutlet weak var menuButtom: UIBarButtonItem!
    
    @IBOutlet weak var OrderForSeviceTabelView: UITableView!
    
    
    var email = ""
    
    
    // go to order status !!!!!
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        view.generalGradiantView()
        
        print(Realm.Configuration.defaultConfiguration.fileURL)
        OrderForSeviceTabelView.backgroundColor = .clear
        menuButtom.target = self.revealViewController()
        menuButtom.action = #selector(SWRevealViewController.revealToggle(_:))
        self.view.addGestureRecognizer((self.revealViewController()?.panGestureRecognizer() ?? nil)!)
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
        
        
        let orders = realm.objects(Order.self)
        let currentProvider = realm.objects(CurrentUser.self)
        let providerEmail = currentProvider[0].user_email
        print(providerEmail)
        //print(orders[0].providerEmail)
        for i in  0..<orders.count {
            if (orders[i].providerEmail ==  providerEmail && orders[i].orderStatus == 0 ){
                orderId.append(orders[i].orderNumber)
                serviceArray.append(orders[i].servieceTitle!)
                orderArray.append(orders[i].orderStatus)
                let customerEmail = orders[i].customerEmail
                let customers = realm.objects(Customer.self)
                for i in 0..<customers.count {
                    if (customers[i].email.isEqual(customerEmail)){
                        customerArray.append(customers[i].name!)
                    }
                }
                dayArray.append(orders[i].day!)
                hourArray.append(orders[i].hour!)
                locationArray.append(String (orders[i].orderLocation ?? "nil" ))
                
                
                OrderForSeviceTabelView.reloadData()
                print("I'm here")
            }
        }
        if customerArray.count == 0 {
                   let messageLabel : UILabel = {
                      let lbl = UILabel()
                       lbl.text = "Stay tuned!We are waiting for customers orders."
                       lbl.textColor = #colorLiteral(red: 0.2027751207, green: 0.2251471281, blue: 0.3329623044, alpha: 1)
                       lbl.textAlignment = .center
                       lbl.font = UIFont(name: "Helvetica", size: 15)
                       //lbl.frame = CGRect(x: 0, y: 0, width: jobsTabelView.frame.size.width, height: jobsTabelView.frame.size.height)
                       return lbl
                   }()
                   OrderForSeviceTabelView.addSubview(messageLabel)
                   
                   messageLabel.translatesAutoresizingMaskIntoConstraints = false

                   messageLabel.centerYAnchor.constraint(equalTo: OrderForSeviceTabelView.centerYAnchor).isActive = true
                   messageLabel.centerXAnchor.constraint(equalTo: OrderForSeviceTabelView.centerXAnchor).isActive = true
                   messageLabel.widthAnchor.constraint(equalTo: OrderForSeviceTabelView.widthAnchor).isActive = true
               }
    }
    
    
    
}

extension AcceptOrderViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if customerArray.count > 0 {
            return customerArray.count
        }
        else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "orderStatusCell", for: indexPath) as!
        AcceptTabelViewCellProvider
        cell.ServiceName.text = serviceArray[indexPath.row] as String
        cell.customerName.text = customerArray[indexPath.row] as String
        cell.orderDay.text = dayArray[indexPath.row] as String
        cell.orderTime.text = hourArray[indexPath.row] as String
        cell.customerLocation.text = locationArray[indexPath.row] as String
        
        
        
        cell.acceptButtonOutlet.tag = indexPath.row
        //cell.acceptButtonOutlet.addTarget(self, action: #selector(removerowButtonClicked), for: .touchUpInside)
        cell.declineButtonOutlet.tag = indexPath.row
        //cell.declineButtonOutlet.addTarget(self, action: #selector(removerowButtonClicked), for: .touchUpInside)
        
        cell.acceptButtonOutlet.addTarget(self, action: #selector(acceptOrder), for: .touchUpInside)
        
        cell.declineButtonOutlet.addTarget(self, action: #selector(declineOrder), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        250
    }
    
    
    @objc func removerowButtonClicked(tag : Int) {
        serviceArray.remove(at: tag)
        customerArray.remove(at: tag)
        locationArray.remove(at: tag)
        dayArray.remove(at: tag)
        hourArray.remove(at: tag)
        orderArray.remove(at: tag)
        
        self.OrderForSeviceTabelView.reloadData()
    }
    
    @objc func acceptOrder ( sender: UIButton!){
        let orders1 = realm.objects(Order.self)
        let currentProvider = realm.objects(CurrentUser.self)
        let providerEmail1 = currentProvider[0].user_email
        for i in  0..<orders1.count{
//            print(orders1[i])
            
            if (orders1[i].providerEmail ==  providerEmail1 && orders1[i].orderNumber == orderId[sender.tag]
                ){
                print(orders1[i].orderNumber)
                print("before ",orders1[i].orderStatus)
                try! self.realm.write {
                    orders1[i].orderStatus = 1
                    self.realm.add(orders1[i], update: .modified )
                }
                print("after ",orders1[i].orderStatus)
            }
            
        }
        removerowButtonClicked(tag: sender.tag)
        
        
    }
    
    
    @objc func declineOrder ( sender: UIButton!){
        let orders1 = realm.objects(Order.self)
        let currentProvider = realm.objects(CurrentUser.self)
        let providerEmail1 = currentProvider[0].user_email
        for i in  0..<orders1.count{
            print(orders1[i])
            
            if (orders1[i].providerEmail ==  providerEmail1 && orders1[i].orderNumber == orderId[sender.tag]
                ){
                print(orders1[i])
                try! self.realm.write {
                    orders1[i].orderStatus = 4
                    self.realm.add(orders1[i], update: .modified )
                }
                
            }
            
        }
        removerowButtonClicked(tag: sender.tag)
        
    }
}


class AcceptTabelViewCellProvider : UITableViewCell {
    let migrationBlock: MigrationBlock = { migration, oldSchemaVersion in
        //Leave the block empty
    }
    
    lazy var realm:Realm = {
        Realm.Configuration.defaultConfiguration = Realm.Configuration(schemaVersion: 13, migrationBlock: migrationBlock)
        return try! Realm()
    }()
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
        self.backgroundColor = UIColor.clear
        acceptButtonOutlet.layer.cornerRadius = 13
        declineButtonOutlet.layer.cornerRadius = 13
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    @IBOutlet weak var ServiceName: UILabel!
    
    @IBOutlet weak var orderTime: UILabel!
    @IBOutlet weak var orderDay: UILabel!
    @IBOutlet weak var customerName: UILabel!
    @IBOutlet weak var customerLocation: UILabel!
    @IBAction func acceptButton(_ sender: UIButton) {
        let orders1 = realm.objects(Order.self)
        let currentProvider = realm.objects(CurrentUser.self)
        let providerEmail1 = currentProvider[0].user_email
        for i in  0..<orders1.count{
            print(orders1[i])
            
            if (orders1[i].providerEmail ==  providerEmail1 && orders1[i].servieceTitle == MyVirable.title
                
                ){
                print(orders1[i])
                try! self.realm.write {
                    orders1[i].orderStatus = 1
                    self.realm.add(orders1[i], update: .modified )
                }
                
                
            }
            
        }
        
        
        
    }
    
    
    @IBOutlet weak var declineButtonOutlet: UIButton!
    @IBOutlet weak var acceptButtonOutlet: UIButton!
    @IBAction func declineButton(_ sender: UIButton) {
        let orders1 = realm.objects(Order.self)
        let currentProvider = realm.objects(CurrentUser.self)
        let providerEmail1 = currentProvider[0].user_email
        for i in  0..<orders1.count{
            print(orders1[i])
            
            if (orders1[i].providerEmail ==  providerEmail1 && orders1[i].servieceTitle == MyVirable.title
                
                ){
                print(orders1[i])
                try! self.realm.write {
                    orders1[i].orderStatus = 4
                    self.realm.add(orders1[i], update: .modified )
                }
                
                
                
            }
            
        }
        //        let window = UIApplication.shared.keyWindow
        //        window?.topMostController()?.navigationController?.popViewController(animated: true)
    }
    
}

