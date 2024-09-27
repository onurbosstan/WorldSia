//
//  LocationVC.swift
//  WorldSia
//
//  Created by Onur Bostan on 27.09.2024.
//

import UIKit
import MapKit
import CoreLocation

class NavigationVC: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var myLocation: UILabel!
    @IBOutlet weak var destinationTextField: UITextField!
    var viewModel: NavigationViewModel!
    var userCoordinate:CLLocationCoordinate2D?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = NavigationViewModel()
        viewModel.requestLocationAccess()
        setupBindings()
        mapView.delegate = self
    }
    func setupBindings() {
        viewModel.onLocationUpdate = { [weak self] coordinate, address in
            self?.userCoordinate = coordinate
            self?.myLocation.text = address
            
            self?.mapView.removeAnnotations(self?.mapView.annotations ?? [])
            
            let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
            self?.mapView.setRegion(region, animated: true)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = "Your Current Location"
            self?.mapView.addAnnotation(annotation)
        }
        viewModel.onLocationAccessDenied = { [weak self] in
            let alert = UIAlertController(title: "Location Permission Required", message: "Please grant location permission.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okey", style: .default, handler: nil))
            self?.present(alert, animated: true, completion: nil)
        }
    }
    @IBAction func goButton(_ sender: Any) {
        guard let destinationAddress = destinationTextField.text, !destinationAddress.isEmpty else {
                print("Please enter your destination address.")
                return
            }
        
            mapView.removeOverlays(mapView.overlays)
        
            let geocoder = CLGeocoder()
            geocoder.geocodeAddressString(destinationAddress) { [weak self] placemarks, error in
                if let error = error {
                    print("Geocode error: \(error.localizedDescription)")
                    return
                }
                
                guard let destinationPlacemark = placemarks?.first, let destinationCoordinate = destinationPlacemark.location?.coordinate else {
                    print("Target not found.")
                    return
                }
                
                guard let userCoordinate = self?.userCoordinate else {
                    print("Failed to retrieve user location.")
                    return
                }

                self?.viewModel.getDirections(from: userCoordinate, to: destinationCoordinate) { polyline in
                    guard let polyline = polyline else {
                        print("Route not found.")
                        return
                    }
                    self?.mapView.removeAnnotations(self?.mapView.annotations ?? [])
                    
                    let destinationAnnotation = MKPointAnnotation()
                    destinationAnnotation.coordinate = destinationCoordinate
                    destinationAnnotation.title = "Destination"
                    self?.mapView.addAnnotation(destinationAnnotation)
                    
                    self?.mapView.addOverlay(polyline)
                    let rect = polyline.boundingMapRect
                    self?.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
                }
            }
    }
}
extension NavigationVC: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let polyline = overlay as? MKPolyline {
            let polylineRenderer = MKPolylineRenderer(polyline: polyline)
            polylineRenderer.strokeColor = .blue
            polylineRenderer.lineWidth = 5.0
            return polylineRenderer
        }
        return MKOverlayRenderer()
    }
}
