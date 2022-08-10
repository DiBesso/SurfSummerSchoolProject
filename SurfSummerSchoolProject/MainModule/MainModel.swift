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
    
    var items: [DetailItemModel] = [] {
        didSet {
            didItemsUpdated?()
        }
    }
    
    //MARK: - Methods
    
    func getPosts() {
        items = Array(repeating: DetailItemModel.createDefault(), count: 100)
    }
}


