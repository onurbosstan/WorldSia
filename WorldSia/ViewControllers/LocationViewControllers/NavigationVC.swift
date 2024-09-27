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
            annotation.title = "Mevcut Konumunuz"
            self?.mapView.addAnnotation(annotation)
        }
        viewModel.onLocationAccessDenied = { [weak self] in
            let alert = UIAlertController(title: "Konum İzni Gerekli", message: "Lütfen konum izni verin.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: nil))
            self?.present(alert, animated: true, completion: nil)
        }
    }
    @IBAction func goButton(_ sender: Any) {
        guard let destinationAddress = destinationTextField.text, !destinationAddress.isEmpty else {
                print("Lütfen gideceğiniz adresi girin.")
                return
            }
        
            mapView.removeOverlays(mapView.overlays)
        
            let geocoder = CLGeocoder()
            geocoder.geocodeAddressString(destinationAddress) { [weak self] placemarks, error in
                if let error = error {
                    print("Geocode hatası: \(error.localizedDescription)")
                    return
                }
                
                guard let destinationPlacemark = placemarks?.first, let destinationCoordinate = destinationPlacemark.location?.coordinate else {
                    print("Hedef bulunamadı.")
                    return
                }
                
                guard let userCoordinate = self?.userCoordinate else {
                    print("Kullanıcı konumu alınamadı.")
                    return
                }

                self?.viewModel.getDirections(from: userCoordinate, to: destinationCoordinate) { polyline in
                    guard let polyline = polyline else {
                        print("Rota bulunamadı.")
                        return
                    }
                    self?.mapView.removeAnnotations(self?.mapView.annotations ?? [])
                    
                    let destinationAnnotation = MKPointAnnotation()
                    destinationAnnotation.coordinate = destinationCoordinate
                    destinationAnnotation.title = "Hedef"
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
