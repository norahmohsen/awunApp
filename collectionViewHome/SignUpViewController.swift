//
//  ViewController.swift
//  Register
//
//  Created by Njla on 19/01/1441 AH.
//  Copyright © 1441 Njla. All rights reserved.
//

import UIKit
import RealmSwift
class SignUpViewController: UIViewController,UITextFieldDelegate { // sign up customer
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    var name:String?
    var email: String?
    var password:String?
    var number:String?
    var confirmPassword:String?
    //current
    var user_email: String?
    var user_status: Int?
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        nameTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        numberTextField.resignFirstResponder()
        confirmPasswordTextField.resignFirstResponder()
        return true
        
    }
    // The location will be in profile not in sigup.
    //var location:String?
    
    let migrationBlock: MigrationBlock = { migration, oldSchemaVersion in
        //Leave the block empty
    }
    
    lazy var realm:Realm = {
        
       Realm.Configuration.defaultConfiguration = Realm.Configuration(schemaVersion: 15, migrationBlock: migrationBlock)
        
        Realm.Configuration.defaultConfiguration = Realm.Configuration(schemaVersion: 15, migrationBlock: migrationBlock)
        
        return try! Realm()
    }()
    
    @IBOutlet weak var signUpCustomerOutlet: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        menuButton.target = self.revealViewController()
        menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
        
        self.view.addGestureRecognizer((self.revealViewController()?.panGestureRecognizer() ?? nil)!)
        
        view.generalGradiantView()
        signUpCustomerOutlet.layer.cornerRadius = 20
        print(Realm.Configuration.defaultConfiguration.fileURL)
        
        //        signup.layer.cornerRadius = 20
        nameTextField.underlined()
        emailTextField.underlined()
        passwordTextField.underlined()
        numberTextField.underlined()
        confirmPasswordTextField.underlined()
        nameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        numberTextField.delegate = self
        confirmPasswordTextField.delegate = self
        // locationTextField.underlined()
        
    }
    
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var SignUPLable: UILabel!
    @IBOutlet weak var HaveAccountLable: UILabel!
    
    //    @IBOutlet weak var signup: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var numberTextField: UITextField!
    
    
    @IBOutlet weak var ConfirmPassword: UITextField!
    
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- Norah
    @IBAction func signUpButton(_ sender: UIButton) {
        
        let decimalCharacters = CharacterSet.decimalDigits
        if((nameTextField.text!.count) == 0) {
            var alert : UIAlertView = UIAlertView(title: "Oops!", message: "Please enter your first name.",
                                                  delegate: nil, cancelButtonTitle: "OK")
            alert.show()
            
        }
        else if  ( nameTextField.text!.rangeOfCharacter(from:decimalCharacters) != nil ){
            
            var alert : UIAlertView = UIAlertView(title: "Oops!", message: "Please enter valid name , the valid name shloudn't contain numbers",
                                                  delegate: nil, cancelButtonTitle: "OK")
            alert.show()
            
            
        } // end if contain number
        else if ((emailTextField.text!.count) == 0){
            var alert : UIAlertView = UIAlertView(title: "Oops!", message: "Please enter your email id.",
                                                  delegate: nil, cancelButtonTitle: "OK")
            alert.show()
            
        }else if !isValidEmail(testStr: emailTextField.text!){
            var alert : UIAlertView = UIAlertView(title: "Oops!", message: "Please enter your correct email id.",
                                                  delegate: nil, cancelButtonTitle: "OK")
            alert.show()
            
        }else if ((passwordTextField.text!.count) == 0){
            var alert : UIAlertView = UIAlertView(title: "Oops!", message: "Please enter your password.",
                                                  delegate: nil, cancelButtonTitle: "OK")
            alert.show()
            
        }else if ((numberTextField.text!.count) == 0){
            var alert : UIAlertView = UIAlertView(title: "Oops!", message: "Please enter your number.",
                                                  delegate: nil, cancelButtonTitle: "OK")
            alert.show()
            
        }
        else if((passwordTextField.text!.count) < 8){
            var alert : UIAlertView = UIAlertView(title: "Oops!", message: "Please your password should be 8 character at  least ",
                                                  delegate: nil, cancelButtonTitle: "OK")
            alert.show()
        }
        else if !isValidPassword(testPass: passwordTextField.text!){
            var alert : UIAlertView = UIAlertView(title: "Oops!", message: "Password must be at least 8 characters, and contain at least one upper case letter, one lower case letter, and one number",
                                                  delegate: nil, cancelButtonTitle: "OK")
            alert.show()
        }
            
            
        else if ((passwordTextField.text) != (ConfirmPassword.text)) {
            var alert : UIAlertView = UIAlertView(title: "Oops!", message: "Please make sure your password matches the confirm password field ",
                                                  delegate: nil, cancelButtonTitle: "OK")
            alert.show()
        }
        else if ((numberTextField.text!.count) < 10){
            var alert : UIAlertView = UIAlertView(title: "Oops!", message: "Please enter correct phone number, it must be 10 numbers.",
                                                  delegate: nil, cancelButtonTitle: "OK")
            alert.show()
            
            
        }
            
            
        else{
            // customer sign up
            let emailSignupCustomer = realm.object(ofType: Customer.self, forPrimaryKey: emailTextField.text)
            let emailSignupProvider = realm.object(ofType: Provider.self, forPrimaryKey: emailTextField.text)
            if emailSignupCustomer == nil && emailSignupProvider == nil{
                name = nameTextField.text
                guard let email = emailTextField.text else {return}
                password = passwordTextField.text
                number = numberTextField.text
                
                var customer = Customer()
                customer.name = name
                customer.email=email
                customer.password=password
                customer.phoneNumber=number
                customer.status = 1
                
                try? realm.write {
                    realm.add(customer)
                }
                // MyStatus.customerStatus = 1
                LoginViewController.userStatus = 1
//                user_status =  LoginViewController.userStatus
                
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refresh"), object: nil, userInfo: nil)
                
                
                let currentUsers = realm.objects(CurrentUser.self)
                 try! realm.write {
                realm.delete(currentUsers)
                }
                
              
                //create current user
                let currentUserObject = CurrentUser()
                currentUserObject.user_email = email
                currentUserObject.user_status = 1
                
                try? realm.write {
                    realm.add(currentUserObject)
                    
                } //end add current user..
                
                let signUpVCCustomer = storyboard?.instantiateViewController(withIdentifier: "customerHome") as? ViewController
                signUpVCCustomer!.customerEmail = email
//                MyStatus.customerEmail = emailTextField.text!
                
                self.navigationController?.pushViewController(signUpVCCustomer!, animated: true)
                
                
            }
            else {
                var alert : UIAlertView = UIAlertView(title: "User Registration!", message: "Email was exist",
                                                      delegate: nil, cancelButtonTitle: "OK")
                alert.show()
                /// if we have time 
            }
            
            
            
        }
        
    }
    
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        if(textField.returnKeyType == UIReturnKeyType.done)
        {
            textField .resignFirstResponder()
        }
        else
        {
            var txtFld : UITextField? = self.view.viewWithTag(textField.tag + 1) as? UITextField;
            txtFld?.becomeFirstResponder()
        }
        return true
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



