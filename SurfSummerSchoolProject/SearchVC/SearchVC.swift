//
//  SearchVC.swift
//  SurfSummerSchoolProject
//
//  Created by Дмитрий Бессонов on 21.09.2022.
//

import UIKit

class SearchVC: UIViewController, UIGestureRecognizerDelegate {
    
    // MARK: - Constants
    
    private enum ConstantImages {
        static let backArrow: UIImage? = UIImage(named: "back-arrow")
        static let searchEye: UIImage? = UIImage(named: "requestLoupe")
        static let sadSmile: UIImage? = UIImage(named: "sadSmile")
    }
    
    private let mainItemCollectionViewCell: String = "\(MainItemCollectionViewCell.self)"
    private let cellProportion: Double = 245 / 168
    
    private enum ConstantConstraints {
        static let collectionViewPadding: CGFloat = 16
        static let hSpaceBetweenItems: CGFloat = 7
        static let vSpaceBetweenItems: CGFloat = 8
    }
    
    // MARK: - Views
    
    @IBOutlet weak var searchLabel: UILabel!
    @IBOutlet weak var searchImageView: UIImageView!
    @IBOutlet weak var searchCollectionView: UICollectionView!
    private var searchBar: UISearchBar!
        
        // MARK: - Properties
        
        private var posts = MainModel.shared.filteredPosts(searchText: "")
        
        // MARK: - Lifecyrcle
        
        override func viewDidLoad() {
            super.viewDidLoad()
            configureAppearance()
        }
        
        override func viewWillAppear(_ animated: Bool) {
            configureNavigationBar()
        }
        
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.searchBar.endEditing(true)
        }
    }

    // MARK: - Privat Methods
    private extension SearchVC {
        
        func configureAppearance() {
            searchBar = UISearchBar(
                frame: CGRect(
                    x: 0,
                    y: 0,
                    width: 303,
                    height: 32)
            )
            searchBar.placeholder = "Поиск"
            searchBar.delegate = self
            searchBar.layer.cornerRadius = 22
            
            searchImageView.image = ConstantImages.searchEye
            searchLabel.font = .systemFont(
                ofSize: 14,
                weight: .light
            )
            searchLabel.text = "Введите ваш запрос"
            
            searchCollectionView.contentInset = .init(
                top: 10,
                left: 16,
                bottom: 10,
                right: 16
            )
            searchCollectionView.register(UINib(
                nibName: mainItemCollectionViewCell,
                bundle: .main), forCellWithReuseIdentifier: mainItemCollectionViewCell)
            searchCollectionView.delegate = self
            searchCollectionView.dataSource = self
        }
        
        func configureNavigationBar() {
            let backButton = UIBarButtonItem(
                image: ConstantImages.backArrow,
                style: .plain,
                target: navigationController,
                action: #selector(UINavigationController.popViewController(animated:)
                                     )
            )
            let searchBarItem = UIBarButtonItem(customView: searchBar)
            navigationItem.rightBarButtonItem = searchBarItem
            navigationItem.leftBarButtonItem = backButton
            navigationItem.leftBarButtonItem?.tintColor = ColorsExtension.black
            navigationController?.interactivePopGestureRecognizer?.delegate = self
        }
    }

    // MARK: - UISearchBarDelegate
    extension SearchVC: UISearchBarDelegate {
        
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            guard let searhText = searchBar.text else { return }
            searchBar.resignFirstResponder()
            if !searhText.isEmpty {
                posts = MainModel.shared.filteredPosts(searchText: searchBar.text ?? "")
                searchImageView.image = UIImage()
                searchLabel.text = ""
                if posts.isEmpty {
                    searchImageView.image = ConstantImages.sadSmile
                    searchLabel.text = "По этому запросу нет результатов, попробуйте другой запрос"
                    searchCollectionView.reloadData()
                } else {
                    searchCollectionView.reloadData()
                }
            } else {
                posts = []
                searchCollectionView.reloadData()
                searchImageView.image = ConstantImages.searchEye
                searchLabel.text = "Введите ваш запрос"
            }
        }
    }

    // MARK: - UITableViewDataSource, UITableViewDelegate, UICollectionViewDelegateFlowLayout
    extension SearchVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return posts.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: mainItemCollectionViewCell, for: indexPath)
            if let cell = cell as? MainItemCollectionViewCell {
                cell.imageUrlInString = posts[indexPath.item].imageUrlInString
                cell.isFavorite = posts[indexPath.item].isFavorite
                cell.titleLabel.text = posts[indexPath.item].title
                cell.didFavoritesTapped = { [weak self] in
                    self?.posts[indexPath.item].isFavorite.toggle()
                    guard let post = self?.posts[indexPath.item] else { return }
                    MainModel.shared.favoritePost(for: post)
                }
            }
            return cell
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let itemWidth = (view.frame.width - ConstantConstraints.collectionViewPadding * 2 - ConstantConstraints.hSpaceBetweenItems) / 2
            return CGSize(width: itemWidth, height: itemWidth * cellProportion)
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return ConstantConstraints.vSpaceBetweenItems
        }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let detailViewController = DetailViewController()
            detailViewController.model = posts[indexPath.item]
            navigationController?.pushViewController(detailViewController, animated: true)
        }
}
