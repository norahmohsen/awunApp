//
//  CustomAlertViewController.swift
//  collectionViewHome
//
//  Created by Norah on 03/11/2019.
//  Copyright © 2019 Nourah. All rights reserved.
//

import UIKit
import RealmSwift

//protocol CustomAlertViewDelegate: class {
//    func okButtonTapped()
////     func okButtonTapped(selectedOption: String, textFieldValue: String)
//    func cancelButtonTapped()
//}

class CustomAlertView: UIViewController {
    
    var serviceEmail = "" 
    var sectionNeme = ""
    var sectionImg :UIImage? = nil
    
    let migrationBlock: MigrationBlock = { migration, oldSchemaVersion in
        //Leave the block empty
    }
    
    lazy var realm:Realm = {
        Realm.Configuration.defaultConfiguration = Realm.Configuration(schemaVersion: 15, migrationBlock: migrationBlock)
        return try! Realm()
    }()
    //outlets
    @IBOutlet weak var alertViewOutlet: UIView!
    @IBOutlet weak var serviceTitleOutlet: UILabel!
    @IBOutlet weak var providerImgOutlet: UIImageView!
    @IBOutlet weak var providerNameOutler: UILabel!
    @IBOutlet weak var rankingStar1Outlet: UIImageView!
    @IBOutlet weak var rankingStar2Outlet: UIImageView!
    @IBOutlet weak var rankingStar3Outlet: UIImageView!
    @IBOutlet weak var rankingStar4Outlet: UIImageView!
    @IBOutlet weak var rankingStar5Outlet: UIImageView!
    @IBOutlet weak var newOrderButtonOutlet: UIButton!
    @IBOutlet weak var cancelButtonOutlet: UIButton!
    
    //    var delegate: CustomAlertViewDelegate?
    let alertViewGrayColor = UIColor(red: 224.0/255.0, green: 224.0/255.0, blue: 224.0/255.0, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
        setupView()
        animateView()
        
    }
    
    @objc func dismissAlert() {
        UIView.animate(withDuration: 0.2) {
            self.dismiss(animated: true, completion: nil)
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.layoutIfNeeded()
        //        cancelButtonOutlet.addBorder(side: .Top, color: alertViewGrayColor, width: 1)
        //        cancelButtonOutlet.addBorder(side: .Right, color: alertViewGrayColor, width: 1)
        //        newOrderButtonOutlet.addBorder(side: .Top, color: alertViewGrayColor, width: 1)
    }
    
    func setupView() {
        alertViewOutlet.layer.cornerRadius = 15
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        serviceTitleOutlet.text = ServiceForCustomerViewController.titleText
        let ProviderFound = realm.objects(Provider.self)
        //        print(ServiceForCustomerViewController.providerEmail)
        print("mmmm")
        for i in  0..<ProviderFound.count{
            
            if (ProviderFound[i].email == ServiceForCustomerViewController.providerEmail){
                providerNameOutler.text = ProviderFound[i].name
            }
        }
    }
    
    func animateView() {
        alertViewOutlet.alpha = 0;
        self.alertViewOutlet.frame.origin.y = self.alertViewOutlet.frame.origin.y + 50
        UIView.animate(withDuration: 0.4, animations: { () -> Void in
            self.alertViewOutlet.alpha = 1.0;
            self.alertViewOutlet.frame.origin.y = self.alertViewOutlet.frame.origin.y - 50
        })
    }
    
    @IBAction func cancelButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func newOrderButtonAction(_ sender: Any) {
        
        // here we should go to create new order page
        if(LoginViewController.userStatus == 1){
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "newOrderID")
            self.present(vc!, animated: true, completion: nil)
            
        }
        else {
            let alert : UIAlertView = UIAlertView(title: "Oops!", message: "Please signup to create new order or login if you have account",
                                                  delegate: nil, cancelButtonTitle: "OK")
            alert.show()
        }
//
//        UIView.animate(withDuration: 0.1, animations: {
//
//            self.dismiss(animated: true, completion: nil)
//        }) { (true) in
//            self.performSegue(withIdentifier: "newOrderSegue", sender: nil)
//
//        }
        
        
        
        ///
        
        //        if let destination = segue.destination as? NewOrderViewController {
        //
        //        }
        //                destination.titleText = jobsArray [(jobsTabelView.indexPathForSelectedRow?.row)!]
        //                print(destination.titleText)
        //                destination.costText = pricesArray [(jobsTabelView.indexPathForSelectedRow?.row)!]
        //
        //                destination.desc = descriptionArray [(jobsTabelView.indexPathForSelectedRow?.row)!]
        //                destination.emailForCustomer = email
        //                destination.globalName = globalText
        //                destination.globalImg = globalImage
        //                MyVirable.title = jobsArray [(jobsTabelView.indexPathForSelectedRow?.row)!]
        //                MyVirable.cost = pricesArray [(jobsTabelView.indexPathForSelectedRow?.row)!]
        //                MyVirable.desciption = descriptionArray [(jobsTabelView.indexPathForSelectedRow?.row)!]
        //                jobsTabelView.deselectRow(at: jobsTabelView.indexPathForSelectedRow!, animated: true)
        //
        //            }
        ///
        //        self.dismiss(animated: true, completion: nil)
    }
    
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //        let nextVC = segue.destination as? NewOrderViewController
    //        nextVC?.titleText = titleText
    //        nextVC?.costText = costText
    //        nextVC?.desc = desc
    //        nextVC?.emailForCustomer = emailForCustomer // i'm not sure about this *WArning*
    //
    //    }
}
