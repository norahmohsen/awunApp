import UIKit
import Realm
import RealmSwift
import MessageUI

class HelpCenter: UIViewController  , MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var menuButtom: UIBarButtonItem!
    
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
    @IBAction func phoneIconButtonAction(_ sender: Any) {
        let number = URL(string: "telprompt://\(966550073366)")
        //        guard let number = URL(string: "telprompt://\(0550073366)") else { return }
        UIApplication.shared.open(number!)
    }
    
    @IBAction func phoneIconButtonAction2(_ sender: Any) {
        let number = URL(string: "telprompt://\(966550073366)")
        //        guard let number = URL(string: "telprompt://\(0550073366)") else { return }
        UIApplication.shared.open(number!)
    }
    @IBAction func phoneIconButtonAction3(_ sender: Any) {
        let number = URL(string: "telprompt://\(966550073366)")
        //        guard let number = URL(string: "telprompt://\(0550073366)") else { return }
        UIApplication.shared.open(number!)
    }
    @IBAction func emailButtonAction1(_ sender: Any) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["nourahchi@gmail.com"])
            mail.setSubject("Help Center")
            
            mail.setMessageBody("<p>How can we help you?</p>", isHTML: true)
            
            present(mail, animated: true)
        }
    }
    @IBAction func emailButtonAction2(_ sender: Any) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["nourahchi@gmail.com"])
            mail.setSubject("Help Center")
            
            mail.setMessageBody("<p>How can we help you?</p>", isHTML: true)
            
            present(mail, animated: true)
        }
    }
    @IBAction func emailButtonAction3(_ sender: Any) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["nourahchi@gmail.com"])
            mail.setSubject("Help Center")
            
            mail.setMessageBody("<p>How can we help you?</p>", isHTML: true)
            
            present(mail, animated: true)
        }
    }
    override func viewDidLoad() {
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        self.view.generalGradiantView()
        // save
        UserDefaults.standard.set("a@a.com", forKey: "email")
        
        
        //
        if let email = UserDefaults.standard.string(forKey: "email") {
            print("my email is : ",email)
        }
        
        menuButtom.target = self.revealViewController()
        menuButtom.action = #selector(SWRevealViewController.revealToggle(_:))
        self.view.addGestureRecognizer((self.revealViewController()?.panGestureRecognizer() ?? nil)!)
        //        revealViewController()?.panGestureRecognizer()
        
    }
}


class Services: UIViewController {
    override func viewDidLoad() {
        self.view.addGestureRecognizer((self.revealViewController()?.panGestureRecognizer() ?? nil)!)
        //        revealViewController()?.panGestureRecognizer()
        
    }
}

class Orderes: UIViewController {
    override func viewDidLoad() {
        self.view.addGestureRecognizer((self.revealViewController()?.panGestureRecognizer() ?? nil)!)
        //        revealViewController()?.panGestureRecognizer()
        
    }
}


class LogOut: UIViewController {
    override func viewDidLoad() {
        print("i am in viewDidload")
        self.view.addGestureRecognizer((self.revealViewController()?.panGestureRecognizer() ?? nil)!)
        //        revealViewController()?.panGestureRecognizer()
        
        let realm = try! Realm()
        print("realm is here")
        
        let currentUsers = realm.objects(CurrentUser.self)
         try! realm.write {
        realm.delete(currentUsers)
        }
        
        
        //
        ////        let deleteData = realm.object(ofType: CurrentUser.self,
        ////                                      forPrimaryKey: currentUsers[0].user_email)
        //        if currentUsers == nil {
        //            print("No data in DB")
        //        } else {
        ////            realm.shared.delete(deleteData!)
        ////            Realm.delete(deleteData!)
        ////            print(currentUsers.first!)
        //            try! realm.write {
        //                realm.delete(currentUsers)
        ////                realm.delete(currentUsers.last!)
        ////                for i in  0..<currentUsers.count{
        ////                    if(currentUsers[i] != nil){
        ////                        realm.delete(currentUsers[i])
        ////                    }
        ////                }
        //            }
        
        ///if yes?
        LoginViewController.userStatus = 0
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refresh"), object: nil, userInfo: nil)
        
        let signUpVCCustomer = storyboard?.instantiateViewController(withIdentifier: "customerHome") as? ViewController
        
        self.navigationController?.pushViewController(signUpVCCustomer!, animated: true)
        
        //if no ? dont
        var alert : UIAlertView = UIAlertView(title: "LogOut!", message: "you have logged out succesully",
                                              delegate: nil, cancelButtonTitle: "OK")
        alert.show()
        
        
        
    }//viewDidLoad
}// LogOut



