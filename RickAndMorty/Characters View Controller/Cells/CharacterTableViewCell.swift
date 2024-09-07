//
//  CharacterTableViewCell.swift
//  RickAndMorty
//
//  Created by Khaled Hamed on 04/09/2024.
//

import UIKit

class CharacterTableViewCell : UITableViewCell {

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var characterContainerView: UIView!
    @IBOutlet private weak var characterImageView: UIImageView!
    @IBOutlet private weak var characterNameLabel: UILabel!
    @IBOutlet private weak var characterParentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configureUI()
    }
    
    private func configureUI() {
        
        self.selectionStyle = .none
        self.containerView.clipsToBounds = true
        self.containerView.layer.cornerRadius = 8
        self.containerView.layer.borderWidth = 1
        self.containerView.layer.borderColor = UIColor.lightGray.cgColor
        
        self.characterImageView.clipsToBounds = true
        self.characterImageView.layer.cornerRadius = 8
        self.characterImageView.backgroundColor = .clear
        
        
        self.characterNameLabel.font = .boldSystemFont(ofSize: 16)
        self.characterNameLabel.textColor = .black
        
        self.characterParentLabel.font = .systemFont(ofSize: 14)
        self.characterParentLabel.textColor = .gray
        
    }
    
    func configureModel(model : CharacterTableViewCellModel?) {
        guard let model =  model else {return}
        
        self.characterImageView.loadImageFromUrl(imageUrl: model.characterModel.image)
        self.characterNameLabel.text = model.characterModel.name
        self.characterParentLabel.text = model.characterModel.species
        
        switch model.characterModel.statusValue {
        case .Dead:
            self.containerView.backgroundColor = UIColor(red: 255/255, green: 127/255, blue: 127/255, alpha: 0.6)
            self.containerView.layer.borderWidth = 0
        case .Alive:
            self.containerView.backgroundColor = UIColor(red: 173/255, green: 216/255, blue: 230/255, alpha: 0.6)
            self.containerView.layer.borderWidth = 0
        case .Unknown:
            self.containerView.backgroundColor = .white
            self.containerView.layer.borderWidth = 1
        }
    }
}
