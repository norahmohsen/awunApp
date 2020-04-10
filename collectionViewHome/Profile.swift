//
//  Profile.swift
//  collectionViewHome
//
//  Created by Sarah on 10/03/1441 AH.
//  Copyright © 1441 Nourah. All rights reserved.
//

//
//  Profile.swift
//  collectionViewHome
//
//  Created by Njla on 10/03/1441 AH.
//  Copyright © 1441 Nourah. All rights reserved.
//

import Realm
import RealmSwift
import UIKit

class Profile : UIViewController {
    //comment outlet
    @IBOutlet weak var ProfileName: UITextField!
    
    @IBOutlet weak var ProfileEmail: UITextField!
    
    @IBOutlet weak var EditButton: UIBarButtonItem!
    
  
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    @IBOutlet weak var ProfilePassword: UITextField!
    
    
    @IBOutlet weak var ProfileNumber: UITextField!
    
     
    // profile info
    var PName : String?
    var PNumber : String?
    var PLocation : String?
    var PEmail : String?
    var PPassword : String?
    
  
    let migrationBlock: MigrationBlock = { migration, oldSchemaVersion in
        //Leave the block empty
    }
    lazy var realm:Realm = {
        Realm.Configuration.defaultConfiguration = Realm.Configuration(schemaVersion: 15, migrationBlock: migrationBlock)
        return try! Realm()
    }()
    
    //    let realm = try! Realm()
    override func viewDidLoad() {
        //getting my location where
       
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        self.view.generalGradiantView()
        
        //finding current
        self.view.addGestureRecognizer((self.revealViewController()?.panGestureRecognizer() ?? nil)!)
        var currentUsers = realm.objects(CurrentUser.self)
        let userStatus = currentUsers.first?.user_status
        let userEmail = currentUsers.first?.user_email
        
        
        
        menuButton.target = self.revealViewController()
        menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
        self.view.addGestureRecognizer((self.revealViewController()?.panGestureRecognizer() ?? nil)!)
        //        revealViewController()?.panGestureRecognizer()
        //if 1==> customer
        if  userStatus == 1 {
            let findCustomer = realm.object(ofType: Customer.self, forPrimaryKey: userEmail)
            
            //retreavireee cutomer info
            
            PName =   findCustomer?.name
            PEmail =  findCustomer?.email
            PPassword =   findCustomer?.password
            // findCustomer?.location
            PNumber =  findCustomer?.phoneNumber
            
            ProfileName.text = PName
            ProfileEmail.text = PEmail
            //needs fixing
            ProfilePassword.text = "*********"
            ProfileNumber.text = PNumber
            
        }
        
        if  userStatus == 2 {
            let findProvider = realm.object(ofType: Provider.self, forPrimaryKey: userEmail)
            
            //retreavireee cutomer info
            
            PName =  findProvider?.name
            PEmail =  findProvider?.email
            PPassword =     findProvider?.password
            PNumber =     findProvider?.phoneNumber
            
            
            ProfileName.text = PName
            ProfileEmail.text = PEmail
            //need fixing
            ProfilePassword.text = "*********"
            ProfileNumber.text = PNumber
            
        }
        
        
    }
    //userStatususerStatususerStatususerStatususerStatususerStatususerStatususerStatususerStatususerStatususerStatususerStatususerStatususerStatususerStatususerStatususerStatususerStatus
    //if 2==> provider
    
    
}
