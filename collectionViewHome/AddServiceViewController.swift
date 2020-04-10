//
//  AddServiceViewController.swift
//  collectionViewHome
//
//  Created by Rania Saad on 06/02/1441 AH.
//  Copyright © 1441 Nourah. All rights reserved.
//

import UIKit
import RealmSwift

class AddServiceViewController : UIViewController {
    var globalName = ""
    var globalImage0:UIImage? = nil
    
    
    let migrationBlock: MigrationBlock = { migration, oldSchemaVersion in
        //Leave the block empty
    }
    
    lazy var realm:Realm = {
        Realm.Configuration.defaultConfiguration = Realm.Configuration(schemaVersion: 15, migrationBlock: migrationBlock)
        return try! Realm()
    }()
    override func viewDidLoad() {
        super .viewDidLoad()
        print(Realm.Configuration.defaultConfiguration.fileURL)
        view.setGradientBackground(colorOne: UIColor(hue: 0.0778, saturation: 0.06, brightness: 1, alpha: 1.0) , colorTwo: UIColor(hue: 0.9972, saturation: 0, brightness: 1, alpha: 1.0))
        
        
        addButtonOutlet.layer.cornerRadius = 20
        titleTextField.underlined()
        descriptionTextField.underlined()
        costTextField.underlined()
        costTextField.keyboardType = .asciiCapableNumberPad
        sectionNameLabel.text = globalName
    }
    @IBOutlet weak var addNewServiceLabel: UILabel!
    @IBOutlet weak var inLabel: UILabel!
    @IBOutlet weak var sectionNameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var costTextField: UITextField!
    @IBOutlet weak var addButtonOutlet: UIButton!
    
    
    @IBAction func addButton(_ sender: UIButton) {
        let decimalCharacters = CharacterSet.decimalDigits
        if(titleTextField.text!.count == 0){
            var alert : UIAlertView = UIAlertView(title: "Oops!", message: "Please enter your service title.",
                                                  delegate: nil, cancelButtonTitle: "OK")
            alert.show()
        } // end if for title
   
        else if (titleTextField.text!.contains("!")   || titleTextField.text!.contains("@") || titleTextField.text!.contains("#") || titleTextField.text!.contains("$") || titleTextField.text!.contains("%") || titleTextField.text!.contains("^") || titleTextField.text!.contains("&") || titleTextField.text!.contains("*") || titleTextField.text!.contains(")") || titleTextField.text!.contains("(") || titleTextField.text!.contains("-") || titleTextField.text!.contains("=") || titleTextField.text!.contains("+")) {
            var alert : UIAlertView = UIAlertView(title: "Oops!", message: "Please enter valid service title , the valid title shloudn't contain symbol",
                                                  delegate: nil, cancelButtonTitle: "OK")
            alert.show()
        }
            
        else if (descriptionTextField.text!.count == 0){
            var alert : UIAlertView = UIAlertView(title: "Oops!", message: "Please enter  a small description for  your service.",
                                                  delegate: nil, cancelButtonTitle: "OK")
            alert.show()
        } // end if for description
            
            
        else if (descriptionTextField.text!.contains("!")   || descriptionTextField.text!.contains("@") || descriptionTextField.text!.contains("#") || descriptionTextField.text!.contains("$") || descriptionTextField.text!.contains("%") || descriptionTextField.text!.contains("^") || descriptionTextField.text!.contains("&") || descriptionTextField.text!.contains("*") || descriptionTextField.text!.contains(")") || descriptionTextField.text!.contains("(") || descriptionTextField.text!.contains("-") || descriptionTextField.text!.contains("=") || descriptionTextField.text!.contains("+")) {
            var alert : UIAlertView = UIAlertView(title: "Oops!", message: "Please enter valid service description , the valid description shloudn't contain symbol",
                                                  delegate: nil, cancelButtonTitle: "OK")
            alert.show()
        }
        else if ( costTextField.text!.count == 0 && costTextField.text! != "0" ){
            var alert : UIAlertView = UIAlertView(title: "Oops!", message: "Please enter the cost for your service.",
                                                  delegate: nil, cancelButtonTitle: "OK")
            alert.show()
        } // end if for cost
            
        else {
            let emailProvider = realm.objects(CurrentUser.self)
            var emailP = String (emailProvider[0].user_email)
            var flag = false
            let servieceFound = realm.objects(Serviece1.self)
            for i in  0..<servieceFound.count{
                let titles = servieceFound[i].servieceTitle
                if (titles!.isEqual(titleTextField) && servieceFound[i].providerEmail!.isEqual(emailP)){
                    let alert : UIAlertView = UIAlertView(title: "Oops!", message: "you already have this  service.",
                                                          delegate: nil, cancelButtonTitle: "OK")
                    alert.show()
                    flag = true
                    break }
                
            }
            if (flag == false){
                let newService = Serviece1 ()
                let cost = costTextField.text
                newService.servieceTitle = titleTextField.text
                newService.servieceDescription = descriptionTextField.text
                newService.cost = Double (cost!)!
                newService.sectionName = globalName
                newService.providerEmail = emailP
                newService.servieceID = incrementID()
                try? realm.write {
                    realm.add(newService)
                }
                
            } //end add service
            
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "addService"), object: nil, userInfo: nil)
            
            self.navigationController?.popViewController(animated: true)
            
            // +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
            //            self.navigationController?.popViewController(animated: true)
            //            self.navigationController?.popToRootViewController(animated: <#T##Bool#>)
            //            self.dismiss(animated: true, completion: nil)
            
            
        }
        
    }
    func incrementID() -> Int {
        let realm = try! Realm()
        return (realm.objects(Serviece1.self).max(ofProperty: "servieceID") as Int? ?? 0) + 1
    }
    
    
}
