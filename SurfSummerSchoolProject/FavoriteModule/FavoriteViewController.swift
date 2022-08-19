//
//  FavoriteViewController.swift
//  SurfSummerSchoolProject
//
//  Created by Дмитрий Бессонов on 06.08.2022.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    // MARK: - Constants
    private enum Constants {
        static let horisontalInset: CGFloat = 16
        static let spaceBetweenRows: CGFloat = 8
        static let aspectRatioWidthForHeight = 1.16
    }
    
    // MARK: - Private Properties
    private var favoriteModel: [FavoriteModel] = []
    private let tab = TabBarModel.self
    
    
    //MARK: - Views
    
    var mainVC: MainViewController?
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainVC?.delegate = self
        configureAppearance()
        favoriteModel = DataManager.shared.fetchContentInFavorite()
        setSearchButton()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
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
}
// MARK: - Private Methods

private extension FavoriteViewController {
    
    func configureAppearance() {
        
        collectionView.register(UINib(nibName: "\(FavoriteCollectionViewCell.self)", bundle: .main),
                                forCellWithReuseIdentifier: "\(FavoriteCollectionViewCell.self)")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.contentInset = .init(top: 10, left: 16, bottom: 10, right: 16)
    }
    
}

extension FavoriteViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoriteModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(FavoriteCollectionViewCell.self)", for: indexPath)
        if let cell = cell as? FavoriteCollectionViewCell {
            let item = favoriteModel[indexPath.row]
            cell.imageUrlInString = item.imageUrlInString
            cell.title = item.title
            cell.text = item.content
            cell.date = item.dateCreation
            cell.isFavorite = item.isFavorite
            cell.didFavoritesTapped = { [weak self] in
                self?.favoriteModel[indexPath.row].isFavorite.toggle()
                DataManager.shared.deleteContentFromFavorite(at: cell.tag)
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = (view.frame.width - Constants.horisontalInset * 2)
        return CGSize(width: itemWidth, height: Constants.aspectRatioWidthForHeight * itemWidth)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.spaceBetweenRows
    }
}

// MARK: - FavoriteProtocol

extension FavoriteViewController: saveToFavoriteDelegate {
    func saveContent(_ model: FavoriteModel) {
        favoriteModel.append(model)
        collectionView.reloadData()
    }
    
}
