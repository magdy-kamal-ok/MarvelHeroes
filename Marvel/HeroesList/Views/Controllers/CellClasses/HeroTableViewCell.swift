//
//  HeroTableViewCell.swift
//  Marvel
//
//  Created by mac on 7/3/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import UIKit

class HeroTableViewCell: BaseHeroesTableViewCell {

    @IBOutlet weak var heroView: ParallelogramView!


    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func configureCell(heroModel:HeroModel)
    {
       super.configureCell(heroModel: heroModel)
        self.heroNameLbl.textColor = .black
        self.heroNameLbl.font = UIFont.systemFont(ofSize: 17, weight: .bold)
    }
}
