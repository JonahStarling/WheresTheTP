//
//  HomeViewController.swift
//  WheresTheTP
//
//  Created by Jonah Starling on 3/20/20.
//  Copyright © 2020 Jonah Starling. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class HomeViewController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate {
    
    static let locationManager = CLLocationManager()

    override func loadView() {
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.delegate = self
        mapView.isMyLocationEnabled = true
        do {
            // Set the map style by passing the URL of the local file.
            if let styleURL = Bundle.main.url(forResource: "style", withExtension: "json") {
                mapView.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
            } else {
                NSLog("Unable to find style.json")
            }
        } catch {
            NSLog("One or more of the map styles failed to load. \(error)")
        }
        view = mapView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getUserLocation()
    }
    
    func getUserLocation() {
        if !CLLocationManager.locationServicesEnabled() {
            getLocationPermission(locationManager: HomeViewController.locationManager)
        }
        
        if CLLocationManager.locationServicesEnabled() {
            HomeViewController.locationManager.delegate = self
            HomeViewController.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            HomeViewController.locationManager.startUpdatingLocation()
        }
    }
    
    func getLocationPermission(locationManager: CLLocationManager) {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func loadNearbyTP() {
        // TODO
        // This function should call the TPRepository and get the nearby TP
        // This will first get all the eligible nearby places from Google Places
        // Then the places ids are used to fetch the stock value from Firebase
    }
    
    func placeTapped() {
        // TODO
        // When a place is tapped we popup the place ui
    }
    
    func showPlace(place: TPPlace) {
        // TODO
        // This will animate in a TPPlace xib/nib (what is the difference?)
        // It will allow the user to say what the current state of the stock is
        // It will also show the name of the place and a few stats for that place like:
        // How many people have been there
        // How many people have clicked the different stock states
        // Future idea: A graph of time of day vs stock (that'd be cool)
    }

}

