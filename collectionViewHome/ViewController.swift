//
//  ViewController.swift
//  collectionViewHome
//  Created by Norah on 19/09/2019.
//  Copyright © 2019 Nourah. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIGestureRecognizerDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    static var selectedService = Int()
    
    let migrationBlock: MigrationBlock = { migration, oldSchemaVersion in
        //Leave the block empty
    }
    
    lazy var realm:Realm = {
        Realm.Configuration.defaultConfiguration = Realm.Configuration(schemaVersion: 15, migrationBlock: migrationBlock)
        return try! Realm()
    }()
    var customerEmail = ""
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "serviceCustomer") //as? ServiceForCustomerViewController
//        vc?.globalImage = ViewController.imagesArray[indexPath.row]
//        vc?.globalText = ViewController.array[indexPath.row]
//        vc?.email = customerEmail
        ViewController.selectedService = indexPath.row
        self.navigationController?.pushViewController(vc!, animated: true)
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.size.width / 2.2
        return CGSize(width: width, height: width)
    }
    
//    static func setGradient(viewWithGradient: UIView,
//                            backgroundColor: UIColor,
//                            gradientColors: [CGColor],
//                            locations:[NSNumber],
//                            boundsOfGradient:CGRect) {
//
//        if gradientColors.count != locations.count {
//            print("gradientColors and locations must have same size!")
//            return
//        }
//
//        viewWithGradient.backgroundColor = backgroundColor
//        let mask = CAGradientLayer()
//        mask.colors = gradientColors
//        mask.locations = locations
//        mask.frame = boundsOfGradient
//        viewWithGradient.layer.mask = mask
//    }
    
    ///
    //    private let imageView = UIImageView(image: UIImage(named: "menuPic.png"))
    private var shoulResize: Bool?
    ///
    @IBOutlet weak var collectionViewVae: UICollectionView!
    
    
    @objc func tappedImage(_ gesture:UITapGestureRecognizer ){
//        if(MyStatus.customerStatus == 0){
//
//            let signUpVCCustomer = storyboard?.instantiateViewController(withIdentifier: "signUpViewController") as? SignUpViewController
//
//            self.navigationController?.pushViewController(signUpVCCustomer!, animated: true)
//            print("YAYY")}
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionViewVae.backgroundColor = .clear
        self.view.generalGradiantView()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        menuButton.target = self.revealViewController()
        menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
        self.view.addGestureRecognizer((self.revealViewController()?.panGestureRecognizer() ?? nil)!)
        
        navigationItem.hidesBackButton = true
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain,target:nil,action: nil)
        //        self.title = "Find You a service"
        
        print(Realm.Configuration.defaultConfiguration.fileURL)
        revealViewController()?.panGestureRecognizer()
        setupUI()
        
        
        
        
        view.setGradientBackground(colorOne: UIColor(hue: 0.0778, saturation: 0.06, brightness: 1, alpha: 1.0) , colorTwo: UIColor(hue: 0.9972, saturation: 0, brightness: 1, alpha: 1.0))
        
        //Image View press
        
        
        // Do any additional setup after loading the view.
        collectionViewVae.delegate = self
        collectionViewVae.dataSource = self
        ///
        if UIDevice.current.orientation.isPortrait {
            shoulResize = true
        } else if UIDevice.current.orientation.isLandscape {
            shoulResize = false
        }
        ///
    }
    
   
    @IBOutlet var viewAll: UIView!
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        
//         let currentUsers = realm.objects(CurrentUser.self)
//        if currentUsers.count > 0 {
//            // there is a user
//            if currentUsers.last?.user_status == 1 {
//                let signUpVCCustomer = storyboard?.instantiateViewController(withIdentifier: "customerHome") as? ViewController
//                MyStatus.customerEmail = currentUsers.last!.user_email
//                self.navigationController?.pushViewController(signUpVCCustomer!, animated: true)
//            }
//            else {
//               // provider
//                let signUpVCCProvider = storyboard?.instantiateViewController(withIdentifier: "HomeViewControllerPerovider") as? HomeViewController
//                MyStatus.customerEmail = currentUsers.last!.user_email
//                self.navigationController?.pushViewController(signUpVCCProvider!, animated: true)
//            }
//        }
//        else {
//            //navigate to vsitor
//            //        if(MyStatus.customerStatus == 0){
//            //
//            let signUpVCCustomer = storyboard?.instantiateViewController(withIdentifier: "signUpViewController") as? SignUpViewController
//            
//            self.navigationController?.pushViewController(signUpVCCustomer!, animated: true)
//        }
//        
//    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return The number of rows in section.
        return ViewController.array.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //return A configured cell object.
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "proCell", for: indexPath) as! CollectionViewCell
        cell.label.text = ViewController.array[indexPath.row]
        cell.imageViewSection.image = ViewController.imagesArray[indexPath.row]
        return cell
    }
    
    
    
    // Create an array that contains our data
    static var array = ["House Keeping", "Baby Sitting", "Moving", "Assembly", "Handy Man","Painting"]
    static var imagesArray = [UIImage(named: "iconpic1.png")!,
                       UIImage(named: "iconpic2.png")!,
                       UIImage(named: "iconpic3.png")!,
                       UIImage(named: "iconpic4.png")!,
                       UIImage(named: "iconpic5.png")!,
                       UIImage(named: "iconpic6.png")!]
    
    
    private func setupUI() {
        title = "Find You a Service"
        
        guard let navigationBar = self.navigationController?.navigationBar else { return }
        
    }
    
    private func moveAndResizeImageForPortrait() {
        guard let height = navigationController?.navigationBar.frame.height else { return }
        
        let coeff: CGFloat = {
            let delta = height - Const.NavBarHeightSmallState
            let heightDifferenceBetweenStates = (Const.NavBarHeightLargeState - Const.NavBarHeightSmallState)
            return delta / heightDifferenceBetweenStates
        }()
        
        let factor = Const.ImageSizeForSmallState / Const.ImageSizeForLargeState
        
        let scale: CGFloat = {
            let sizeAddendumFactor = coeff * (1.0 - factor)
            return min(1.0, sizeAddendumFactor + factor)
        }()
        
        // Value of difference between icons for large and small states
        let sizeDiff = Const.ImageSizeForLargeState * (1.0 - factor) // 8.0
        
        let yTranslation: CGFloat = {
            /// This value = 14. It equals to difference of 12 and 6 (bottom margin for large and small states). Also it adds 8.0 (size difference when the image gets smaller size)
            let maxYTranslation = Const.ImageBottomMarginForLargeState - Const.ImageBottomMarginForSmallState + sizeDiff
            return max(0, min(maxYTranslation, (maxYTranslation - coeff * (Const.ImageBottomMarginForSmallState + sizeDiff))))
        }()
        
        let xTranslation = max(0, sizeDiff - coeff * sizeDiff)
        //
        //        imageView.transform = CGAffineTransform.identity
        //            .scaledBy(x: scale, y: scale)
        //            .translatedBy(x: xTranslation, y: yTranslation)
    }
    
}

extension ViewController {
    /// WARNING: Change these constants according to your project's design
    private struct Const {
        /// Image height/width for Large NavBar state
        static let ImageSizeForLargeState: CGFloat = 25
        /// Margin from right anchor of safe area to right anchor of Image
        static let ImageRightMargin: CGFloat = 16
        /// Margin from bottom anchor of NavBar to bottom anchor of Image for Large NavBar state
        static let ImageBottomMarginForLargeState: CGFloat = 15
        /// Margin from bottom anchor of NavBar to bottom anchor of Image for Small NavBar state
        static let ImageBottomMarginForSmallState: CGFloat = 15
        /// Image height/width for Small NavBar state
        static let ImageSizeForSmallState: CGFloat = 20
        /// Height of NavBar for Small state. Usually it's just 44
        static let NavBarHeightSmallState: CGFloat = 44
        /// Height of NavBar for Large state. Usually it's just 96.5 but if you have a custom font for the title, please make sure to edit this value since it changes the height for Large state of NavBar
        static let NavBarHeightLargeState: CGFloat = 44
        /// Image height/width for Landscape state
        static let ScaleForImageSizeForLandscape: CGFloat = 0.65
    }
    
    
}

struct MyStatus {
    static var customerStatus = 0
    static var providerEmail = ""
    static var customerEmail = ""
}
