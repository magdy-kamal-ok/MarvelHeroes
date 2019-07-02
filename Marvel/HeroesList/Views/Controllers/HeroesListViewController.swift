//
//  HeroesListViewController.swift
//  Marvel
//
//  Created by mac on 7/3/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import UIKit

class HeroesListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let vm = HeroesListViewModel.init()
        vm.getHeroesData()
    }



}
