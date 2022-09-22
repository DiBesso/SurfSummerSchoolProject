//
//  BaseProfileStorage.swift
//  SurfSummerSchoolProject
//
//  Created by Дмитрий Бессонов on 05.09.2022.
//

import Foundation

struct BaseProfileStorage: ProfileStorage {
    
    // MARK: - Private Properties
    private var unprotectedStorage: UserDefaults {
        UserDefaults.standard
    }
    
    //MARK: - Constants
    
    private let profileImageKey: String = "profileImage"
    private let firstNameKey: String = "firstName"
    private let secondNameKey: String = "secondName"
    private let statusKey: String = "status"
    private let cityKey: String = "city"
    private let phoneKey: String = "phone"
    private let emailKey: String = "email"
    
    // MARK: - TokenStorage
    func getProfileInfo() throws -> ProfileModel {
        let profile = try getProfileFromStorage()
        return profile
    }
    
    func set(profile: ProfileModel) throws {
        removeProfileFromStorage()
        saveProfileInStorage(profile: profile)
    }
    
    func removeProfile() throws {
        removeProfileFromStorage()
    }
}

// MARK: - Privat Methods
private extension BaseProfileStorage {
    
    enum Error: Swift.Error {
        case profileWasNotFound
    }
    
    func getProfileFromStorage() throws -> ProfileModel {
        guard let profileImage =
                unprotectedStorage.value(forKey: profileImageKey) as? String,
              let profileFirstName =
                unprotectedStorage.value(forKey: firstNameKey) as? String,
              let profileSecondName =
                unprotectedStorage.value(forKey: secondNameKey) as? String,
              let profileStatus =
                unprotectedStorage.value(forKey: statusKey) as? String,
              let profileCity =
                unprotectedStorage.value(forKey: cityKey) as? String,
              let profilePhone =
                unprotectedStorage.value(forKey: phoneKey) as? String,
              let profileEmail =
                unprotectedStorage.value(forKey: emailKey) as? String
        else {
            throw Error.profileWasNotFound
        }
        let profile = ProfileModel(
            profileImage: profileImage,
            firstName: profileFirstName,
            secondName: profileSecondName,
            status: profileStatus,
            city: profileCity,
            phone: profilePhone,
            email: profileEmail
        )
        return profile
    }
    
    func saveProfileInStorage(profile: ProfileModel) {
        unprotectedStorage.set(profile.profileImage, forKey: profileImageKey)
        unprotectedStorage.set(profile.firstName, forKey: firstNameKey)
        unprotectedStorage.set(profile.secondName, forKey: secondNameKey)
        unprotectedStorage.set(profile.status, forKey: statusKey)
        unprotectedStorage.set(profile.city, forKey: cityKey)
        unprotectedStorage.set(profile.phone, forKey: phoneKey)
        unprotectedStorage.set(profile.email, forKey: emailKey)
    }
    
    func removeProfileFromStorage() {
        unprotectedStorage.set(nil, forKey: profileImageKey)
        unprotectedStorage.set(nil, forKey: firstNameKey)
        unprotectedStorage.set(nil, forKey: secondNameKey)
        unprotectedStorage.set(nil, forKey: statusKey)
        unprotectedStorage.set(nil, forKey: cityKey)
        unprotectedStorage.set(nil, forKey: phoneKey)
        unprotectedStorage.set(nil, forKey: emailKey)
    }
}
