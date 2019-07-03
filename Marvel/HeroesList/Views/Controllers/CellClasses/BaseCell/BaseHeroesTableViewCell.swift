//
//  BaseHeroesTableViewCell.swift
//  Marvel
//
//  Created by mac on 7/3/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import UIKit

class BaseHeroesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var heroImageView: UIImageView!
    @IBOutlet weak var heroNameLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configureCell(heroModel:HeroModel)
    {
        self.heroNameLbl.text = heroModel.name
        let imagePath = (heroModel.thumbnail?.path)!+"."+(heroModel.thumbnail?.exten)!
        GlobalUtilities.downloadImage(path: imagePath, placeholder: nil, into: self.heroImageView, indicator: nil)
    }
}
