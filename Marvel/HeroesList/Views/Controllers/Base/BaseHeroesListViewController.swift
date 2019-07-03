//
//  BaseHeroesListViewController.swift
//  Marvel
//
//  Created by mac on 7/3/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import UIKit

class BaseHeroesListViewController: UIViewController {
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var heroesTableView: UITableView!
    
    // MARK: - Variables

    
    public var paginationIndicator: UIActivityIndicatorView?
    private var refreshControl: UIRefreshControl?
    private var hasPagination: Bool = false
    
    // MARK: - Base Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableDataSource()
        setupCellNibNames()
        setupSearchBtnNavigation()
        setNavTitle()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    

    // MARK: right navbar button
    func setupSearchBtnNavigation() {
        
        let searchButton = UIBarButtonItem.init(image: UIImage(named: "ic_search"), style: .plain, target: self, action: #selector(handleSearchBtnClick))
        searchButton.tintColor = .red
        navigationItem.rightBarButtonItem = searchButton
    }
    
    func setNavTitle()
    {
        let logo = UIImage(named: "ic-marvel")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
    }
    //MARK:- Movie Details Action
    @objc func handleSearchBtnClick()   {
        handleSearchBtnViews()
    }
    
    func handleSearchBtnViews() {
        // override this when you need to handleOpenAddNewMoview
    }
    
    // MARK: Refresh cotrol
    func setupSwipeRefresh() -> Void {
        refreshControl = UIRefreshControl()
        
        refreshControl?.tintColor = UIColor.gray
        refreshControl?.addTarget(self, action: #selector(swipeRefreshTableView), for: .valueChanged)
        self.heroesTableView.addSubview(refreshControl!)
    }
    
    @objc func swipeRefreshTableView() {
        // override this when you need to refresh table data by swipe
    }
    
    func endRefreshTableView() -> Void {
        self.refreshControl?.endRefreshing()
    }
    
    //MARK: Pagination
    func setupPagination() -> Void {
        hasPagination = true
    }
    
    func handlePaginationRequest() {
        // override this when you need to handlePaginationRequest
    }
    
    func showLoadingMoreView() -> Void {
        paginationIndicator = UIActivityIndicatorView.init()
        paginationIndicator?.color = UIColor.gray
        paginationIndicator?.sizeToFit()
        paginationIndicator?.startAnimating()
        self.heroesTableView.tableFooterView =  paginationIndicator
    }
    
    func removeLoadingMoreView(){
        if paginationIndicator != nil{
            if paginationIndicator!.isDescendant(of: self.view) {
                paginationIndicator?.removeFromSuperview()
                paginationIndicator = nil
            }
        }
    }
    
    
    // MARK: - Table view
    
    func setupTableDataSource() -> Void {
        self.heroesTableView.delegate = self
        self.heroesTableView.dataSource = self
    }
    
    
    // MARK: Table view nib name
    
    public func setupCellNibNames() -> Void {
        // This methode will overridw at sub classes
    }
    
    
    func getCellHeight() -> CGFloat {
        preconditionFailure("You have to Override getCellHeight Function first to be able to set cell height")
    }
    
    func getCellsCount(with section:Int)->Int
    {
        preconditionFailure("You have to Override getCellsCount Function first to be able to set number of cells count")
    }
    
    func getSectionsCount()->Int
    {
        preconditionFailure("You have to Override getSectionsCount Function first to be able to set number of sections count")
    }
    
    
    // MARK: - Loading Progress
    // MARK: Show
    
    public func showProgressLoaderIndicator(){
        DispatchQueue.main.async {
            UIHelper.showProgressBarWithDimView()
        }
        
    }
    
    
    // MARK: Hide
    
    public func hideProgressLoaderIndicator(){
        DispatchQueue.main.async {
            UIHelper.dissmissProgressBar()
        }
        
    }
    
    
    func checkRefreshControlState() -> Void {
        DispatchQueue.main.async {
            if (self.refreshControl?.isRefreshing)! {
                self.refreshControl?.endRefreshing()
            }
        }
    }
    
    
}


// MARK: - UITableViewDataSource

extension BaseHeroesListViewController : UITableViewDataSource{
    
    
    // MARK: Height for cell
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return getCellHeight()
    }

    // MARK: Number of Sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.getSectionsCount()
    }
    
    // MARK: Number of rows
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.getCellsCount(with:section)
    }
    
    
    // MARK: Cell for row
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        return getCustomCell(tableView, cellForRowAt: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectCellAt(indexPath: indexPath)
    }
    
    @objc func getCustomCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return UITableViewCell.init()
    }
    @objc func didSelectCellAt(indexPath: IndexPath)  {
        
       
    }
}

extension BaseHeroesListViewController: UITableViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView == heroesTableView {
            if ((scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height) {
                if (self.hasPagination) {
                    self.handlePaginationRequest()
                }
            }
        }
    }
}
