//
//  DetailViewController.swift
//  SurfSummerSchoolProject
//
//  Created by Дмитрий Бессонов on 10.08.2022.
//

import Foundation
import UIKit

class DetailViewController: UIViewController, UIGestureRecognizerDelegate {
    
    // MARK: - Views
    
    private let tableView = UITableView()
    
    // MARK: - Properties
    
    var model: DetailItemModel?
    private let tab = TabBarModel.self
    
    // MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearance()
        tableView.reloadData()
        setSearchButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar()
    }
   
}


// MARK: - Private Methods

private extension DetailViewController {
    func configureAppearance() {
        configureTableView()
    }
    
    func configureNavigationBar() {
            navigationItem.title = model?.title
            let backButton = UIBarButtonItem(image: UIImage(named: "back-arrow"),
                                             style: .plain,
                                             target: navigationController,
                                             action: #selector(UINavigationController.popViewController(animated:)))
            navigationItem.leftBarButtonItem = backButton
            navigationItem.leftBarButtonItem?.tintColor = .black
            navigationController?.interactivePopGestureRecognizer?.delegate = self
        }
    
    func setSearchButton() {
        let searchButton = UIBarButtonItem(image: UIImage(named: "searchButton"), style: .plain, target: self, action: #selector(getSearch(sender:)))
        searchButton.tintColor = .black
        navigationItem.title = tab.main.title
        navigationItem.rightBarButtonItem = searchButton
        
        
    }
    
    @objc func getSearch (sender: UIBarButtonItem) {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "Поиск"
//        searchController.searchBar.showsCancelButton = false
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        navigationController?.pushViewController(SearchViewController(), animated: true)
        definesPresentationContext = true
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        tableView.register(UINib(nibName: "\(DetailImageTableViewCell.self)", bundle: .main),
                           forCellReuseIdentifier: "\(DetailImageTableViewCell.self)")
        tableView.register(UINib(nibName: "\(DetailTitleTableViewCell.self)", bundle: .main),
                           forCellReuseIdentifier: "\(DetailTitleTableViewCell.self)")
        tableView.register(UINib(nibName: "\(DetailTextTableViewCell.self)", bundle: .main),
                           forCellReuseIdentifier: "\(DetailTextTableViewCell.self)")
        tableView.dataSource = self
        tableView.separatorStyle = .none
    }
    
}

// MARK: - UITableViewDataSource

extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(DetailImageTableViewCell.self)")
            if let cell = cell as? DetailImageTableViewCell {
                cell.imageUrlInString = model?.imageUrlInString ?? ""
            }
            return cell ?? UITableViewCell()
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(DetailTitleTableViewCell.self)")
            if let cell = cell as? DetailTitleTableViewCell {
                cell.title = model?.title ?? ""
                cell.date = model?.dateCreation ?? ""
        
            }
            return cell ?? UITableViewCell()
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(DetailTextTableViewCell.self)")
            if let cell = cell as? DetailTextTableViewCell {
                cell.text = model?.content
            }
            return cell ?? UITableViewCell()
        default:
            return UITableViewCell()
        }
    }
}
