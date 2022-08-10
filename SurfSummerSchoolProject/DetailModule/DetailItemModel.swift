//
//  DetailItemModel.swift
//  SurfSummerSchoolProject
//
//  Created by Дмитрий Бессонов on 11.08.2022.
//

import Foundation
import UIKit

struct DetailItemModel {
    let image: UIImage?
    let title: String
    var isFavorite: Bool
    let dateCreation: String
    let content: String
    
    static func createDefault() -> DetailItemModel {
        .init(image: UIImage(named: "corgi"), title: "Самый милый корги", isFavorite: false, dateCreation: "12.05.2022", content: "Здесь будет какая-то очень интересная информация, но потом")
    }
}
