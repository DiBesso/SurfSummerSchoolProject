//
//  MainViewController.swift
//  SurfSummerSchoolProject
//
//  Created by Дмитрий Бессонов on 06.08.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    private let tab = TabBarModel.self
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let searchButton = UIBarButtonItem(image: UIImage(named: "searchButton"), style: .plain, target: self, action: #selector(getSearch(sender:)))
        searchButton.tintColor = .black
        navigationItem.title = tab.main.title
        navigationItem.rightBarButtonItem = searchButton
        
    }
    
    
    @objc func getSearch (sender: UIBarButtonItem) {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "Поиск"
        searchController.searchBar.showsCancelButton = false
        navigationItem.searchController = searchController
    }
    
}
