//
//  FavoriteCollectionViewCell.swift
//  SurfSummerSchoolProject
//
//  Created by Дмитрий Бессонов on 13.08.2022.
//

import UIKit

class FavoriteCollectionViewCell: UICollectionViewCell {

    // MARK: - Constants
    private enum Constants {
        static let fillHeartImage = UIImage(named: "heartFill")
        static let heartImage = UIImage(named: "heart")
    }
    
    // MARK: - Views
        
        @IBOutlet private weak var cartImageView: UIImageView!
        @IBOutlet private weak var titleLabel: UILabel!
        @IBOutlet private weak var dateLabel: UILabel!
        @IBOutlet private weak var contentLabel: UILabel!
        @IBOutlet private weak var favoriteButton: UIButton!
    
    // MARK: - Events
    var didFavoritesTapped: (() -> Void)?

    // MARK: - Calculated
    var buttonImage: UIImage? {
        return isFavorite ? Constants.fillHeartImage : Constants.heartImage
    }

    override var isHighlighted: Bool {
        didSet {
            animationTapCell()
        }
    }
    // MARK: - Properties
    var model: DetailItemModel?
    
    var isFavorite: Bool = true {
        didSet {
            favoriteButton.setImage(buttonImage, for: .normal)
            if isFavorite == false {
                favoriteButton.isEnabled = true
            }
        }
    }
    
    // MARK: - Actions
    
    @IBAction func favoriteAction(_ sender: UIButton) {
        didFavoritesTapped?()
//        isFavorite.toggle()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureAppearance()
    }

    func animationTapCell() {
        let cellReduction = CGAffineTransform(scaleX: 0.98, y: 0.98)
        UIView.animate(withDuration: 0.2) {
            self.contentView.transform = self.isHighlighted ? cellReduction : .identity
        }
    }
    
    func configure(model: DetailItemModel) {
        titleLabel.text = model.title
        contentLabel.text = model.content
        dateLabel.text = model.dateCreation
        let imageUrl = model.imageUrlInString
        guard let url = URL(string: imageUrl) else {
            return
        }
        cartImageView.loadImage(from: url)
    }
}


private extension FavoriteCollectionViewCell {
    
    func configureAppearance() {

        contentLabel.font = .systemFont(ofSize: 12, weight: .light)
        contentLabel.textColor = .black
        contentLabel.numberOfLines = 1
        
        titleLabel.font = .systemFont(ofSize: 16)
        dateLabel.font = .systemFont(ofSize: 10)
        dateLabel.textColor = UIColor(displayP3Red: 0xB3 / 255, green: 0xB3 / 255, blue: 0xB3 / 255, alpha: 1)
        
        cartImageView.layer.cornerRadius = 12
        cartImageView.contentMode = .scaleAspectFill
    }
    
}
