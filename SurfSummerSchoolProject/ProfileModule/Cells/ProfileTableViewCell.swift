//
//  ProfileTableViewCell.swift
//  SurfSummerSchoolProject
//
//  Created by Дмитрий Бессонов on 05.09.2022.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
    
    //MARK: - Views
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    
    //MARK: - Properties
    var imageUrlInString: String = "" {
        didSet {
            guard let url = URL(string: imageUrlInString) else {
                return
            }
            profileImageView.loadImage(from: url)
        }
    }
    
    //MARK: - UITableViewCell
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        profileImageView.layer.cornerRadius = 12
    }
}
