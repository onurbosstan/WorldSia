//
//  WorldDetailsVC.swift
//  WorldSia
//
//  Created by Onur Bostan on 24.09.2024.
//

import UIKit

class WorldDetailsVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var viewModel: WorldDetailsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        
    }
}
extension WorldDetailsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WorldDetailsCell", for: indexPath) as? WorldDetailsCell else {
            fatalError("WorldDetailsCell bulunamadı")
        }
        if let viewModel = viewModel {
            cell.countryName.text = viewModel.countryName
            cell.capitalName.text = viewModel.capitalName
            cell.populationLabel.text = viewModel.population
            cell.regionLabel.text = viewModel.region
            cell.languageLabel.text = viewModel.languages
            cell.currenciesLabel.text = viewModel.currencies
            cell.capitalInfoLabel.text = viewModel.capitalInfo
            
            if let flagURL = viewModel.flagURL {
                cell.detailsImageView.kf.setImage(with: flagURL)
            } else {
                cell.detailsImageView.image = UIImage(named: "placeholder")
            }
            cell.configureMap(latitude: viewModel.latitude, longitude: viewModel.longitude)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 500
    }
}

