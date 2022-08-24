//
//  FavoriteModel.swift
//  SurfSummerSchoolProject
//
//  Created by Дмитрий Бессонов on 18.08.2022.
//

import Foundation

struct FavoriteModel: Codable {

    // MARK: - Internal Properties
    let imageUrlInString: String
    let title: String
    var isFavorite: Bool
    let content: String
    let dateCreation: String

}
