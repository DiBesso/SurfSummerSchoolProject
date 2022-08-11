//
//  FavoriteViewController.swift
//  SurfSummerSchoolProject
//
//  Created by Дмитрий Бессонов on 06.08.2022.
//

import UIKit

final class FavoriteViewController: UIViewController {
    
    private let tableView = UITableView()
    private let tab = TabBarModel.self
    var model: DetailItemModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        setSearchButton()
        tableView.reloadData()
        
        
    }
    
        func setSearchButton() {
        let searchButton = UIBarButtonItem(image: UIImage(named: "searchButton"), style: .plain, target: self, action: #selector(getSearch(sender:)))
        searchButton.tintColor = .black
        navigationItem.title = tab.favorite.title
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
        tableView.register(UINib(nibName: "\(FavoriteTableViewCell.self)", bundle: .main),
                           forCellReuseIdentifier: "\(FavoriteTableViewCell.self)")
        tableView.dataSource = self
        tableView.separatorStyle = .none
    }
}
// MARK: - UITableViewDataSource

extension FavoriteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(FavoriteTableViewCell.self)")
            if let cell = cell as? FavoriteTableViewCell {
                cell.image = model?.image
                cell.title = model?.title ?? ""
                cell.date = model?.dateCreation ?? ""
                cell.text = model?.content
            }
        return cell ?? UITableViewCell()
    }
}
