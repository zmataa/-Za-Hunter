//
//  LocationManager.swift
//  Map Hackwich
//
//  Created by Zane Matarieh on 2/3/25.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {

    var locationManager = CLLocationManager()
    var geocoder = CLGeocoder()

    override init() {

        super.init()

        locationManager.delegate = self

        locationManager.requestWhenInUseAuthorization()

        locationManager.startUpdatingLocation()

    }
}
