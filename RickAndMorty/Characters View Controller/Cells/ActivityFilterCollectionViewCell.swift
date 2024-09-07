//
//  ActivityFilterCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Khaled Hamed on 07/09/2024.
//

import UIKit

class ActivityFilterCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var nameLabel: UILabel!
        
    override var isSelected: Bool {
        didSet {
            self.nameLabel.textColor = isSelected ? .blue : .black
            let borderColor: UIColor = isSelected ? .blue : .black
            self.containerView.layer.cornerRadius = min(self.containerView.frame.size.height, self.containerView.frame.size.width) / 2.0
            self.containerView.layer.masksToBounds = true
            self.containerView.layer.borderColor = borderColor.cgColor
            self.containerView.layer.borderWidth = 1
        }
    }
    
    var nameFont: UIFont {
        return nameLabel.font.withSize(14)
    }
    
    var namePadding: CGFloat {
        return self.contentView.bounds.width - nameLabel.bounds.width
    }
    
    var name: String! {
        didSet {
            self.nameLabel.text = name
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initViews()
    }
    
    private func initViews() {
        configureContainerView()
        configureNameLabel()
    }
    
    private func configureContainerView() {
        self.containerView.layer.cornerRadius = 8
        self.containerView.layer.masksToBounds = true
        let borderColor: UIColor = isSelected ? .blue : .black
        self.containerView.layer.borderColor = borderColor.cgColor
        self.containerView.layer.borderWidth = 1
    }

    private func configureNameLabel() {
        nameLabel.textColor = .black
        nameLabel.font = nameFont
    }
}
