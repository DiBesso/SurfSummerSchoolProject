//
//  AlertController.swift
//  SurfSummerSchoolProject
//
//  Created by Дмитрий Бессонов on 20.08.2022.
//

import UIKit

extension UIAlertController {
    
    static func createAlertController(withTitle title: String) -> UIAlertController {
        UIAlertController(title: title, message: "Вы точно хотите удалить из избранного?", preferredStyle: .alert)
    }
    
    func action(index: Int, completion: @escaping (String) -> Void) {
        let yesAlert = UIAlertAction(title: "Да, точно", style: .default) { _ in
            DataManager.shared.deleteContentFromFavorite(at: index)
        }
        addAction(yesAlert)
        addAction(UIAlertAction(title: "Нет", style: UIAlertAction.Style.cancel, handler: nil))
    }
}
