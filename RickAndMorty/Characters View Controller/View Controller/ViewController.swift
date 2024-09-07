//
//  ViewController.swift
//  RickAndMorty
//
//  Created by Khaled Hamed on 04/09/2024.
//

import UIKit
import UIScrollView_InfiniteScroll
import SwiftUI

class ViewController: UIViewController {

    
    var dataSource : [CharacterModel] = []
   
    let characterCellID = "CharacterTableViewCell"
    let activityFilterCellName = "ActivityFilterCollectionViewCell"
    @IBOutlet weak var tableView : UITableView!
    
    @IBOutlet weak var filterCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let apiGate = CharactersApiGate()
        self.viewModel = CharactersViewModel(charactersApiGate: apiGate)
        self.getExchangeRates()
        self.registerTableView()
        self.configureCollectionView()
    }
    
    
    
    var viewModel : CharactersViewModelProtocol!
    let indicator: UIActivityIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
    

    private func getExchangeRates() {
        self.configureIndicator()
        self.getInitialCharacters()
    }
    
    private func getInitialCharacters(){
        self.indicator.startAnimating()
        self.viewModel.getCharacters(onSuccess: { [weak self] characters in
            guard let self = self else {return}
            DispatchQueue.main.async {
                self.removeIndicator()
                self.viewModel.originalCharactersArray = characters.results
                self.dataSource = self.viewModel.originalCharactersArray
                self.addingInfiniteScroll()
                self.tableView.reloadData()
            }
        }, onFailure: { error in
            
        })
    }
    
    func addingInfiniteScroll() {
        tableView.addInfiniteScroll { [weak self] (tableView) -> Void in
            guard let self = self else {return}
            self.viewModel.pageNumber += 1
            self.viewModel.getCharacters(onSuccess: { [weak self] characters in
                guard let self = self else {return}
                DispatchQueue.main.async {
                    guard characters.results.count > 0 else {
                        self.tableView.finishInfiniteScroll()
                        self.removeInfiniteScroll()
                        return
                    }
                    
                    let oldCount = self.dataSource.count
                    let newCount = oldCount + characters.results.count
                    let (start, end) = (oldCount, newCount)
                    let indexPaths = (start..<end).map {return IndexPath(row: $0, section: 0)}
                    self.dataSource.append(contentsOf: characters.results)
                    self.tableView.beginUpdates()
                    self.tableView.insertRows(at: indexPaths, with: .automatic)
                    self.tableView.endUpdates()
                    self.tableView.finishInfiniteScroll()
                    self.addingInfiniteScroll()
                    self.removeIndicator()
                }
            }, onFailure: { error in
                
            })
        }
    }
    func removeInfiniteScroll() {
        tableView.removeInfiniteScroll()
    }
    
    private func configureIndicator() {
         indicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
         indicator.tag = 5
         indicator.center = view.center
         self.view.addSubview(indicator)
        self.view.bringSubviewToFront(indicator)
    }
    
    private func removeIndicator() {
        for subView in self.view.subviews {
            if subView.tag == indicator.tag {
                self.view.sendSubviewToBack(subView)
                subView.removeFromSuperview()
                
            }
        }
    }
    
    
    func navigateToCharacterDetails(characterModel : CharacterModel) {
        let characterDetailsView = CharacterDetailsViewController(characterDetails: characterModel)
        let hostingViewController = UIHostingController(rootView: characterDetailsView)
        self.navigationController?.navigationItem.backBarButtonItem = nil
        self.navigationController?.pushViewController(hostingViewController, animated: true)
    }

}

