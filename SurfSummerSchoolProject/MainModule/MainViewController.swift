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
    
    let model = MainModel.shared
    // MARK: - Private Properties
    private let tab = TabBarModel.self
    
    // MARK: - Views
    @IBOutlet private weak var collectionView: UICollectionView!
    
    //MARK: - Delegate
    var favoriteVC: FavoriteViewController?
    
    // MARK: - Lifeсyrcle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureApperance()
        model.loadPosts()
//        setSearchButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureModel()
        configureNavigationBar()
    }
    // MARK: - NavigationBar
    
    func configureNavigationBar() {
        navigationItem.title = "Главная"
        let searchButton = UIBarButtonItem(
            image: UIImage(named: "searchButton"),
            style: .plain,
            target: self,
            action: #selector(enterSearchViewController(sender:))
        )
        navigationItem.rightBarButtonItem = searchButton
        navigationItem.rightBarButtonItem?.tintColor = ColorsExtension.black
    }
    
    @objc func enterSearchViewController(sender: UIBarButtonItem) {
        let searchViewController = SearchVC()
        self.navigationController?.pushViewController(searchViewController, animated: true)
    }
//    func setSearchButton() {
//        let searchButton = UIBarButtonItem(image: UIImage(named: "searchButton"), style: .plain, target: self, action: #selector(getSearch(sender:)))
//        searchButton.tintColor = .black
//        navigationItem.title = tab.main.title
//        navigationItem.rightBarButtonItem = searchButton
//    }
//
//    @objc func getSearch (sender: UIBarButtonItem) {
//        let searchController = UISearchController(searchResultsController: nil)
//        searchController.searchBar.placeholder = "Поиск"
//        navigationItem.searchController = searchController
//        navigationController?.pushViewController(SearchVC(), animated: true)
//        definesPresentationContext = true
//    }
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
            var item: DetailItemModel
            item = model.items[indexPath.item]
            cell.imageUrlInString = item.imageUrlInString
            cell.title = item.title
            cell.isFavorite = item.isFavorite
            cell.didFavoritesTapped = { [weak self] in
                do {
                self?.model.items[indexPath.row].isFavorite.toggle()
                    try DataManager().save(by: item.id, new: self?.model.items[indexPath.item].isFavorite ?? false)
                    collectionView.reloadItems(at: [indexPath])
                } catch let error {
                        print(error)
                    }
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

