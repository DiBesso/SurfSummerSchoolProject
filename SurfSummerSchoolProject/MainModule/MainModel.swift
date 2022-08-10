//
//  MainModel.swift
//  SurfSummerSchoolProject
//
//  Created by Дмитрий Бессонов on 10.08.2022.
//

import Foundation
import UIKit

final class MainModel {
    
    // MARK: - Events
    var didItemsUpdated: (() -> Void)?
    
    //MARK: - Properties
    
    var items: [ItemModel] = [] {
        didSet {
            didItemsUpdated?()
        }
    }
    
    //MARK: - Methods
    
    func getPosts() {
        items = Array(repeating: ItemModel.createDefault(), count: 100)
    }
}

struct ItemModel {
    let image: UIImage?
    let title: String
    var isFavorite: Bool
    let dateCreation: String
    let content: String
    
    static func createDefault() -> ItemModel {
        .init(image: UIImage(named: "corgi"), title: "Самый милый корги", isFavorite: false, dateCreation: "12.05.2022", content: "Здесь будет какая-то очень интересная информация, но потом")
    }
}
