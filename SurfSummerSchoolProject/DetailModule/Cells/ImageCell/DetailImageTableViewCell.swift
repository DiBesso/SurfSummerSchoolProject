//
//  DetailImageTableViewCell.swift
//  SurfSummerSchoolProject
//
//  Created by Дмитрий Бессонов on 10.08.2022.
//

import UIKit

class DetailImageTableViewCell: UITableViewCell {

    // MARK: - Views
    @IBOutlet private weak var cartImageView: UIImageView!
    
    
    // MARK: - Properties
    
    var image: UIImage? {
        didSet {
            cartImageView.image = image
        }
    }
    
    // MARK: - UITableViewCell
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        cartImageView.layer.cornerRadius = 12
        cartImageView.contentMode = .scaleAspectFill
    }

 
    
}
