//
//  ProfileStorage.swift
//  SurfSummerSchoolProject
//
//  Created by Дмитрий Бессонов on 05.09.2022.
//

import Foundation

protocol ProfileStorage {
    
     func getProfileInfo() throws -> ProfileModel
     func set(profile: ProfileModel) throws
     func removeProfile() throws
 }
