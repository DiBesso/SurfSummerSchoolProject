//
//  MainModel.swift
//  SurfSummerSchoolProject
//
//  Created by Дмитрий Бессонов on 10.08.2022.
//

import Foundation
import UIKit

final class MainModel {

    static let shared = MainModel.init()
    // MARK: - Events
    var didItemsUpdated: (() -> Void)?

    // MARK: - Properties
    let pictureService = PicturesService()
    var posts: [DetailItemModel] = []
    var items: [DetailItemModel] = [] {
        didSet {
            didItemsUpdated?()
        }
    }
    var favoritePosts: [DetailItemModel] {
        posts.filter { $0.isFavorite }
    }

    // MARK: - Methods
    
    func filteredPosts(searchText: String) -> [DetailItemModel] {
        posts.filter { $0.title.lowercased().contains(searchText.lowercased()) }
    }
    
    func favoritePost(for post: DetailItemModel) {
        guard let index = posts.firstIndex(where: { $0.title == post.title }) else { return }
        posts[index].isFavorite.toggle()
    }
    
    func loadPosts() {
        pictureService.loadPictures { [weak self] result in
            switch result {
            case .success(let pictures):
                self?.items = pictures.map { pictureModel in
                    DetailItemModel(
                        id: pictureModel.id,
                        imageUrlInString: pictureModel.photoUrl,
                        title: pictureModel.title,
                        isFavorite: false, // TODO: - Need adding `FavoriteService`
                        content: pictureModel.content,
                        dateCreation: pictureModel.date
                    )
                }
            case .failure(let error):
                // TODO: - Implement error state there
                break
            }
        }
    }
}


