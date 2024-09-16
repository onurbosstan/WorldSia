//
//  ViewController.swift
//  WorldSia
//
//  Created by Onur Bostan on 2.09.2024.
//

import UIKit
import Kingfisher
import Alamofire

class WorldVC: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    var viewModel = WorldViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.collectionViewLayout = UICollectionViewLayout()
        collectionView.collectionViewLayout = WorldCollectionLayout(colmnsNumber: 2, minColmnsNumber: 1, minCell: 1)
        
        viewModel.fetchCountries { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }
    
    @IBAction func menuButton(_ sender: Any) {
        
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
}
