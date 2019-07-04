//
//  HeroImageTableViewCell.swift
//  Marvel
//
//  Created by mac on 7/3/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import UIKit

protocol HeroDetailViewDelegate:class {
    func didPressBackBtn()
    func openPreviewImagesFor(heroCollectionModel:HeroCollectionModel)
}

class HeroImageTableViewCell: UITableViewCell {

    @IBOutlet weak var heroImageView: UIImageView!
    @IBOutlet weak var heroDescription: UILabel!
    @IBOutlet weak var heroName: UILabel!
    weak var heroDetailViewDelegate:HeroDetailViewDelegate?
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
        self.heroName.text = heroModel.name
        self.heroDescription.text = !heroModel.descriptions.isEmpty ? heroModel.descriptions : "No Description Available"
        let imagePath = (heroModel.thumbnail?.path)!+"."+(heroModel.thumbnail?.exten)!
        GlobalUtilities.downloadImage(path: imagePath, placeholder: nil, into: self.heroImageView, indicator: nil)
    }
    
    @IBAction func backBtnClick(_ sender: UIButton) {
        heroDetailViewDelegate?.didPressBackBtn()
    }
}
