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
    var followUser = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadMapView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getUserLocation()
        loadDummyData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        HomeViewController.locationManager.stopUpdatingLocation()
    }
    
    func getUserLocation() {
        if !CLLocationManager.locationServicesEnabled() {
            getLocationPermission(locationManager: HomeViewController.locationManager)
        }
        
        if CLLocationManager.locationServicesEnabled() {
            HomeViewController.locationManager.delegate = self
            HomeViewController.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            HomeViewController.locationManager.startUpdatingLocation()
            mapView?.animate(toZoom: 14.0)
        }
    }
    
    func getLocationPermission(locationManager: CLLocationManager) {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func loadDummyData() {
        var lat = 38.641919
        var lon = -90.261528
        var marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: CLLocationDegrees(lat), longitude: CLLocationDegrees(lon))
        marker.userData = "testPlace"
        marker.icon = Utility.imageWithImage(image: UIImage(named: "FullStock")!, scaledToSize: CGSize(width: 50.0, height: 50.0))
        marker.map = mapView
        
        lat = 38.652919
        lon = -90.271728
        marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: CLLocationDegrees(lat), longitude: CLLocationDegrees(lon))
        marker.userData = "testPlace2"
        marker.icon = Utility.imageWithImage(image: UIImage(named: "SomeStock")!, scaledToSize: CGSize(width: 30.0, height: 35.0))
        marker.map = mapView
        
        lat = 38.631819
        lon = -90.251628
        marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: CLLocationDegrees(lat), longitude: CLLocationDegrees(lon))
        marker.userData = "testPlace3"
        marker.icon = Utility.imageWithImage(image: UIImage(named: "NoStock")!, scaledToSize: CGSize(width: 40.0, height: 40.0))
        marker.map = mapView
        
        lat = 38.649919
        lon = -90.251628
        marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: CLLocationDegrees(lat), longitude: CLLocationDegrees(lon))
        marker.userData = "testPlace4"
        marker.icon = Utility.imageWithImage(image: UIImage(named: "UnknownStock")!, scaledToSize: CGSize(width: 40.0, height: 40.0))
        marker.map = mapView
    }
    
    func loadMapView() {
        let camera = GMSCameraPosition.camera(withLatitude: 38.640933, longitude: -90.262504, zoom: 4.0)
        let gmsMapView = GMSMapView.map(withFrame: view.frame, camera: camera)
        gmsMapView.delegate = self
        gmsMapView.isMyLocationEnabled = true
        gmsMapView.setMinZoom(4.0, maxZoom: 16.0)
        gmsMapView.isBuildingsEnabled = false
        gmsMapView.settings.myLocationButton = !followUser
        gmsMapView.settings.compassButton = true
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
    
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        if gesture {
            followUser = false
            mapView.settings.myLocationButton = !followUser
        }
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        followUser = false
        mapView.settings.myLocationButton = !followUser
        mapView.animate(toZoom: 16.0)
        if let placeId = marker.userData as? String {
            placeTapped(id: placeId)
        }
        return false
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if followUser {
            guard let location: CLLocationCoordinate2D = manager.location?.coordinate else { return }
            mapView?.animate(toLocation: location)
        }
    }
    
    func didTapMyLocationButton(for mapView: GMSMapView) -> Bool {
        followUser = true
        mapView.settings.myLocationButton = !followUser
        mapView.animate(toZoom: 14.0)
        mapView.animate(toBearing: 0)
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

