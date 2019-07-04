//
//  HeroCollectionTableViewCell.swift
//  Marvel
//
//  Created by mac on 7/3/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import UIKit

class HeroCollectionTableViewCell: UITableViewCell {

    @IBOutlet weak var heroCollectionView: UICollectionView!

    var detailModel:DetailsModel?
    {
        didSet
        {
            self.heroCollectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.heroCollectionView.delegate = self
        self.heroCollectionView.dataSource = self
        self.heroCollectionView.register(UINib.init(nibName: "HeroCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HeroCollectionViewCell")
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.detailModel = nil
    }
  
    
}

extension HeroCollectionTableViewCell:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.detailModel?.items.toArray().count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeroCollectionViewCell", for: indexPath) as! HeroCollectionViewCell
        let detailsItemModel = self.detailModel?.items.toArray()[indexPath.row] as! DetailsItemModel
        cell.configurCell(resourceUrl: detailsItemModel.resourceURI)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: 120, height: collectionView.frame.height)
    }
    
}
