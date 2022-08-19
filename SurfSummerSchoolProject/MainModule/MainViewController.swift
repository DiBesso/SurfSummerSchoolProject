//
//  MainViewController.swift
//  SurfSummerSchoolProject
//
//  Created by Дмитрий Бессонов on 06.08.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    
    // MARK: - Constants
    private enum Constants {
        static let horisontalInset: CGFloat = 16
        static let spaceBetweenElements: CGFloat = 7
        static let spaceBetweenRows: CGFloat = 8
        static let aspectRatioWidthForHeight = 1.46
    }
    
    // MARK: - Private Properties
    private var favoriteModel: [FavoriteModel] = []
    private let model: MainModel = .init()
    private let tab = TabBarModel.self
    
    // MARK: - Views
    @IBOutlet private weak var collectionView: UICollectionView!
    
    //MARK: - Delegate
    var favoriteVC: FavoriteViewController?
//    var delegate: saveToFavoriteDelegate!
    // MARK: - Lifeсyrcle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureApperance()
        model.loadPosts()
        setSearchButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureModel()
    }
    // MARK: - Search Methods
    
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
        //        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        navigationController?.pushViewController(SearchViewController(), animated: true)
        definesPresentationContext = true
    }
}

// MARK: - Private Methods
private extension MainViewController {
    
    
    func configureApperance() {
        navigationItem.title = "Главная"
        collectionView.register(UINib(nibName: "\(MainItemCollectionViewCell.self)", bundle: .main),
                                forCellWithReuseIdentifier: "\(MainItemCollectionViewCell.self)")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.contentInset = .init(top: 10, left: 16, bottom: 10, right: 16)
    }
    
    func configureModel() {
        model.didItemsUpdated = { [weak self] in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self?.collectionView.reloadData()
            }
        }
    }
}

// MARK: - UICollection

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(MainItemCollectionViewCell.self)", for: indexPath)
        if let cell = cell as? MainItemCollectionViewCell {
            let item = model.items[indexPath.row]
            cell.imageUrlInString = item.imageUrlInString
            cell.title = item.title
            cell.isFavorite = item.isFavorite
            cell.didFavoritesTapped = { [weak self] in
                self?.model.items[indexPath.row].isFavorite.toggle()
                let date = item.dateCreation
                let content = item.content
                let isFavorite = self?.model.items[indexPath.row].isFavorite
                let favoriteModel = FavoriteModel(imageUrlInString: cell.imageUrlInString, title: cell.title, isFavorite: isFavorite ?? true, content: content, dateCreation: date)
                DataManager.shared.save(model: favoriteModel)
//                self?.delegate?.saveContent(favoriteModel)
                self?.dismiss(animated: true)
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = (view.frame.width - Constants.horisontalInset * 2 - Constants.spaceBetweenElements) / 2
        return CGSize(width: itemWidth, height: Constants.aspectRatioWidthForHeight * itemWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.spaceBetweenRows
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.spaceBetweenElements
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.model = model.items[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}

