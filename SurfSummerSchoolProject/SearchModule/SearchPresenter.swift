//
//  SearchPresenter.swift
//  SurfSummerSchoolProject
//
//  Created by Дмитрий Бессонов on 10.08.2022.
//

import Foundation
import UIKit

class SearchPresenter {

    let searchController = UISearchController(searchResultsController: nil)
    
    private weak var searchControllerDelegate: SearchControllerDelegate?
    var elementsModel = ElementsModel()
    
    func setSearchControllerDelegate(searchControllerDelegate: SearchControllerDelegate?) {
        self.searchControllerDelegate = searchControllerDelegate
    }
    

    func getSearch() -> UISearchController {
        searchController.searchBar.placeholder = "Поиск"
        searchController.searchBar.showsCancelButton = false
        return searchController
    }
    
    
}
