//
//  LocatinViewModel.swift
//  WorldSia
//
//  Created by Onur Bostan on 27.09.2024.
//

import Foundation
import MapKit
import CoreLocation

class NavigationViewModel: NSObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    var onLocationUpdate: ((CLLocationCoordinate2D, String) -> Void)?
    var onLocationAccessDenied: (() -> Void)?
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    func requestLocationAccess() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        } else {
            onLocationAccessDenied?()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let coordinate = location.coordinate
        let geocoder = CLGeocoder()
        
        geocoder.reverseGeocodeLocation(location) { [weak self] placemarks, error in
            if let error = error {
                print("Geocode hatası: \(error)")
                return
            }
            
            guard let placemark = placemarks?.first else {
                self?.onLocationUpdate?(coordinate, "Mevcut Konum")
                return
            }
            
            let street = placemark.thoroughfare ?? ""
            let city = placemark.locality ?? ""
            let state = placemark.administrativeArea ?? ""
            let country = placemark.country ?? ""
            let fullAddress = "\(street), \(city), \(state), \(country)".trimmingCharacters(in: .whitespacesAndNewlines)
            
            self?.onLocationUpdate?(coordinate, fullAddress)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .denied {
            onLocationAccessDenied?()
        }
    }
    
    func getDirections(from sourceCoordinate: CLLocationCoordinate2D, to destinationCoordinate: CLLocationCoordinate2D, completion: @escaping (MKPolyline?) -> Void) {
        let sourcePlaceMark = MKPlacemark(coordinate: sourceCoordinate)
        let destinationPlaceMark = MKPlacemark(coordinate: destinationCoordinate)
        
        let directionRequest = MKDirections.Request()
        directionRequest.source = MKMapItem(placemark: sourcePlaceMark)
        directionRequest.destination = MKMapItem(placemark: destinationPlaceMark)
        directionRequest.transportType = .automobile  // Yürüyüş, bisiklet de seçilebilir
        
        let directions = MKDirections(request: directionRequest)
        directions.calculate { response, error in
            guard let response = response else {
                print("Yol tarifi alınamadı: \(error?.localizedDescription ?? "Hata")")
                completion(nil)
                return
            }
            
            let route = response.routes.first
            completion(route?.polyline)
        }
    }
}
