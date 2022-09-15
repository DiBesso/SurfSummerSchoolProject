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
    
    //    static let shared = DataManager()
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
    //    func save(model: FavoriteModel) {
    //        var contentInFavorite = fetchContentInFavorite()
    //        contentInFavorite.append(model)
    //
    //        guard let data = try? JSONEncoder().encode(contentInFavorite) else { return }
    //        userDefaults.set(data, forKey: favoriteKey)
    //    }
    
    
    func fetchContentInFavorite() -> Set<String> {
        guard
            let data = userDefaults.object(forKey: favoriteKey) as? Data,
            let decodeData = try? JSONDecoder().decode(Set<String>.self, from: data)
        else {
            return []
        }
        return decodeData
    }
//    func fetchContentInFavorite() -> [FavoriteModel] {
//        guard let data = userDefaults.object(forKey: favoriteKey) as? Data else { return [] }
//        guard let contentInFavorite = try? JSONDecoder().decode([FavoriteModel].self, from: data) else { return [] }
//
//        return contentInFavorite
//    }
    
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
//    func deleteContentFromFavorite(at index: Int) {
//        var contentInFavorite = fetchContentInFavorite()
//        var content = contentInFavorite.remove(at: index)
//        content.isFavorite.toggle()
//
//        guard let data = try? JSONEncoder().encode(contentInFavorite) else { return }
//        userDefaults.set(data, forKey: favoriteKey)
//    }
    
//    func changeFavoriteStatus(at index: Int) {
//        var contentInFavorite = fetchContentInFavorite()
//        var content = contentInFavorite.remove(at: index)
//        content.isFavorite.toggle()
//        contentInFavorite.insert(content, at: index)
//
//        guard let data = try? JSONEncoder().encode(contentInFavorite) else { return }
//        userDefaults.set(data, forKey: favoriteKey)
//    }
}
