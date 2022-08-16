//
//  TokenContainer.swift
//  SurfSummerSchoolProject
//
//  Created by Дмитрий Бессонов on 14.08.2022.
//

import Foundation

struct TokenContainer {

    let token: String
    let receivingDate: Date

    var tokenExpiringTime: TimeInterval {
        39600
    }

    var isExpired: Bool {
        let now = Date()
        if receivingDate.addingTimeInterval(tokenExpiringTime) > now {
            return false
        } else {
            return true
        }
    }

}
