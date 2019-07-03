//
//  HeroDetailsViewController.swift
//  Marvel
//
//  Created by mac on 7/3/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import UIKit
enum SectionType:String {
    case heroInfo = ""
    case heroComics = "COMICS"
    case heroSeries = "SERIES"
    case heroStories = "STORIES"
    case heroEvents = "EVENTS"
    case heroLinks = "RELATED LINKS"
    
}
class HeroDetailsViewController: UIViewController {

    @IBOutlet weak var heroDetailsTableView: UITableView!
    
    var heroModel:HeroModel?
    {
        didSet{
            if isViewLoaded
            {
                setTableViewSections()
            }
        }
    }
    var heroDetailsSections = [SectionType]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        registerTableViewCells()
        setTableViewDelegates()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        setTableViewSections()
    }

}

extension HeroDetailsViewController
{
    func registerTableViewCells()
    {
        heroDetailsTableView.registerCellNib(cellClass: HeroImageTableViewCell.self)
        heroDetailsTableView.registerCellNib(cellClass: HeroCollectionTableViewCell.self)
        heroDetailsTableView.registerCellNib(cellClass: HeroLinkTableViewCell.self)
    }
    
    func setTableViewDelegates()
    {
        heroDetailsTableView.dataSource = self
        heroDetailsTableView.delegate = self
        heroDetailsTableView.estimatedRowHeight = 500
    }
    func setTableViewSections()
    {
        if let hero = heroModel
        {
            if let thumb = hero.thumbnail
            {
                if !thumb.path.isEmpty
                {
                    self.heroDetailsSections.append(.heroInfo)
                }
            }
            if let comics = hero.comicModel
            {
                if comics.available != 0
                {
                    self.heroDetailsSections.append(.heroComics)
                }
            }
            if let series = hero.seriesModel
            {
                if series.available != 0
                {
                    self.heroDetailsSections.append(.heroSeries)
                }
            }
            if let stories = hero.storiesModel
            {
                if stories.available != 0
                {
                    self.heroDetailsSections.append(.heroStories)
                }
            }
            if let events = hero.eventsModel
            {
                if events.available != 0
                {
                    self.heroDetailsSections.append(.heroEvents)
                }
            }
            
             let urls = hero.urls
            if urls.toArray().count != 0
            {
                self.heroDetailsSections.append(.heroLinks)
            }
            
        }
         self.heroDetailsTableView.reloadData()
    }
    func setupCustomHeaderView(section : Int) -> UIView?{
        
        let sectionType = self.heroDetailsSections[section]
        
        switch sectionType {
        case .heroInfo:
            return nil
        default:
            let view = UIView(frame: .zero)
            let textLabel = UILabel()
            textLabel.textColor = .red
            textLabel.text = sectionType.rawValue
            view.addSubview(textLabel)
            textLabel.translatesAutoresizingMaskIntoConstraints = false
            textLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8.0).isActive = true
            view.backgroundColor = .clear
            textLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8).isActive = true
            
            return view
        }
    }
}
extension HeroDetailsViewController:HeroDetailViewDelegate
{
    func didPressBackBtn() {
        self.navigationController?.popViewController(animated: true)
    }
}
extension HeroDetailsViewController:UITableViewDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.heroDetailsSections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionType = self.heroDetailsSections[section]
        switch sectionType {
        case .heroInfo, .heroComics,.heroSeries, .heroStories, .heroEvents:
            return 1
        case .heroLinks:
            return self.heroModel?.urls.toArray().count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        let sectionType = self.heroDetailsSections[indexPath.section]
        switch sectionType {
        case .heroInfo:
            return UITableView.automaticDimension
        case  .heroComics,.heroSeries, .heroStories, .heroEvents:
            return 170
        case .heroLinks:
            return 50
        }

    }
     func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let sectionType = self.heroDetailsSections[section]
        switch sectionType {
        case .heroInfo:
            return 0
        default :
            return 50
        }
    }

    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return setupCustomHeaderView(section: section)
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = self.heroDetailsSections[indexPath.section]

        switch section {
        case .heroInfo:
            let cell = tableView.dequeue() as HeroImageTableViewCell
            cell.heroDetailViewDelegate = self
            cell.configureCell(heroModel: self.heroModel!)
            return cell
        case .heroComics:
            let cell = tableView.dequeue() as HeroCollectionTableViewCell
            return cell
        case .heroSeries:
            let cell = tableView.dequeue() as HeroCollectionTableViewCell
            return cell
        case .heroStories:
            let cell = tableView.dequeue() as HeroCollectionTableViewCell
            return cell
        case .heroEvents:
            let cell = tableView.dequeue() as HeroCollectionTableViewCell
            return cell
        case .heroLinks:
            let cell = tableView.dequeue() as HeroLinkTableViewCell
            let url = self.heroModel?.urls.toArray()[indexPath.row] as! UrlModel
            cell.configureCell(url: url)
            return cell
        }
    }
    
    
}
