//
//  UIImageView+Extension.swift
//  RickAndMorty
//
//  Created by Khaled Hamed on 04/09/2024.
//

import UIKit
import Kingfisher

extension UIImageView {
    @objc func loadImageFromUrl(imageUrl: String, usePlaceholder: Bool = true ,placeHolderImage: UIImage = UIImage(named: "placeholder") ?? UIImage() , completion: ((UIImage)->())? = nil) {
        
        if let url = URL(string: imageUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? imageUrl) {
            let resource = Source.network(url)
            self.kf.setImage(
                with: resource,
                placeholder: (usePlaceholder ? placeHolderImage : nil ),
                options: [
                    .scaleFactor(UIScreen.main.scale),
                    .transition(.fade(1)),
                    .cacheOriginalImage
                ]) { result in
                    switch result {
                    case .success(let value):
                        completion?(value.image)
                    case .failure(let error):
                        print("Job failed: \(error.localizedDescription)")
                    }
                }
        }
        else {
            if usePlaceholder {
                self.image = placeHolderImage
            }
        }
    }
}
