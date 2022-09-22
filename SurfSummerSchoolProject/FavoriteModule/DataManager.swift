//
//  DataManager.swift
//  SurfSummerSchoolProject
//
//  Created by Дмитрий Бессонов on 18.08.2022.
//

import Foundation

struct DataManager {
    
    // MARK: - Nested Types
    
    private enum Error: Swift.Error {
        case notFound
    }
    
    // MARK: - Private Properties
    
    private let favoriteKey = "favorite"
    private let suiteName = "com.favorite.images"
    private let userDefaults: UserDefaults
    
    init() throws {

        guard let userDefaults = UserDefaults(suiteName: suiteName) else {
            throw Error.notFound
        }
        self.userDefaults = userDefaults
    }
    
    // MARK: - Internal Methods
    
    func save(by id: String, new isFavoriteStatus: Bool) {
        var favorites = fetchContentInFavorite()
        if isFavoriteStatus {
            favorites.insert(id)
        } else {
            favorites.remove(id)
        }
        writeIntoStorage(newFavorites: favorites)
    }
  
    
    
    func fetchContentInFavorite() -> Set<String> {
        guard
            let data = userDefaults.object(forKey: favoriteKey) as? Data,
            let decodeData = try? JSONDecoder().decode(Set<String>.self, from: data)
        else {
            return []
        }
        return decodeData
    }

    
    func writeIntoStorage(newFavorites: Set<String>) {
        guard let encodeData = try? JSONEncoder().encode(newFavorites) else {
            return
        }
        UserDefaults.standard.set(encodeData, forKey: favoriteKey)
    }
    
    func getFavoriteStatus(by id: String) -> Bool {
        let favorites = fetchContentInFavorite()
        return favorites.contains(id)
    }
    
    func resetFavoriteStorage() {
        userDefaults.removeObject(forKey: favoriteKey)
        userDefaults.removeSuite(named: suiteName)
    }

}
