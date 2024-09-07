//
//  ViewController+TableView.swift
//  RickAndMorty
//
//  Created by Khaled Hamed on 04/09/2024.
//

import Foundation
import UIKit

extension ViewController : UITableViewDataSource , UITableViewDelegate {
    
    func registerTableView() {
        self.tableView.separatorStyle = .none
        self.tableView.register(UINib(nibName: characterCellID, bundle: nil), forCellReuseIdentifier: characterCellID)
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: characterCellID, for: indexPath) as? CharacterTableViewCell {
            let cellModel = CharacterTableViewCellModel(characterModel: self.dataSource[indexPath.row])
            cell.configureModel(model: cellModel)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let characterModel = self.dataSource[indexPath.row]
        self.navigateToCharacterDetails(characterModel: characterModel)
    }

}
