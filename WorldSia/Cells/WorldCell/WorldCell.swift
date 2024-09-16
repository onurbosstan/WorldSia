//
//  WorldCell.swift
//  WorldSia
//
//  Created by Onur Bostan on 14.09.2024.
//

import UIKit
import Kingfisher

class WorldCell: UICollectionViewCell {
    @IBOutlet weak var collectionImageView: UIImageView!
    @IBOutlet weak var countryName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionImageView.layer.cornerRadius = 8
        collectionImageView.clipsToBounds = true
    }
    func configure(with country: WorldModel) {
        if let flagURLString = country.flags?.png, let flagURL = URL(string: flagURLString) {
            collectionImageView.kf.setImage(with: flagURL)
        } else {
            collectionImageView.image = UIImage(named: "placeholder")
        }
        countryName.text = country.name?.common ?? "Unknow"
    }
}
