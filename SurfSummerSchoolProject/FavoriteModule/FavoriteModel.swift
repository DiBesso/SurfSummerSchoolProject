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


    // MARK: - Initialization
//    internal init(imageUrlInString: String, title: String, isFavorite: Bool, content: String, dateCreation: Date) 
//        self.imageUrlInString = imageUrlInString
//        self.title = title
//        self.isFavorite = isFavorite
//        self.content = content
//
//        let formatter = DateFormatter()
//        formatter.dateFormat = "dd.MM.yyyy"
//
//        self.dateCreation = formatter.string(from: dateCreation)
    

}
