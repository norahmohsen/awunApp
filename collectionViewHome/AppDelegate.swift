//
//  AppDelegate.swift
//  collectionViewHome
//
//  Created by Norah on 19/09/2019.
//  Copyright © 2019 Nourah. All rights reserved.
//

import UIKit
import Realm
import RealmSwift
import IQKeyboardManagerSwift
import UserNotifications
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    lazy var realm:Realm = {
                 return try! Realm()
             }()
    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        IQKeyboardManager.shared.enable = true
        
         let config = Realm.Configuration(
                        schemaVersion: 10,
                        migrationBlock: { migration, oldSchemaVersion in
                            
                            if (oldSchemaVersion < 10) {
                                // Nothing to do!
                                
                            }
                    })
               Realm.Configuration.defaultConfiguration = config
                    
                    //        let configCheck = Realm.Configuration();
                    //        let configCheck2 = Realm.Configuration.defaultConfiguration;
                    //        let schemaVersion = configCheck.schemaVersion
                    //        print("Schema version \(schemaVersion) and configCheck2 \(configCheck2.schemaVersion)")
                let configCheck = Realm.Configuration();
                    do {
                        let fileUrlIs = try schemaVersionAtURL(configCheck.fileURL!)
                       print("schema version(file:///Users/raniasaad/Library/Developer/CoreSimulator/Devices/25CFA5A0-B9FA-454F-A7CC-39BE35590602/data/Containers/Data/Application/EE365845-0095-4D14-A76B-8F7A7677E2A0/Documents/default.realm)")
                    } catch  {
                        print(error)
                    }
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert , .badge , .sound]) {
            (granted ,error) in
            if granted {
                print ("User gave permissions for local notification")
            }
        }
        
        
        
        let BarButtonItemAppearance = UIBarButtonItem.appearance()
        BarButtonItemAppearance.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.clear], for: .normal)
        
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
        
        //**************
//        let config = Realm.Configuration(
//                 schemaVersion: 3,
//                 migrationBlock: { migration, oldSchemaVersion in
//
//                     if (oldSchemaVersion < 3) {
//                         // Nothing to do!
//
//                     }
//             })
//        Realm.Configuration.defaultConfiguration = config
//
//             //        let configCheck = Realm.Configuration();
//             //        let configCheck2 = Realm.Configuration.defaultConfiguration;
//             //        let schemaVersion = configCheck.schemaVersion
//             //        print("Schema version \(schemaVersion) and configCheck2 \(configCheck2.schemaVersion)")
//         let configCheck = Realm.Configuration();
//             do {
//                 let fileUrlIs = try schemaVersionAtURL(configCheck.fileURL!)
//                print("schema version(file:///Users/raniasaad/Library/Developer/CoreSimulator/Devices/25CFA5A0-B9FA-454F-A7CC-39BE35590602/data/Containers/Data/Application/EE365845-0095-4D14-A76B-8F7A7677E2A0/Documents/default.realm)")
//             } catch  {
//                 print(error)
             }
        
        //**********
//
//        let currentUsers = realm.objects(CurrentUser.self)
//        if(currentUsers == nil){
//            LoginViewController.userStatus = 0
//            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refresh"), object: nil, userInfo: nil)
//
////            let signUpVCCustomer = storyboard?.instantiateViewController(withIdentifier: "customerHome") as? ViewController
////
////            self.navigationController?.pushViewController(signUpVCCustomer!, animated: true)
//
//            let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//            let initialViewControlleripad : UIViewController = mainStoryboardIpad.instantiateViewController(withIdentifier: "customerHome") as! ViewController
//            self.window = UIWindow(frame: UIScreen.main.bounds)
//            self.window?.rootViewController = initialViewControlleripad
//            self.window?.makeKeyAndVisible()
//
//        }//if
//        else if (currentUsers.first?.user_status == 1){ // current is customer
//            LoginViewController.userStatus = 1
//            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refresh"), object: nil, userInfo: nil)
//
//           let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//            let initialViewControlleripad : UIViewController = mainStoryboardIpad.instantiateViewController(withIdentifier: "customerHome") as! ViewController
//            self.window = UIWindow(frame: UIScreen.main.bounds)
//            self.window?.rootViewController = initialViewControlleripad
//            self.window?.makeKeyAndVisible()
//
//
//        } else if (currentUsers.first?.user_status == 2){ // current is provider
//            LoginViewController.userStatus = 2
//            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refresh"), object: nil, userInfo: nil)
//
//            let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//            let initialViewControlleripad : UIViewController = mainStoryboardIpad.instantiateViewController(withIdentifier: "HomeViewControllerPerovider") as! HomeViewController
//            self.window = UIWindow(frame: UIScreen.main.bounds)
//            self.window?.rootViewController = initialViewControlleripad
//            self.window?.makeKeyAndVisible()
//
//        }//else if
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
  



