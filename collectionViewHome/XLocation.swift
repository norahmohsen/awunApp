//
//  XLocation.swift
//  MashgalApplication
//
//  Created by shaimaa on 28/08/1440 AH.
//  Copyright © 1440 shaimaa. All rights reserved.
//

import Foundation
import CoreLocation

class XLocation : NSObject , CLLocationManagerDelegate {
    
    static var shared = XLocation()
    
    var locationManager : CLLocationManager!
    
    func getMyLocation() {
        
        locationManager = CLLocationManager()
        
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.distanceFilter = kCLDistanceFilterNone
            locationManager.startUpdatingLocation()
        }
    }
    
    var longtude = Double()
    var latitude = Double()
    
    var gotLocation : (()->())?
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.longtude = locations[0].coordinate.longitude
        self.latitude = locations[0].coordinate.latitude
        print(longtude)
        print("laaaaaaaatt -----> \(latitude)")
        print("\(locations[0].coordinate.longitude),\(locations[0].coordinate.latitude)")
        gotLocation?()
        locationManager.stopUpdatingLocation()
        
        
    }
    
    func fetchCityAndCountry(from location: CLLocation, completion: @escaping (_ city: String?, _ country:  String?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            completion(placemarks?.first?.locality,
                       placemarks?.first?.country,
                       error)
        }
    }
}
