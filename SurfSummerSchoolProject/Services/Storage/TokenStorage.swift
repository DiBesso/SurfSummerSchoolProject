//
//  TokenStorage.swift
//  SurfSummerSchoolProject
//
//  Created by Дмитрий Бессонов on 14.08.2022.
//

import Foundation

protocol TokenStorage {

    func getToken() throws -> TokenContainer
    func set(newToken: TokenContainer) throws

}
