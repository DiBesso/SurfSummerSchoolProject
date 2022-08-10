//
//  SearchViewController.swift
//  SurfSummerSchoolProject
//
//  Created by Дмитрий Бессонов on 10.08.2022.
//

import UIKit

class SearchViewController: UIViewController, SearchControllerDelegate {
    
    private let searchPresenter = SearchPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchPresenter.setSearchControllerDelegate(searchControllerDelegate: self)
        navigationItem.searchController = searchPresenter.getSearch()
    }
    

    func getSearch() {
    }
    
    
    
    

    
    
}
