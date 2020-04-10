//
// ViewController.swift
// awun
//
// Created by Rania Saad on 19/01/1441 AH.
// Copyright © 1441 Rania Saad. All rights reserved.
//

import UIKit
import RealmSwift
class LoginViewController: UIViewController, UITextFieldDelegate {
    
    //global var
    static var userStatus = Int()
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        
        return true
        
    }
    var emailInput: String?
    var passwordInput:String?
    
    //current
    var user_email: String?
    var user_status: Int?
    
    let migrationBlock: MigrationBlock = { migration, oldSchemaVersion in
        //Leave the block empty
    }
    
    lazy var realm:Realm = {
         Realm.Configuration.defaultConfiguration = Realm.Configuration(schemaVersion: 15, migrationBlock: migrationBlock)
              
        return try! Realm()
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.generalGradiantView()
        
        // Do any additional setup after loading the view.
        loginButtonOutlet.layer.cornerRadius = 20
        emailTextField.underlined()
        passwordTextField.underlined()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        
    }
    
    
    @IBOutlet weak var welcomeBackLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var forgetPasswordButton: UIButton!
    
    
    @IBOutlet weak var loginButtonOutlet: UIButton!
    @IBAction func loginButton(_ sender: UIButton) {
        
        
        
        if ((emailTextField.text!.count) == 0){
            var alert : UIAlertView = UIAlertView(title: "Oops!", message: "Please enter your Email.",
                                                  delegate: nil, cancelButtonTitle: "OK")
            alert.show()
            
        }else if !isValidEmail(testStr: emailTextField.text!){
            var alert : UIAlertView = UIAlertView(title: "Oops!", message: "Please enter your correct information.",
                                                  delegate: nil, cancelButtonTitle: "OK")
            alert.show()
            
        }else if ((passwordTextField.text!.count) == 0){
            var alert : UIAlertView = UIAlertView(title: "Oops!", message: "Please enter your password.",
                                                  delegate: nil, cancelButtonTitle: "OK")
            alert.show()
            
        }
            
            
            
            
        else {
            
            var user_status = 0
            
            if let findCustomer = realm.object(ofType: Customer.self, forPrimaryKey: emailTextField.text) {
                // customer
                if findCustomer.password == passwordTextField.text {
                    // navigate to customer home
                    user_status = findCustomer.status
                    
                    let signUpVCCustomer = storyboard?.instantiateViewController(withIdentifier: "customerHome") as? ViewController
                    MyStatus.customerEmail = emailTextField.text!
                    self.navigationController?.pushViewController(signUpVCCustomer!, animated: true)
                } // end of find customer
            }
            else if let findProvider = realm.object(ofType: Provider.self, forPrimaryKey: emailTextField.text) {
                if findProvider.password == passwordTextField.text {
                    // navigate to provider home
                    user_status = findProvider.status
                    let signUpVCCProvider = storyboard?.instantiateViewController(withIdentifier: "HomeViewControllerPerovider") as? HomeViewController
                                      MyStatus.customerEmail = emailTextField.text!
                                      self.navigationController?.pushViewController(signUpVCCProvider!, animated: true)
                    let orders = realm.objects(Order.self)
                    for i in 0..<orders.count{
                        if  (orders[i].providerEmail == findProvider.email && orders[i].orderStatus == 0){
                    let center = UNUserNotificationCenter.current()
                    let content = UNMutableNotificationContent()
                    content.title = "New Orders"
                            content.body =  findProvider.name! + " You have a new orders , check it in notification page"
                    content.sound = .default
                    let trigger = UNTimeIntervalNotificationTrigger (timeInterval: 15, repeats: false)
                    let request = UNNotificationRequest(identifier: "notification", content: content, trigger: trigger )
                    center.add(request){
                        (error) in
                        if error != nil {
                            print ("Error = \(error?.localizedDescription ?? "error local notification ")")
                        }
                    }
                            break
                    
                    }}

                } else{
                    let alert = UIAlertView(title: "", message: "invalid Email or Password  ",
                                                                          delegate: nil, cancelButtonTitle: "OK")
                                                  alert.show()
                }
               
            }
            else {
                // not registered
                
                let alert = UIAlertView(title: "", message: "invalid Email or Password  ",
                                        delegate: nil, cancelButtonTitle: "OK")
                alert.show()
            }
            
            
           
            //delte all currents if exist
            
            LoginViewController.userStatus = user_status
             NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refresh"), object: nil, userInfo: nil)
            print("user Status" ,LoginViewController.userStatus)
            
            let currentUsers = realm.objects(CurrentUser.self)
            try! realm.write {
                realm.delete(currentUsers)
            }
            
            //create current user
            let currentUserObject = CurrentUser()
            currentUserObject.user_email = emailTextField.text!
            currentUserObject.user_status = user_status
            
            try? realm.write {
                
                realm.add(currentUserObject)
                
            } //end add current user..
            
            
            
            
            
            
            ////********************/
            // let customers = realm.objects(Customer.self)
            //            for i in  0..<customers.count{
            //                let validEmail = customers[i].email
            //                if (validEmail.isEqual( emailTextField.text) && customers[i].password!.isEqual (passwordTextField!.text) ){
            //                    //
            //
            //                    //MyStatus.customerStatus = 1
            ////                    LoginViewController.userStatus = 1
            ////                    user_status = LoginViewController.userStatus
            //                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refresh"), object: nil, userInfo: nil)
            //
            //                    //create current user
            //                    let currentUserObject = CurrentUser()
            //                    currentUserObject.user_email = emailTextField.text!
            //                    currentUserObject.user_status = customers[i].status
            //
            //                    try? realm.write {
            //                        realm.add(currentUserObject)
            //
            //                    } //end add current user..
            //
            //                    let signUpVCCustomer = storyboard?.instantiateViewController(withIdentifier: "customerHome") as? ViewController
            //                    MyStatus.customerEmail = emailTextField.text!
            //                    self.navigationController?.pushViewController(signUpVCCustomer!, animated: true)
            //                    break
            //
            //                }
            //
            //                if (i == customers.count-1){
            //                    let lastCustomer = customers[i]
            //                    if (validEmail !=  emailTextField.text || lastCustomer.password != passwordTextField.text ){
            //                        let providers = realm.objects(Provider.self)
            //                        for i in  0..<providers.count{
            //                            let validEmail = providers[i].email
            //                            if (validEmail.isEqual( emailTextField.text) && providers[i].password!.isEqual (passwordTextField!.text) ){
            //
            //                                LoginViewController.userStatus = 2
            //                                user_status = LoginViewController.userStatus
            //                                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refresh"), object: nil, userInfo: nil)
            //
            //                                //create current user
            //                                let currentUserObject = CurrentUser()
            //                                currentUserObject.user_email = emailTextField.text!
            //                                currentUserObject.user_status = user_status!
            //
            //                                try? realm.write {
            //                                    realm.add(currentUserObject)
            //
            //                                } //end add current user..
            //
            //
            //                                let signUpVCCProvider = storyboard?.instantiateViewController(withIdentifier: "HomeViewControllerPerovider") as? HomeViewController
            //                                signUpVCCProvider?.providerEmail=emailTextField.text!
            //
            //                                MyStatus.providerEmail = emailTextField.text!
            //                                self.navigationController?.pushViewController(signUpVCCProvider!, animated: true)
            //                                print("YAYY")
            //                                break
            //
            //                            }
            //                            else if (i == providers.count-1){
            //                                var lastProvider = providers[i]
            //                                if(validEmail != emailTextField.text || lastProvider.password != passwordTextField.text || lastCustomer.email != emailTextField.text || lastCustomer.password != passwordTextField.text){
            //                                    let alert : UIAlertView = UIAlertView(title: "", message: "invalid Email or Password  ",
            //                                                                          delegate: nil, cancelButtonTitle: "OK")
            //                                    alert.show()}
            //
            //                            }}
            //
            //
            //
            //
            //
            //                    }
            //
            //                }
            //
            //            }
            
            
        }
        
        
    }
    
    
    
    
    
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        
        var emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: testStr)
        return result
    }
    func isValidPassword(testPass:String) -> Bool {
        let passwordRegex = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#$%^&*()\\-_=+{}|?>.<,:;~`’]{8,}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: testPass)
    }
    
    
    
    
    
    
    
}
extension UITextField {
    func underlined(){
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.lightGray.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
}
