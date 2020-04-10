import UIKit
import Realm
import RealmSwift
//??

//@available(iOS 13.0, *)
class SlideTabelViewController : UITableViewController {
    var slideArrayProvider = ["Profile","Home","Services" , "Notification" ,"Help Center","LogOut"]
    var slideArrayCustomer = ["Profile","Home","Orders","Help Center","LogOut"]
    var slideArray = ["SignUp","Home","Help Center"]
    
    var slideArrayProviderImage = [UIImage(named: "prof.png") , UIImage(named: "home.png") , UIImage(named: "order.png") ,   UIImage(named: "notification.png") , UIImage(named: "phone.png" ),UIImage(named:  "logout.png") ]
    
    var slideArrayCustomerImage =  [UIImage(named: "prof.png") , UIImage(named: "home.png") , UIImage(named: "order.png")  , UIImage(named: "phone.png" ),UIImage(named:  "logout.png") ]
    
    var slideArrayImage = [UIImage(named: "prof.png") , UIImage(named: "home.png") , UIImage(named: "phone.png" )]

    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("what is that???", LoginViewController.userStatus)
        if(LoginViewController.userStatus == 2){ //2 >> provider
            print("2222222222")
            return slideArrayProvider.count
        }
        else if (LoginViewController.userStatus == 1){ //1 >> customer
            print("1111111")
            return slideArrayCustomer.count
        }
        else { //0
            print("00000000")
            return slideArray.count
        }
    }
    
    @objc func refreshTableView() {
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(refreshTableView), name: NSNotification.Name(rawValue: "refresh"), object: nil)
        
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! menuCustomCell
//        cell.textLabel?.textColor = .white
        cell.label.textColor = .white
        if(LoginViewController.userStatus == 2){ //provider
            print("2222 hiiii")
            cell.label.text =  slideArrayProvider[indexPath.row]
            cell.img.image = slideArrayProviderImage[indexPath.row]
            //return cell
        }
        else if (LoginViewController.userStatus == 1){ // customer
            print("111111 hiiii")
            
            cell.label.text = slideArrayCustomer[indexPath.row]
            cell.img.image = slideArrayCustomerImage[indexPath.row]
            print (slideArrayCustomer[indexPath.row])
            //return cell
        }
        else {
            print("00000 hiiii")
            
            cell.label.text = slideArray[indexPath.row]
            cell.img.image = slideArrayImage[indexPath.row]
            //return cell
        }
        
        return cell
        
    }//tableView
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(LoginViewController.userStatus == 2){
            print ("slide di select 22222")
            performSegue(withIdentifier: slideArrayProvider[indexPath.row], sender: nil)
        }
        else if (LoginViewController.userStatus == 1){
            print ("slide di select 111111")
            
            performSegue(withIdentifier: slideArrayCustomer[indexPath.row], sender: nil)
        } else {
            print ("slide di select 00000")
            
            performSegue(withIdentifier: slideArray[indexPath.row], sender: nil)
        }
        
        
        
    }
    
}


class menuCustomCell : UITableViewCell {
    @IBOutlet weak var label : UILabel!
    @IBOutlet weak var img : UIImageView!
}

