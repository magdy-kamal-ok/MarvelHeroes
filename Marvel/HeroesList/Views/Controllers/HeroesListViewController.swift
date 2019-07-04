//
//  HeroesListViewController.swift
//  Marvel
//
//  Created by mac on 7/3/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import UIKit

class HeroesListViewController: BaseHeroesListViewController {

    var heroesListViewModel:HeroesListViewModel?
    // MARK: ViewController lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPagination()
        setupSwipeRefresh()
        heroesListViewModel = HeroesListViewModel.init(delegate: self)
        heroesListViewModel?.getHeroesData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.heroesTableView.reloadData()
    }
    // MARK: override required methods needed from parent class
    override func setupCellNibNames() {
        
        self.heroesTableView.registerCellNib(cellClass: HeroTableViewCell.self)
        self.heroesTableView.registerCellNib(cellClass: SearchTableViewCell.self)
    }
    
    override func getCellHeight() -> CGFloat {
        if (self.heroesListViewModel?.isSearch)!
        {
             return 100
        }
        else
        {
             return 150
        }
       
    }
    
    override func getCellsCount(with section:Int) -> Int {
        
        return heroesListViewModel?.heroesList.count ?? 5
        
    }
    
    override func getSectionsCount() -> Int {
        return 1
    }
    
    
    override func getCustomCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (self.heroesListViewModel?.isSearch)!
        {
            let searchTableViewCell = tableView.dequeue() as SearchTableViewCell
            let heroModel = self.heroesListViewModel?.heroesList[indexPath.row] as! HeroModel
            searchTableViewCell.configureCell(heroModel: heroModel)
            return searchTableViewCell

        }
        else
        {
            let heroTableViewCell = tableView.dequeue() as HeroTableViewCell
            let heroModel = self.heroesListViewModel?.heroesList[indexPath.row] as! HeroModel
            heroTableViewCell.configureCell(heroModel: heroModel)
            return heroTableViewCell
        }
    }
    
    override func handlePaginationRequest() {
        let totalListCount = (self.heroesListViewModel?.listTotalCount)!
        let currentListCount = (self.heroesListViewModel?.heroesList.count)!
        if currentListCount < totalListCount && !(self.heroesListViewModel?.isLoadingMore)!
        {
            showLoadingMoreView()
            self.heroesListViewModel?.loadMoreMovies()
        }
    }
    
    override func didSelectCellAt(indexPath: IndexPath) {
        let heroModel = self.heroesListViewModel?.heroesList[indexPath.row] as! HeroModel
        openHeroDetails(with: heroModel)
    }
    
    func openHeroDetails(with heroModel:HeroModel)
    {
        let heroDetailsViewController = HeroDetailsViewController.init(nibName: "HeroDetailsViewController", bundle: nil)
        heroDetailsViewController.heroModel = heroModel
        self.navigationController?.pushViewController(heroDetailsViewController, animated: true)
        
    }
    override func swipeRefreshTableView() {
        self.heroesListViewModel?.refreshMoviesList()
        
    }
    
    override func handleSearchBtnViews() {
        self.heroesListViewModel?.removeAllDataSource()

        self.navigationItem.rightBarButtonItem = nil
        let searchBar = UISearchBar.init(frame: (self.navigationController?.navigationBar.frame)!)
        searchBar.showsCancelButton = true
        searchBar.barTintColor = .red
        searchBar.delegate = self
        self.navigationItem.titleView = searchBar
        searchBar.becomeFirstResponder()
    

        
    }
}
extension HeroesListViewController:HeroesViewControllerDelegate
{
    func showAlert(alert: UIAlertController) {
       // self.present(alert, animated: true, completion: nil)
    }
    
    func refreshHeroesFinished() {
        self.checkRefreshControlState()
    }
    
    func loadingMoreHeroesFinished() {
        DispatchQueue.main.async {
            self.removeLoadingMoreView()
        }
        
    }
    
    func showLoader(flag: Bool) {
        if flag
        {
            self.showProgressLoaderIndicator()
        }
        else
        {
            self.hideProgressLoaderIndicator()
        }
    }
    
    func reloadHeroesData() {
        
        DispatchQueue.main.async {
            self.heroesTableView.reloadData()
        }
        
    }
    
    
    
}
extension HeroesListViewController:UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.heroesListViewModel?.removeAllDataSource()
        searchBar.tintColor = .red
        self.heroesListViewModel?.isSearch = true
        self.heroesListViewModel?.searchByName(name: searchBar.text!)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.heroesListViewModel?.isSearch = false
        self.navigationItem.titleView = nil
        self.heroesListViewModel?.removeAllDataSource()
        self.setupSearchBtnNavigation()
        self.setNavTitle()
        self.heroesListViewModel?.isSearch = false
        self.heroesListViewModel?.getHeroesData()
    }
    
    
}
