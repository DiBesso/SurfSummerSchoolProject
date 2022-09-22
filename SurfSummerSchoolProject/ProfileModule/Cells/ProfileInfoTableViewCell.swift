//
//  ProfileInfoTableViewCell.swift
//  SurfSummerSchoolProject
//
//  Created by Дмитрий Бессонов on 05.09.2022.
//

import UIKit

class ProfileInfoTableViewCell: UITableViewCell {
    
    //MARK: - Views
    
    @IBOutlet weak var profileTitleLabel: UILabel!
    @IBOutlet weak var profileDetailLabel: UILabel!
    
    
    //MARK: - UITableViewCell
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    } 
}
