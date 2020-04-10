//
//  SignUpProviderViewController.swift
//  collectionViewHome
//
//  Created by Rania Saad on 25/01/1441 AH.
//  Copyright © 1441 Nourah. All rights reserved.
//

import UIKit
import RealmSwift

// Start Class
class SignUpProviderViewController : UIViewController , UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        nameTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        numberTextField.resignFirstResponder()
        confirmPasswordTextField.resignFirstResponder()
        return true
        
    }
    var name:String?
    var email: String?
    var password:String?
    var number:String?
    
    /// var 's for current user
    var user_email: String?
    var user_status: Int?
    
    let migrationBlock: MigrationBlock = { migration, oldSchemaVersion in
        //Leave the block empty
    }
    
    lazy var realm:Realm = {
        
        Realm.Configuration.defaultConfiguration = Realm.Configuration(schemaVersion: 15, migrationBlock: migrationBlock)
        
        Realm.Configuration.defaultConfiguration = Realm.Configuration(schemaVersion: 15, migrationBlock: migrationBlock)
        
        
        return try! Realm()
    }()
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        revealViewController()?.panGestureRecognizer()
        view.generalGradiantView()
        
        signUpButtonOutlet.layer.cornerRadius = 20
        print(Realm.Configuration.defaultConfiguration.fileURL)
        
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
        
        
    } //end viewDidLoad ..
    
    
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    @IBOutlet weak var earnAsProviderLabel: UILabel!
    @IBOutlet weak var signUpButtonOutlet: UIButton!
    
    @IBOutlet weak var nameTextField: UITextField!
    
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var ConfirmPassword: UITextField!
    
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var alreadyHaveAccountLabel: UILabel!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signUpProviderButton(_ sender: UIButton) {
        
        let decimalCharacters = CharacterSet.decimalDigits
        if((nameTextField.text!.count) == 0) {
            var alert : UIAlertView = UIAlertView(title: "Oops!", message: "Please enter your first name.",
                                                  delegate: nil, cancelButtonTitle: "OK")
            alert.show()
            
        }//end if((nameTextField.text!.count) == 0) ..
            
        else if  ( nameTextField.text!.rangeOfCharacter(from:decimalCharacters) != nil ){
            
            var alert : UIAlertView = UIAlertView(title: "Oops!", message: "Please enter valid name , the valid name shloudn't contain numbers",
                                                  delegate: nil, cancelButtonTitle: "OK")
            alert.show()
            
            
        } // end if contain number
        else if ((emailTextField.text!.count) == 0){
            var alert : UIAlertView = UIAlertView(title: "Oops!", message: "Please enter your email id.",
                                                  delegate: nil, cancelButtonTitle: "OK")
            alert.show()
            
        }// end if ((emailTextField.text!.count) == 0)..
        else if !isValidEmail(testStr: emailTextField.text!){
            var alert : UIAlertView = UIAlertView(title: "Oops!", message: "Please enter your correct email id.",
                                                  delegate: nil, cancelButtonTitle: "OK")
            alert.show()
            
        }//end if !isValidEmail(testStr: emailTextField.text!)..
        else if ((passwordTextField.text!.count) == 0){
            var alert : UIAlertView = UIAlertView(title: "Oops!", message: "Please enter your password.",
                                                  delegate: nil, cancelButtonTitle: "OK")
            alert.show()
            
        }//end if ((passwordTextField.text!.count) == 0)..
        else if ((numberTextField.text!.count) == 0){
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
            
            
            //end if ((numberTextField.text!.count) == 0)..
        else{
            
            let emailSignupCustomer = realm.object(ofType: Customer.self, forPrimaryKey: emailTextField.text)
            let emailSignupProvider = realm.object(ofType: Provider.self, forPrimaryKey: emailTextField.text)
            //                let emailCurrentUser = realm.object(ofType: CurrentUser.self, forPrimaryKey: "")
            if emailSignupCustomer == nil && emailSignupProvider == nil{
                name = nameTextField.text
                email = emailTextField.text
                password = passwordTextField.text
                number = numberTextField.text
                
                let provider = Provider()
                provider.name = name
                provider.email=email!
                provider.password=password
                provider.phoneNumber=number
                provider.status = 2
                
                try? realm.write {
                    realm.add(provider)} //end add provider..
                // to Testing :
                LoginViewController.userStatus = 2
//                user_status = LoginViewController.userStatus
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refresh"), object: nil, userInfo: nil)
                
                
                //////
               let currentUsers = realm.objects(CurrentUser.self)
                try! realm.write {
               realm.delete(currentUsers)
               }
          
                //create current user
                let currentUserObject = CurrentUser()
                currentUserObject.user_email = email!
                currentUserObject.user_status = 2
                
                try? realm.write {
                    realm.add(currentUserObject)
                    
                } //end add current user..
                
              
                let signUpVCCProvider = storyboard?.instantiateViewController(withIdentifier: "HomeViewControllerPerovider") as? HomeViewController
                signUpVCCProvider?.providerEmail = emailTextField.text!
                MyStatus.providerEmail = emailTextField.text!
                self.navigationController?.pushViewController(signUpVCCProvider!, animated: true)
                print("YAYY")
                
              
            } //end if emailSignup ==nil..
            else {
                // to Testing :
                var alert : UIAlertView = UIAlertView(title: "User Registration!", message: "Email was exist",delegate: nil, cancelButtonTitle: "OK")
                alert.show()
            } //end else for primaryKey..
            
            
            
        }//end else..
        
    }//end signUp Action..
    
    
    
    
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        
        var emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: testStr)
        return result
    } // end isValidEmail func
    func isValidPassword(testPass:String) -> Bool {
        let passwordRegex = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#$%^&*()\\-_=+{}|?>.<,:;~`’]{8,}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: testPass)
    }
}

