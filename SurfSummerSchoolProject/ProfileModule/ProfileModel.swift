//
//  ProfileModel.swift
//  SurfSummerSchoolProject
//
//  Created by Дмитрий Бессонов on 05.09.2022.
//

import Foundation

struct ProfileModel: Decodable {
    
    let profileImage: String
    let firstName: String
    let secondName: String
    let status: String
    let city: String
    let phone: String
    let email: String
}

struct ProfileExample {
    static let shared = ProfileExample()
    let profileModel: ProfileModel
    
    init() {
        let storage = BaseProfileStorage()
        do {
        let profile = try storage.getProfileInfo()
        self.profileModel = profile
        } catch {
        print(error)
            self.profileModel = ProfileModel(
                profileImage: "avatar",
                firstName: "Дмитрий",
                secondName: "Бессонов",
                status: "Я начинаю свой путь в IT",
                city: "Новосибирск",
                phone: "+7 (983) 304 28 06",
                email: "besson.dmitry@gmail.com"
            )
        }
    }
}
