//
//  DataManager.swift
//  SurfSummerSchoolProject
//
//  Created by Дмитрий Бессонов on 18.08.2022.
//

import Foundation
import UIKit

final class DataManager {
    

    private let favoriteKey = "favorite"
    static let shared = DataManager()
    
    private let userDefaults = UserDefaults.standard
    
    private init() {}
    
    
    func save(model: FavoriteModel) {
        var contentInFavorite = fetchContentInFavorite()
        contentInFavorite.append(model)
        
        guard let data = try? JSONEncoder().encode(contentInFavorite) else { return }
        userDefaults.set(data, forKey: favoriteKey)
    }
    
    
    func fetchContentInFavorite() -> [FavoriteModel] {
        guard let data = userDefaults.object(forKey: favoriteKey) as? Data else { return [] }
        guard let contentInFavorite = try? JSONDecoder().decode([FavoriteModel].self, from: data) else { return [] }
        
        return contentInFavorite
    }
    
    func deleteContentFromFavorite(at index: Int) {
        var contentInFavorite = fetchContentInFavorite()
        var content = contentInFavorite.remove(at: index)
        content.isFavorite.toggle()
        
        guard let data = try? JSONEncoder().encode(contentInFavorite) else { return }
        userDefaults.set(data, forKey: favoriteKey)
    }
    
    func changeFavoriteStatus(at index: Int) {
        var contentInFavorite = fetchContentInFavorite()
        var content = contentInFavorite.remove(at: index)
        content.isFavorite.toggle()
        contentInFavorite.insert(content, at: index)
        
        guard let data = try? JSONEncoder().encode(contentInFavorite) else { return }
        userDefaults.set(data, forKey: favoriteKey)
    }
}
