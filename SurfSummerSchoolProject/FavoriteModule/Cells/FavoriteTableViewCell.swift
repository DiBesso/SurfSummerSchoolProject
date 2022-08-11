//
//  FavoriteTableViewCell.swift
//  SurfSummerSchoolProject
//
//  Created by Дмитрий Бессонов on 11.08.2022.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {

// MARK: - Views
    
    @IBOutlet private weak var cartImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var contentLabel: UILabel!
    @IBOutlet private weak var favoriteButton: UIButton!
    
    private let tableView = UITableView()
    
    // MARK: - Constants
    private enum Constants {
        static let fillHeartImage = UIImage(named: "heartFill")
        static let heartImage = UIImage(named: "heart")
    }
    
    // MARK: - Calculated
    var buttonImage: UIImage? {
        return isFavorite ? Constants.fillHeartImage : Constants.heartImage
    }
    
    // MARK: - Events
    var didFavoritesTapped: (() -> Void)?
    
    // MARK: - Properties
    
    var model: DetailItemModel?
    
    
    var text: String? {
        didSet {
            contentLabel.text = text
        }
    }
    var title: String = "" {
        didSet {
            titleLabel.text = title
        }
    }

    var date: String = "" {
        didSet {
            dateLabel.text = date
        }
    }
    var image: UIImage? {
        didSet {
            cartImageView.image = image
        }
    }
    var isFavorite: Bool = false {
        didSet {
            favoriteButton.setImage(buttonImage, for: .normal)
        }
    }
    
    // MARK: - Actions
    
    @IBAction func favoriteAction(_ sender: UIButton) {
        didFavoritesTapped?()
        isFavorite.toggle()
    }
    
    // MARK: - UITableViewCell
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureAppearance()

    }

    private func configureAppearance() {
        
        selectionStyle = .none
        contentLabel.font = .systemFont(ofSize: 12, weight: .light)
        contentLabel.textColor = .black
        contentLabel.numberOfLines = 0
        
        selectionStyle = .none
        titleLabel.font = .systemFont(ofSize: 16)
        dateLabel.font = .systemFont(ofSize: 10)
        dateLabel.textColor = UIColor(displayP3Red: 0xB3 / 255, green: 0xB3 / 255, blue: 0xB3 / 255, alpha: 1)
        
        selectionStyle = .none
        cartImageView.layer.cornerRadius = 12
        cartImageView.contentMode = .scaleAspectFill
    }
}
