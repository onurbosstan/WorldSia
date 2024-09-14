//
//  WorldCell.swift
//  WorldSia
//
//  Created by Onur Bostan on 14.09.2024.
//

import UIKit

class WorldCell: UICollectionViewCell {
    @IBOutlet weak var collectionImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionImageView.layer.cornerRadius = 8
    }
}
