//
//  mapViewController.swift
//  collectionViewHome
//
//  Created by Sarah on 30/03/1441 AH.
//  Copyright © 1441 Nourah. All rights reserved.
//
import UIKit
import GoogleMaps


class MapViewController: UIViewController {
    
    static var positionGlobal = CLLocationCoordinate2D() 
    
    let btn = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        GMSServices.provideAPIKey("AIzaSyDLUrUKqp9y93_bhWdc5YTQEbBiR4n-QdQ")
//        let camera = GMSCameraPosition.camera(withLatitude: Profile.myLatitude, longitude: Profile.myLongtude, zoom: 6.0)
        let camera = GMSCameraPosition.camera(withLatitude: 24.72340190085512, longitude: 46.63880221545696, zoom: 16)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        mapView.delegate = self
        
 
        
        mapView.addSubview(btn)
        mapView.bringSubviewToFront(btn)
        //        self.mapView(mapView, didLongPressAt: T##CLLocationCoordinate2D).
        // Creates a marker in the center of the map.
        //                let marker = GMSMarker()
        //                marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        //                marker.title = "Sydney"
        //                marker.snippet = "Australia"
        //                marker.map = mapView
        //
        
        setupButton()
    }
   
    
    func setupButton() {
        btn.backgroundColor = .purple
        btn.setTitle("Send Location", for: .normal)
        btn.layer.opacity = 0.8
        btn.layer.cornerRadius = 12
        btn.addTarget(self, action: #selector(sendLocation), for: .touchUpInside)
        view.addSubview(btn)
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        btn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        btn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        btn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        btn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    @objc func sendLocation() {
        print(NewOrderViewController.myLongtude)
        print(NewOrderViewController.myLatitude)
        
        
        //go back to interface
        
        let _ = self.navigationController?.popViewController(animated: true)
//        dismiss(animated: true, completion: nil)
        ///// here is the fun saving data to database 
    }
   
}


extension MapViewController: GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, didLongPressAt coordinate: CLLocationCoordinate2D) {
        // Custom logic here
        mapView.clear()
        let marker = GMSMarker()
        marker.position = coordinate
        MapViewController.positionGlobal = marker.position
//        marker.title = "I added this with a long tap"
//        marker.snippet = ""
        marker.map = mapView
        NewOrderViewController.myLongtude = coordinate.longitude
        NewOrderViewController.myLatitude = coordinate.latitude
        NewOrderViewController.long1 = coordinate.longitude
         NewOrderViewController.lat1 =  coordinate.latitude
        print(coordinate.latitude)
        print(coordinate.longitude)
        
    }
}
