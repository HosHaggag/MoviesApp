//
//  FavoriteTableViewCell.swift
//  MoviesApp
//
//  Created by Hossam on 22/08/2021.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {

    @IBOutlet var movieImage: UIImageView!
    
    @IBOutlet var movieLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        

        // Configure the view for the selected state
    }

}
