//
//  WorldDetailsCell.swift
//  WorldSia
//
//  Created by Onur Bostan on 24.09.2024.
//

import UIKit

class WorldDetailsCell: UITableViewCell {
    @IBOutlet weak var detailsImageView: UIImageView!
    @IBOutlet weak var countryName: UILabel!
    @IBOutlet weak var capitalName: UILabel!
    @IBOutlet weak var populationLabel: UILabel!
    @IBOutlet weak var regionLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var currenciesLabel: UILabel!
    @IBOutlet weak var capitalInfoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
