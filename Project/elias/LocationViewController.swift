//
//  LocationViewController.swift
//  Project
//
//  Created by Elias Aguilera Yambay on 2020-07-30.
//  Copyright © 2020 Brandon Gallagher. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class LocationViewController: UIViewController, CLLocationManagerDelegate {
    
    
    
    @IBOutlet weak var MapView: MKMapView!
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
           locationManager.delegate = self
           //take permision from user
           locationManager.requestWhenInUseAuthorization()
           //acuracy of location
           locationManager.desiredAccuracy = kCLLocationAccuracyBest
           //start searching for location
           locationManager.startUpdatingLocation()
           MapView.showsUserLocation = true
        

        // Do any additional setup after loading the view.
    }
    
      // CCLocationManager is delivering all the locations
        func locationManager(_ manager: CLLocationManager, didUpdateLocations
            locations: [CLLocation]) {
            // Check for the first user's location
            
            if let location = locations.first {
                locationManager.stopUpdatingLocation()
                zoom(location)
    
            }
        
        }
        func zoom(_ location: CLLocation) {
             
            let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            
            let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
            
            let region =  MKCoordinateRegion(center: coordinate, span: span)
                  MapView.setRegion(region, animated: true)
            
            let pin = MKPointAnnotation()
            pin.coordinate = coordinate
            MapView.addAnnotation(pin)
                  }
        

}
