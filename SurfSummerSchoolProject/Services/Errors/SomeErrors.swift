//
//  SomeErrors.swift
//  SurfSummerSchoolProject
//
//  Created by Дмитрий Бессонов on 08.09.2022.
//

import Foundation

enum SomeErrors: Error {
    case unknownError
    case urlWasNotFound
    case urlComponentWasNotCreated
    case parametersIsNotValidJsonObject
    case badRequest([String:String])
    case notNetworkConnection
    case unknownServerError
    case nonAuthorizedAccess
}
