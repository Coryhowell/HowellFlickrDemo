//
//  PuppyViewController.swift
//  PuppyGram-Howell
//
//  Created by Cory Howell on 2/4/22.
//

import UIKit

class PuppyViewController: UICollectionViewController {
            
    var viewModel: PuppyViewModel?
    
    let inset: CGFloat = 5
    let minimumLineSpacing: CGFloat = 5
    let minimumInteritemSpacing: CGFloat = 5
    let cellsPerRow = 2
    
    init() {
        let layout = UICollectionViewFlowLayout()
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        
        viewModel = PuppyViewModel(delegate: self)
        viewModel?.getPuppies()
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView?.collectionViewLayout.invalidateLayout()
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    
    // MARK: Collection View delegate methods
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.puppies.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PuppyCell.identifier, for: indexPath) as! PuppyCell
        if let puppy = self.viewModel?.puppies[indexPath.item] {
            cell.setPuppy(puppy)
            
            viewModel?.getPuppyImage(puppy: puppy) { image in
                DispatchQueue.main.async {
                    cell.setPuppyImage(image: image)
                }
            }
        }
        return cell
    }
    
    
    private func setupCollectionView() {
        guard let navController = self.navigationController else { return }
        
        // Customize navigation bar.
        self.title = "PuppyGram"
        navController.navigationBar.tintColor = .black
        navController.navigationBar.barTintColor = .white
        navController.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        
        // Set up the collection view.
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.contentInsetAdjustmentBehavior = .always
        collectionView.backgroundColor = .white
        collectionView.alwaysBounceVertical = true
        collectionView.showsVerticalScrollIndicator = false 
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PuppyCell.self, forCellWithReuseIdentifier: PuppyCell.identifier)
    }
}
// MARK: UICollectionViewDelegateFlowLayout
extension PuppyViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let marginsAndInsets = inset * 2 + collectionView.safeAreaInsets.left + collectionView.safeAreaInsets.right + minimumInteritemSpacing * CGFloat(cellsPerRow - 1)
        let itemWidth = ((collectionView.bounds.size.width - marginsAndInsets) / CGFloat(cellsPerRow)).rounded(.down)
        return CGSize(width: itemWidth, height: itemWidth + 75)
   }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return minimumLineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return minimumInteritemSpacing
    }
}
// MARK: PuppyViewModelDelegate 
extension PuppyViewController: PuppyViewModelDelegate {
    func didUpdateState(_ state: FetchState) {
        switch state {
        case .fetchComplete:
            // Update collection view on the main thread.
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
            
        case .fetchError(let message):
            print(message)
            // handle error message...alert popup for user?
        }
    }
}
