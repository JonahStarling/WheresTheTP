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
    
    var mapView: GMSMapView?
    
    static let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadMapView()
        loadDummyData()
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
    
    func loadDummyData() {
        let lat = 38.641919
        let lon = -90.261528
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: CLLocationDegrees(lat), longitude: CLLocationDegrees(lon))
        marker.userData = "testPlace"
        marker.map = mapView
    }
    
    func loadMapView() {
        let camera = GMSCameraPosition.camera(withLatitude: 38.640933, longitude: -90.262504, zoom: 4.0)
        let gmsMapView = GMSMapView.map(withFrame: view.frame, camera: camera)
        gmsMapView.delegate = self
        gmsMapView.isMyLocationEnabled = true
        gmsMapView.setMinZoom(4.0, maxZoom: 16.0)
        gmsMapView.isBuildingsEnabled = false
        do {
            // Set the map style by passing the URL of the local file.
            if let styleURL = Bundle.main.url(forResource: "style", withExtension: "json") {
                gmsMapView.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
            } else {
                NSLog("Unable to find style.json")
            }
        } catch {
            NSLog("One or more of the map styles failed to load. \(error)")
        }
        mapView = gmsMapView
        view.addSubview(mapView!)
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        if let placeId = marker.userData as? String {
            placeTapped(id: placeId)
        }
        return false
    }
    
    func loadNearbyTP() {
        // TODO
        // This function should call the TPRepository and get the nearby TP
        // This will first get all the eligible nearby places from Google Places
        // Then the places ids are used to fetch the stock value from Firebase
    }
    
    func placeTapped(id: String) {
        // TODO
        // When a place is tapped we popup the place ui
        // showPlace(place: place)
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

