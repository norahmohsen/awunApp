//
//  DetaildJobViewController.swift
//  AwunProject
//
//  Created by Norah on 23/09/2019.
//  Copyright © 2019 Nourah. All rights reserved.
//

import UIKit
import RealmSwift
class DetaildJobViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {
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
    //["$1", "$2", "$3", "$4", "$5","$6"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jobsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "jobsCell", for: indexPath) as! JobsTabelViewCell
        cell.titleLabel.text = jobsArray[indexPath.row] as! String
        cell.priceLabel.text = pricesArray[indexPath.row] as! String
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let currentCellTxt = jobsTabelView.cellForRow(at: indexPath)! as? JobsTabelViewCell
        let title1 = currentCellTxt?.titleLabel?.text
        
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            // delete item at indexPath
            let alert = UIAlertController(title: "Would you like to delete this service ?", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                
                
                var services = self.realm.objects(Serviece1.self)
                for i  in 0..<services.count {
                    var titleFound = String (services[i].servieceTitle!)
                    if(titleFound.isEqual(title1)){
                        try! self.realm.write {
                            self.realm.delete(services[i])
                        }
                        
                        
                    }
                    
                }
                
                tableView.beginUpdates()
                self.jobsArray.remove(at: indexPath.row)
                self.pricesArray.remove(at: indexPath.row)
                
                tableView.deleteRows(at: [indexPath], with: .fade)
                tableView.endUpdates()
                tableView.reloadData()
            }))
            
            self.present(alert, animated: true)
            
        }
        return [delete]
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
    
    
    
    
    
    
    
    
    
    //
    @IBOutlet weak var viewAll: UIView!
    //
    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var addIcon: UIImageView!
    @IBOutlet weak var jobsTabelView: UITableView!
    @IBOutlet weak var label: UILabel!
    var globalImage:UIImage? = nil
    var globalText = ""
    var email = ""
    
    @IBAction func addServiceButton(_ sender: UIButton) {
        
        performSegue(withIdentifier: "addNewServiceSegue", sender: nil)
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as? AddServiceViewController
        
        nextVC?.globalName = globalText
        nextVC?.globalImage0 = globalImage
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(refreshTableData), name: NSNotification.Name(rawValue: "addService"), object: nil)
    }
    
    @objc func refreshTableData() {
        jobsArray.removeAll()
        pricesArray.removeAll()
        getTableData()
        jobsTabelView.reloadData()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        
        print(Realm.Configuration.defaultConfiguration.fileURL)
        jobsTabelView.backgroundColor = .clear
        //cellOutlet.setGradientBackground(colorOne: UIColor(hue: 0.0778, saturation: 0.06, brightness: 1, alpha: 1.0) , colorTwo: UIColor(hue: 0.9972, saturation: 0, brightness: 1, alpha: 1.0))
        viewAll.setRadius(radius: CGFloat(signOf: 20, magnitudeOf: 20))
        
        let topColor = UIColor(red: 242.0 / 255.0, green: 177.0 / 255.0, blue: 124.0 / 255.0, alpha: 1.0)
        let bottomColor = UIColor(red: 1.0, green: 246.0 / 255.0, blue: 238.0 / 255.0, alpha: 1.0)
        view.setGradientBackground(colorOne: topColor, colorTwo: bottomColor)
        // label.text = ""
        img.image = globalImage
        label.text = globalText
        getTableData()
        
    }
    
    func getTableData(){
        var current = realm.objects(CurrentUser.self)
        var provider = current[0].user_email
        let services = realm.objects(Serviece1.self)
        for i in  0..<services.count {
            if (String(services[i].sectionName!) == globalText && String(services[i].providerEmail!) == String(provider)){
                print("True")
                var serviceName = services[i].servieceTitle!
                var serviceCost : String  = String (services [i].cost)
                var serviceCostElement : String =  serviceCost + " SAR"
                
                jobsArray.append(serviceName)
                pricesArray.append(serviceCostElement)
                
            }
            print("faaaaaalse")
        }
    }
    
}

extension UIView {
    func setRadius(radius: CGFloat? = nil) {
        self.layer.cornerRadius = radius ?? self.frame.width / 2;
        self.layer.masksToBounds = true;
        self.layer.shadowOffset = .zero
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 10
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.masksToBounds = false
        
        
    }
    
}

class JobsTabelViewCell : UITableViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        self.backgroundColor = UIColor.clear
        priceLabel.sizeToFit()
    }
    
    
    @IBOutlet weak var swipeIcon: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var trashIcon: UIImageView!
}


