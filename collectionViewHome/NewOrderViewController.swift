//
//  NewOrderViewController.swift
//  collectionViewHome
//
//  Created by Rania Saad on 09/02/1441 AH.
//  Copyright © 1441 Nourah. All rights reserved.
//

import UIKit
import RealmSwift
class NewOrderViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    static var myLongtude = Double()
    static var myLatitude = Double()
    static var long1 = 0.0
    static var lat1 = 0.0
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @IBAction func xButton(_ sender: Any) {
        ServiceForCustomerViewController.costText = ""
        ServiceForCustomerViewController.titleText = ""
        ServiceForCustomerViewController.providerEmail = ""
        ServiceForCustomerViewController.desc = ""
        dismiss(animated: true, completion: nil)
    }
//    var emailForCustomer = ""
//    var titleText:String!
//    var costText: String?
//    var desc: String?
    var globalName = ""
    var globalImg:UIImage? = nil
    
    
    let migrationBlock: MigrationBlock = { migration, oldSchemaVersion in
        //Leave the block empty
    }
    
    lazy var realm:Realm = {
        Realm.Configuration.defaultConfiguration = Realm.Configuration(schemaVersion: 15, migrationBlock: migrationBlock)
        return try! Realm()
    }()
    var dayArraylist = ["Sunday" , "Sunday" , "Monday" , "Tuesday" , "Wednesday" , "Thursday" , "Friday" , "Saturday"]
    var hourArraylist = ["6 AM" , "7 AM" , "8 AM" , "9 AM" , "10 AM" , "11 AM" , "12 PM" , "1 PM" , "2 PM" , "3 PM" , "4 PM" , "5 PM" , "6 PM" , "7 PM" , "8 PM" , "9 PM" , "10 PM" , "11 PM"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        XLocation.shared.getMyLocation()
        
        XLocation.shared.gotLocation = {
            print("Long ",XLocation.shared.longtude)
            print("Lat ",XLocation.shared.latitude)
            NewOrderViewController.myLongtude = XLocation.shared.longtude
            NewOrderViewController.myLatitude = XLocation.shared.latitude
        }
        
        requestOutlet.layer.cornerRadius = 20
        dayList.isHidden = true
        hourList.isHidden = true
        dayList.delegate = self
        dayList.dataSource = self
        hourList.delegate = self
        hourList.dataSource = self
        commentTextField.underlined()
        dayTextField.underlined()
        hourTextField.underlined()
        //        locationField.underlined()
        titleLabel.text = ServiceForCustomerViewController.titleText
        print (titleLabel.text)
        costLabel.text = ServiceForCustomerViewController.costText
        descriptionLabel.text = ServiceForCustomerViewController.desc
    }
    
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var orderLabel: UILabel!
    @IBOutlet weak var newLabel: UILabel!
    
    @IBOutlet weak var requestOutlet: UIButton!
    @IBOutlet weak var hourList: UIPickerView!
    @IBOutlet weak var dayList: UIPickerView!
    @IBOutlet weak var hourTextField: UITextField!
    @IBOutlet weak var dayTextField: UITextField!
    
    @IBOutlet weak var locationField: UITextField!
    // شلت الل،كيشن فيلد
    
    @IBAction func locationImage(_ sender: Any) {
    }
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        if ( pickerView == self.dayList){
            return dayArraylist.count}
        else{
            return hourArraylist.count}
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if ( pickerView == dayList){
            self.view.endEditing(true)
            return dayArraylist[row]}
        else {
            self.view.endEditing(true)
            return hourArraylist[row]}
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if( pickerView == dayList){
            self.dayTextField.text = self.dayArraylist[row]
            self.dayList.isHidden = true}
        else {
            self.hourTextField.text = self.hourArraylist[row]
            self.hourList.isHidden = true
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == self.dayTextField {
            self.dayList.isHidden = false
            //if you don't want the users to se the keyboard type:
            textField.endEditing(true)
        }
        else if textField == self.hourTextField {
            self.hourList.isHidden = false
            //if you don't want the users to se the keyboard type:
            textField.endEditing(true)
        }
    }
    
    @IBAction func requestButton(_ sender: UIButton) {
        if  ( dayTextField.text!.count == 0 ){
            
            var alert : UIAlertView = UIAlertView(title: "Oops!", message: "Please Select the day",
                                                  delegate: nil, cancelButtonTitle: "OK")
            alert.show()
            
            
        }
        else if ( hourTextField.text!.count == 0){
            var alert : UIAlertView = UIAlertView(title: "Oops!", message: " please Select the hour",
                                                  delegate: nil, cancelButtonTitle: "OK")
            alert.show()
        } // end if for cost
            
        else if (NewOrderViewController.lat1 == 0.0 || NewOrderViewController.long1 == 0.0){
            var alert : UIAlertView = UIAlertView(title: "Oops!", message: " please fill your order's location",
                                                  delegate: nil, cancelButtonTitle: "OK")
            alert.show()
        } // end if for cost
            
        else {
            var dateTest = NSDate()
            let dateFormatter = DateFormatter()
            dateFormatter.timeStyle = .full
            
            let newOrder = Order()
            let time = hourTextField.text
            let date = dayTextField.text
            //            newOrder.orderLocation = locationField.text
            
            newOrder.lat = NewOrderViewController.lat1
            newOrder.long = NewOrderViewController.long1
            newOrder.hour = time
            newOrder.day = date
            newOrder.customerEmail = realm.objects(CurrentUser.self)[0].user_email // 1
            newOrder.time = dateFormatter.string(from: dateTest as Date)
            newOrder.Date = NSDate()
            newOrder.orderStatus = 0
            newOrder.orderNumber = incrementID()
            newOrder.orderComment = commentTextField.text
            newOrder.servieceTitle = titleLabel.text
            newOrder.servieceDescription = descriptionLabel.text
            newOrder.cost = costLabel.text
            // new EmailProvider serviceID ....
            // now we only have this sequence : !!!!!!
            let serviceFound = realm.objects(Serviece1.self)
            for i in  0..<serviceFound.count{
                var titleFound = String (serviceFound[i].servieceTitle!)
                print(titleFound)
                print(MyVirable.title)
                
                print (titleFound == MyVirable.title)
                
                var costFound : String  = String (serviceFound [i].cost) + " SAR"
//                print (costFound)
//                print(MyVirable.cost)
//                print (costFound == MyVirable.cost)
                let descrptionFound = String (serviceFound[i].servieceDescription!)
//                print (descrptionFound)
//                print (descrptionFound == MyVirable.desciption)
//                print(MyVirable.desciption)
                newOrder.providerEmail = ServiceForCustomerViewController.providerEmail

                if(titleFound.isEqual(newOrder.servieceTitle) && costFound.isEqual(newOrder.cost ) && (descrptionFound.isEqual (newOrder.servieceDescription)) ){
                  print("TRueeeee")
                    newOrder.servieceID = serviceFound[i].servieceID
                    newOrder.providerEmail = ServiceForCustomerViewController.providerEmail
                    break
                }
                else{
                    print("I'm False!!!!!!!!!!")
                }
            }
            try? realm.write {
                realm.add(newOrder)
            } //end add service

            showAlert()
        }
        
    }
    
    func incrementID() -> Int {
        let realm = try! Realm()
        return (realm.objects(Order.self).max(ofProperty: "orderNumber") as Int? ?? 0) + 1
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "", message: "New Order was created Sucssfully",         preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { _ in
            //Ok Action
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "RevealID")
            vc?.modalPresentationStyle = .fullScreen
            vc?.modalTransitionStyle = .crossDissolve
            self.present(vc!, animated: true, completion: nil)
            
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
}
