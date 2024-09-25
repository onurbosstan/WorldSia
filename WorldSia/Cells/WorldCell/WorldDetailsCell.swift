//
//  WorldDetailsCell.swift
//  WorldSia
//
//  Created by Onur Bostan on 24.09.2024.
//

import UIKit
import MapKit

class WorldDetailsCell: UITableViewCell {
    @IBOutlet weak var detailsImageView: UIImageView!
    @IBOutlet weak var countryName: UILabel!
    @IBOutlet weak var capitalName: UILabel!
    @IBOutlet weak var populationLabel: UILabel!
    @IBOutlet weak var regionLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var currenciesLabel: UILabel!
    @IBOutlet weak var capitalInfoLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configureMap(latitude: Double?, longitude: Double?) {
            guard let lat = latitude, let lon = longitude else {
                return
            }
            
            // Enlem ve boylama göre konum ayarlama
            let location = CLLocationCoordinate2D(latitude: lat, longitude: lon)
            let region = MKCoordinateRegion(center: location, latitudinalMeters: 1000000, longitudinalMeters: 1000000)
            mapView.setRegion(region, animated: true)
            
            // İşaretleyici (pin) ekle
            let annotation = MKPointAnnotation()
            annotation.coordinate = location
            annotation.title = "Country Location"
            mapView.addAnnotation(annotation)
        }

}
