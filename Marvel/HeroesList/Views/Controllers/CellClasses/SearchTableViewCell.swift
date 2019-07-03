//
//  SearchTableViewCell.swift
//  Marvel
//
//  Created by mac on 7/3/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import UIKit

class SearchTableViewCell: BaseHeroesTableViewCell {

    @IBOutlet weak var mainView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func configureCell(heroModel:HeroModel)
    {
        super.configureCell(heroModel: heroModel)
        self.mainView.backgroundColor = .darkGray
        self.heroNameLbl.textColor = .white
        self.heroNameLbl.font = UIFont.systemFont(ofSize: 17, weight: .light)
    }
}
