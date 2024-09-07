//
//  ViewController+CollectionView.swift
//  RickAndMorty
//
//  Created by Khaled Hamed on 07/09/2024.
//

import Foundation
import UIKit

extension ViewController : UICollectionViewDelegate , UICollectionViewDataSource {
    func configureCollectionView() {
        filterCollectionView.register(UINib(nibName: activityFilterCellName, bundle: nil), forCellWithReuseIdentifier: activityFilterCellName)
        filterCollectionView.delegate = self
        filterCollectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: activityFilterCellName, for: indexPath) as? ActivityFilterCollectionViewCell ?? ActivityFilterCollectionViewCell()
        cell.name = self.viewModel.filterData[indexPath.row].rawValue
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cell = Bundle.main.loadNibNamed(activityFilterCellName, owner: nil, options: nil)?.first as? ActivityFilterCollectionViewCell ?? ActivityFilterCollectionViewCell()
        let name = self.viewModel.filterData[indexPath.row].rawValue
        let estimatedWidth = name.width(withConstrainedHeight: collectionView.bounds.height, font: cell.nameFont) + cell.namePadding
        return CGSize(width: estimatedWidth, height: collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let filteredValue = self.viewModel.filterData[indexPath.row]
        let filteredData = self.viewModel.getFilteredArray(filteredType: filteredValue)
        self.dataSource = filteredData
        self.tableView.reloadData()
        self.tableView.finishInfiniteScroll()
        self.removeInfiniteScroll()
    }
    
    
}
