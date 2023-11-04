//
//  MainPageController.swift
//  RecipesTestTask
//
//  Created by Vitaliy Halai on 4.11.23.
//

import UIKit
import SnapKit

//MARK: - MainPageController
final class MainPageController: UIViewController {
    
    //MARK: UI Elements
    private var recipesCollectionView: UICollectionView?
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    //MARK: Private methods
    private func setupUI() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Recipes"
        
        view.backgroundColor = .systemBackground
        
        setuprecipesCollection()
    }
    
    private func setuprecipesCollection() {
        
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.frame.size.width/2 - 6,
                                 height: 300)
        layout.minimumLineSpacing = 15
        layout.minimumInteritemSpacing = 4
        
        recipesCollectionView = UICollectionView(frame: .zero,
                                                 collectionViewLayout: layout)
        
        guard let recipesCollectionView else { return }
        recipesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        recipesCollectionView.backgroundColor = UIColor(named: "BackGround")
        
        recipesCollectionView.register(RecipesCVCell.self,
                                       forCellWithReuseIdentifier: RecipesCVCell.identifier)
        recipesCollectionView.showsHorizontalScrollIndicator = false
        recipesCollectionView.showsVerticalScrollIndicator = false
        
        
        view.addSubview(recipesCollectionView)
        
        recipesCollectionView.dataSource = self
        recipesCollectionView.delegate = self
        
        recipesCollectionView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalToSuperview().offset(4)
            $0.trailing.equalToSuperview().inset(4)
        }
        
        
    }
    

}

//MARK: - Collection data source
extension MainPageController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecipesCVCell.identifier, for: indexPath) as? RecipesCVCell else {
            return UICollectionViewCell()
        }
        
        return cell
    }
    
    
}

//MARK: collection delegate
extension MainPageController: UICollectionViewDelegate {
    
}
