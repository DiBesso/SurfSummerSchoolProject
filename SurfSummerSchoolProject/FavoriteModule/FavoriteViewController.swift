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
    private var model = MainModel.shared
    private var detailModel = [DetailItemModel]()
    private let tab = TabBarModel.self
    var didItemsUpdated: (() -> Void)?    
    //MARK: - Views
    
    var mainVC: MainViewController?
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearance()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
        configureModel()
        configureNavigationBar()
    }
    
    func configureNavigationBar() {
        navigationItem.title = "Избранное"
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
 
}
// MARK: - Private Methods

private extension FavoriteViewController {
    
    func configureModel() {
        detailModel = model.items.filter({ item in
            item.isFavorite == true
        })
        collectionView.reloadData()
    }
    
    func configureAppearance() {

        collectionView.register(UINib(nibName: "\(FavoriteCollectionViewCell.self)", bundle: .main),
            forCellWithReuseIdentifier: "\(FavoriteCollectionViewCell.self)")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.contentInset = .init(top: 10, left: 16, bottom: 10, right: 16)
    }
    
    //MARK: - Alert
    
    func alertForTapFavorites(forIndex: IndexPath, item: DetailItemModel) {
        let alert = UIAlertController(title: "Внимание!", message: "Вы точно хотите удалить из избранного?", preferredStyle: .alert)
        let buttonActionCancel = UIAlertAction(title: "Нет", style: .cancel)
        let buttonActionAccept = UIAlertAction(title: "Да, точно", style: .default) { _ in
            if let indexMain = (self.model.items.enumerated().first{ $1.id == item.id })?.offset {
                self.model.items[indexMain].isFavorite.toggle()
            }
            do {
                try DataManager().save(by: self.detailModel[forIndex.row].id, new: false)
                self.detailModel.remove(at: forIndex.row)
                self.collectionView.reloadData()
            } catch let error {
                print(error)
            }
        }
        alert.addAction(buttonActionCancel)
        alert.addAction(buttonActionAccept)
        alert.preferredAction = buttonActionAccept
        self.present(alert, animated: true)
    }
}

extension FavoriteViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return detailModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(FavoriteCollectionViewCell.self)", for: indexPath)
        if let cell = cell as? FavoriteCollectionViewCell {
            let item = detailModel[indexPath.item]
            cell.configure(model: item)
            cell.isFavorite = item.isFavorite
            cell.didFavoritesTapped = {
                self.alertForTapFavorites(forIndex: indexPath, item: item)
            }
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailViewController = DetailViewController()
        detailViewController.model = detailModel[indexPath.item]
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = (view.frame.width - Constants.horisontalInset * 2)
        return CGSize(width: itemWidth, height: Constants.aspectRatioWidthForHeight * itemWidth)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.spaceBetweenRows
    }
}

