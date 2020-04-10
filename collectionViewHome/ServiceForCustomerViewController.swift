//
//  ServiceForCustomerViewController.swift
//  collectionViewHome
//
//  Created by Rania Saad on 08/02/1441 AH.
//  Copyright © 1441 Nourah. All rights reserved.
//

import UIKit
import RealmSwift
class ServiceForCustomerViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {
    var email = ""
    
    
    let migrationBlock: MigrationBlock = { migration, oldSchemaVersion in
        //Leave the block empty
    }
    
    lazy var realm:Realm = {
        Realm.Configuration.defaultConfiguration = Realm.Configuration(schemaVersion: 15, migrationBlock: migrationBlock)
        return try! Realm()
    }()
    
    var jobsArray : Array<String> = Array ()
    //["HouseKeeping", "BabySitting", "Moving", "Assembly", "HandyMan","Painting"]
    var pricesArray : Array<String> = Array ()
    //["$1", "$2", "$3", "$4", "$5","$6"]ahshitherewe
    
    var descriptionArray : Array<String> = Array ()
    var servicesEmail : Array<String> = Array()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jobsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "jobsCellCustomer", for: indexPath) as! ServiceTabelViewCell
        cell.titleLabel.text = jobsArray[indexPath.row]
        cell.priceLabel.text = pricesArray[indexPath.row]
        
        cell.titleLabel.text = jobsArray[indexPath.row] 
        cell.priceLabel.text = pricesArray[indexPath.row] 
        
        cell.descriptionLabel.text = descriptionArray[indexPath.row] as! String
        
        return cell
    }
    
    
    
    
    
    
    //
    @IBOutlet weak var viewAll: UIView!
    
    @IBOutlet weak var sectionImg: UIImageView!
    
    
    
    @IBOutlet weak var jobsTabelView: UITableView!
    
    @IBOutlet weak var titleLabel: UILabel!
//    var globalImage:UIImage? = nil
//    var globalText = ""
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        
        print(Realm.Configuration.defaultConfiguration.fileURL)
        jobsTabelView.backgroundColor = .clear
        
        viewAll.setRadius(radius: CGFloat(signOf: 20, magnitudeOf: 20))
        
        let topColor = UIColor(red: 242.0 / 255.0, green: 177.0 / 255.0, blue: 124.0 / 255.0, alpha: 1.0)
        let bottomColor = UIColor(red: 1.0, green: 246.0 / 255.0, blue: 238.0 / 255.0, alpha: 1.0)
        view.setGradientBackground(colorOne: topColor, colorTwo: bottomColor)
        // label.text = ""
        sectionImg.image = ViewController.imagesArray[ViewController.selectedService] //globalImage
        titleLabel.text = ViewController.array[ViewController.selectedService] //globalText
        
        let services = realm.objects(Serviece1.self)
        for i in  0..<services.count {
            if (services[i].sectionName == ViewController.array[ViewController.selectedService]){
                var Email = services[i].providerEmail
                var serviceName = services[i].servieceTitle!
                let serviceCost : String  = String (services [i].cost)
                var serviceCostElement : String =  serviceCost + "  SR"
                let serviceDescription0 = services[i].servieceDescription!
                servicesEmail.append(Email!)
                jobsArray.append(serviceName)
                pricesArray.append(serviceCostElement)
                descriptionArray.append(serviceDescription0)
                
            }
            
        }
        
        if jobsArray.count == 0 {
            let messageLabel : UILabel = {
               let lbl = UILabel()
                lbl.text = "No Services Yet"
                lbl.textColor = #colorLiteral(red: 0.2027751207, green: 0.2251471281, blue: 0.3329623044, alpha: 1)
                lbl.textAlignment = .center
                lbl.font = UIFont(name: "Helvetica", size: 20)
                //lbl.frame = CGRect(x: 0, y: 0, width: jobsTabelView.frame.size.width, height: jobsTabelView.frame.size.height)
                return lbl
            }()
            jobsTabelView.addSubview(messageLabel)
            
            messageLabel.translatesAutoresizingMaskIntoConstraints = false

            messageLabel.centerYAnchor.constraint(equalTo: jobsTabelView.centerYAnchor).isActive = true
            messageLabel.centerXAnchor.constraint(equalTo: jobsTabelView.centerXAnchor).isActive = true
            messageLabel.widthAnchor.constraint(equalTo: jobsTabelView.widthAnchor).isActive = true
        }
        
    }
    
    static var titleText = ""
    static var desc = ""
    static var costText = ""
    static var providerEmail = ""
    static var emailForCustomer = ""
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        ServiceForCustomerViewController.titleText = jobsArray[indexPath.row]
        ServiceForCustomerViewController.providerEmail = servicesEmail[indexPath.row]
        ServiceForCustomerViewController.costText = pricesArray[indexPath.row]
        ServiceForCustomerViewController.desc = descriptionArray[indexPath.row]
        
        //            customAlert.serviceEmail = servicesEmail [(jobsTabelView.indexPathForSelectedRow?.row)!]
        //            customAlert.titleText = jobsArray [(jobsTabelView.indexPathForSelectedRow?.row)!] // take title text to put it in new order page ..
        //                customAlert.costText = pricesArray[(jobsTabelView.indexPathForSelectedRow?.row)!]// take cost text to put it in new order page ..
        //            customAlert.desc = descriptionArray [(jobsTabelView.indexPathForSelectedRow?.row)!]
        ////         self.present(customAlert, animated: true, completion: nil)
        
        performSegue(withIdentifier: "alert", sender: self)
        
        //        else {
        //            var alert : UIAlertView = UIAlertView(title: "Oops!", message: "Please signup to create new order or login if you have account",
        //                                                  delegate: nil, cancelButtonTitle: "OK")
        //            alert.show()
        //        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //        let customAlert = segue.destination as! CustomAlertView
    //                  customAlert.providesPresentationContextTransitionStyle = true
    //                  customAlert.definesPresentationContext = true
    //                  customAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
    //                  customAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
    ////            customAlert.delegate = self as? CustomAlertViewDelegate
    ////                  self.present(customAlert, animated: true, completion: nil)
    //            customAlert.serviceEmail = servicesEmail [(jobsTabelView.indexPathForSelectedRow?.row)!]
    //            customAlert.titleText = jobsArray [(jobsTabelView.indexPathForSelectedRow?.row)!] // take title text to put it in new order page ..
    //                customAlert.costText = pricesArray[(jobsTabelView.indexPathForSelectedRow?.row)!]// take cost text to put it in new order page ..
    //            customAlert.desc = descriptionArray [(jobsTabelView.indexPathForSelectedRow?.row)!]
    ////         self.present(customAlert, animated: true, completion: nil)
    //
    //            // take description
    //                      //   customAlert.emailForCustomer = email // can replce it with get email current user in ORDER CODE ?
    //                         customAlert.sectionNeme = globalText // to save section name in order database
    //                         customAlert.sectionImg = globalImage // I don't know why I write It >>!
    //            //////////////////////
    //                         MyVirable.title = jobsArray [(jobsTabelView.indexPathForSelectedRow?.row)!]
    //                         MyVirable.cost = pricesArray [(jobsTabelView.indexPathForSelectedRow?.row)!]
    //                         MyVirable.desciption = descriptionArray [(jobsTabelView.indexPathForSelectedRow?.row)!]
    //          jobsTabelView.deselectRow(at: jobsTabelView.indexPathForSelectedRow!, animated: true)
    ////        if (LoginViewController.userStatus == 1 ){
    ////            if let destination = segue.destination as? NewOrderViewController {
    ////                destination.titleText = jobsArray [(jobsTabelView.indexPathForSelectedRow?.row)!]
    ////                print(destination.titleText)
    ////                destination.costText = pricesArray [(jobsTabelView.indexPathForSelectedRow?.row)!]
    ////
    ////                destination.desc = descriptionArray [(jobsTabelView.indexPathForSelectedRow?.row)!]
    ////                destination.emailForCustomer = email
    ////                destination.globalName = globalText
    ////                destination.globalImg = globalImage
    ////                MyVirable.title = jobsArray [(jobsTabelView.indexPathForSelectedRow?.row)!]
    ////                MyVirable.cost = pricesArray [(jobsTabelView.indexPathForSelectedRow?.row)!]
    ////                MyVirable.desciption = descriptionArray [(jobsTabelView.indexPathForSelectedRow?.row)!]
    ////                jobsTabelView.deselectRow(at: jobsTabelView.indexPathForSelectedRow!, animated: true)
    ////
    ////            }}
    //
    //    }
    
    //    func alertCutome(){
    //        let customAlert = self.storyboard?.instantiateViewController(withIdentifier: "CustomAlertID") as! CustomAlertView
    //              customAlert.providesPresentationContextTransitionStyle = true
    //              customAlert.definesPresentationContext = true
    //              customAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
    //              customAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
    //        customAlert.delegate = self as? CustomAlertViewDelegate
    //              self.present(customAlert, animated: true, completion: nil)
    //        customAlert.serviceEmail = servicesEmail [(jobsTabelView.indexPathForSelectedRow?.row)!]
    //        customAlert.titleText = jobsArray [(jobsTabelView.indexPathForSelectedRow?.row)!] // take title text to put it in new order page ..
    //            customAlert.costText = pricesArray[(jobsTabelView.indexPathForSelectedRow?.row)!]// take cost text to put it in new order page ..
    //        customAlert.desc = descriptionArray [(jobsTabelView.indexPathForSelectedRow?.row)!]
    //        // take description
    //                  //   customAlert.emailForCustomer = email // can replce it with get email current user in ORDER CODE ?
    //                     customAlert.sectionNeme = globalText // to save section name in order database
    //                     customAlert.sectionImg = globalImage // I don't know why I write It >>!
    //        //////////////////////
    //                     MyVirable.title = jobsArray [(jobsTabelView.indexPathForSelectedRow?.row)!]
    //                     MyVirable.cost = pricesArray [(jobsTabelView.indexPathForSelectedRow?.row)!]
    //                     MyVirable.desciption = descriptionArray [(jobsTabelView.indexPathForSelectedRow?.row)!]
    //          }
    
}



class ServiceTabelViewCell : UITableViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        self.backgroundColor = UIColor.clear
    }
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
}




struct MyVirable {
    static var cost = ""
    static var title = ""
    static var desciption = ""
}


