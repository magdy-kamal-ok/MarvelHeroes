//
//  HeroCollectionViewCell.swift
//  Marvel
//
//  Created by mac on 7/4/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import UIKit
import RxSwift
class HeroCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var collectionTitle: UILabel!
    
    @IBOutlet weak var collectionImageView: UIImageView!
    var heroesCollectionViewModel:HeroesCollectionViewModel?
    let disposeBag = DisposeBag()
    var heroesCollection = [HeroCollectionModel]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        self.heroesCollectionViewModel = nil
        heroesCollection = [HeroCollectionModel]()
    }
    func configurCell(resourceUrl:String)
    {
        self.heroesCollectionViewModel = HeroesCollectionViewModel()
        listenHeroCollection()
        self.heroesCollectionViewModel?.getHeroesCollectionData(url: resourceUrl)
    }
    
    
}

extension HeroCollectionViewCell
{
    func listenHeroCollection()
    {
        heroesCollectionViewModel?.objObservableResult.asObservable().subscribe(onNext: { (collectionResponse) in
            
                self.setViewsData(response: collectionResponse.first)
            
        }, onError: { (err) in
            print(err)
        }, onCompleted: {
            //
            print("completed")
        }).disposed(by: disposeBag)
        
        
    }
    
    func setViewsData(response:HeroCollectionModel?)
    {
        if let response = response
        {
            self.collectionTitle.text = response.title
            if response.images.toArray().count > 0
            {
                let firstCollection = response.images.toArray().first as! ThumbnailModel
                let imagePath = firstCollection.path+"."+firstCollection.exten
                GlobalUtilities.downloadImage(path: imagePath, placeholder: nil, into: self.collectionImageView, indicator: nil)
            }
    }
    }
}
