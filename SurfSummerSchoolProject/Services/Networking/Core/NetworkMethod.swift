//
//  HTTPNetworkMethod.swift
//  SurfSummerSchoolProject
//
//  Created by Дмитрий Бессонов on 14.08.2022.
//

import Foundation

enum NetworkMethod: String {

    case get
    case post

}

extension NetworkMethod {

    var method: String {
        rawValue.uppercased()
    }

}
