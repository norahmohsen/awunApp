//
//  ViewController.swift
//  collectionViewHome
//
//  Created by Norah on 19/09/2019.
//  Copyright © 2019 Nourah. All rights reserved.
//




import UIKit
import UserNotifications
class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIGestureRecognizerDelegate, UICollectionViewDelegateFlowLayout {
   
    var email = ""
    @IBOutlet weak var barMenu: UIBarButtonItem!
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetaildJobViewController") as? DetaildJobViewController
        vc?.globalImage = imagesArray[indexPath.row]
        vc?.globalText = array[indexPath.row]
        vc?.email = providerEmail
        
        self.navigationController?.pushViewController(vc!, animated: true)
        
        
    }
    
    static func setGradient(viewWithGradient: UIView,
                            backgroundColor: UIColor,
                            gradientColors: [CGColor],
                            locations:[NSNumber],
                            boundsOfGradient:CGRect) {
        
        if gradientColors.count != locations.count {
            print("gradientColors and locations must have same size!")
            return
        }
        
        viewWithGradient.backgroundColor = backgroundColor
        let mask = CAGradientLayer()
        mask.colors = gradientColors
        mask.locations = locations
        mask.frame = boundsOfGradient
        viewWithGradient.layer.mask = mask
    }
    var providerEmail = ""
    ///
    private var shoulResize: Bool?
    ///
    @IBOutlet weak var collectionViewVae: UICollectionView!
    @objc func tappedImage(_ gesture:UITapGestureRecognizer ){
        
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        self.view.generalGradiantView()
        
        barMenu.target = self.revealViewController()
        barMenu.action = #selector(SWRevealViewController.revealToggle(_:))
        
        self.view.addGestureRecognizer((self.revealViewController()?.panGestureRecognizer() ?? nil)!)
        
        navigationItem.hidesBackButton = true
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain,target:nil,action: nil)
        setupUI()
        
        
        view.setGradientBackground(colorOne: UIColor(hue: 0.0778, saturation: 0.06, brightness: 1, alpha: 1.0) , colorTwo: UIColor(hue: 0.9972, saturation: 0, brightness: 1, alpha: 1.0))
        
        //Image View press
        
        
        // Do any additional setup after loading the view.
        collectionViewVae.delegate = self
        collectionViewVae.dataSource = self
        ///
      
        ///
    }
 
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //        showImage(false)
    }
    @IBOutlet var viewAll: UIView!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //        showImage(true)
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return The number of rows in section.
        return array.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //return A configured cell object.
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "proCellProvider", for: indexPath) as! CollectionViewCellProvider
        cell.label.text = array[indexPath.row]
        cell.imageViewSection.image=imagesArray[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.size.width / 2.2
        return CGSize(width: width, height: width)
    }
    
    // Create an array that contains our data
    var array = ["House Keeping", "Baby Sitting", "Moving", "Assembly", "Handy Man","Painting"]
    var imagesArray = [UIImage(named: "iconpic1.png")!,
                       UIImage(named: "iconpic2.png")!,
                       UIImage(named: "iconpic3.png")!,
                       UIImage(named: "iconpic4.png")!,
                       UIImage(named: "iconpic5.png")!,
                       UIImage(named: "iconpic6.png")!]
    
    
    private func setupUI() {
       
        
        title = "Find Your Service"
        
     
        
    }
    
    
}

//extension HomeViewController {
//    /// WARNING: Change these constants according to your project's design
//    private struct Const {
//        /// Image height/width for Large NavBar state
//        static let ImageSizeForLargeState: CGFloat = 40
//        /// Margin from right anchor of safe area to right anchor of Image
//        static let ImageRightMargin: CGFloat = 16
//        /// Margin from bottom anchor of NavBar to bottom anchor of Image for Large NavBar state
//        static let ImageBottomMarginForLargeState: CGFloat = 12
//        /// Margin from bottom anchor of NavBar to bottom anchor of Image for Small NavBar state
//        static let ImageBottomMarginForSmallState: CGFloat = 6
//        /// Image height/width for Small NavBar state
//        static let ImageSizeForSmallState: CGFloat = 32
//        /// Height of NavBar for Small state. Usually it's just 44
//        static let NavBarHeightSmallState: CGFloat = 44
//        /// Height of NavBar for Large state. Usually it's just 96.5 but if you have a custom font for the title, please make sure to edit this value since it changes the height for Large state of NavBar
//        static let NavBarHeightLargeState: CGFloat = 96.5
//        /// Image height/width for Landscape state
//        static let ScaleForImageSizeForLandscape: CGFloat = 0.65
//    }
//
//
//}

