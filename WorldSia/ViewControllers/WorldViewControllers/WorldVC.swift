//
//  ViewController.swift
//  WorldSia
//
//  Created by Onur Bostan on 2.09.2024.
//

import UIKit
import Kingfisher
import Alamofire

class WorldVC: UIViewController, MenuDelegate {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    var viewModel = WorldViewModel()
    var menuViewController: Menu?
    var selectedCountry: WorldModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.collectionViewLayout = UICollectionViewLayout()
        collectionView.collectionViewLayout = WorldCollectionLayout(colmnsNumber: 2, minColmnsNumber: 1, minCell: 1)
        searchBar.delegate = self
        
        AnimationHelper.showActivityIndicator(animationName: "flyanimation")
        viewModel.fetchCountries { [weak self] in
            DispatchQueue.main.async {
                AnimationHelper.hideActivityIndicator()
                self?.collectionView.reloadData()
            }
        }
    }
    @IBAction func menuButton(_ sender: Any) {
        if menuViewController == nil {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let menuVC = storyboard.instantiateViewController(withIdentifier: "Menu") as? Menu {
                menuVC.delegate = self
                menuViewController = menuVC
                addChild(menuVC)
                view.addSubview(menuVC.view)
                menuVC.didMove(toParent: self)
            }
        }
        menuViewController?.showMenu()
    }
    func didSelectOption(_ option: String) {
        if option == "Our Picks" {
            performSegue(withIdentifier: "", sender: nil)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetails", let destinationVC = segue.destination as? WorldDetailsVC {
            if let selectedCountry = selectedCountry {
                destinationVC.viewModel = WorldDetailsViewModel(country: selectedCountry)
            }
        }
    }
}

extension WorldVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems()
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WorldCell", for: indexPath) as? WorldCell else {
                fatalError("WorldCell bulunamadı")
            }
            if let country = viewModel.country(at: indexPath.item) {
                cell.configure(with: country)
            }
            return cell
        }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCountry = viewModel.country(at: indexPath.item)
        performSegue(withIdentifier: "toDetails", sender: self)
    }
    
}
extension WorldVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filterCountries(with: searchText)
        collectionView.reloadData()
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
