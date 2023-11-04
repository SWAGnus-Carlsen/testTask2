//
//  MainPageController.swift
//  RecipesTestTask
//
//  Created by Vitaliy Halai on 4.11.23.
//

import UIKit
import SnapKit

//MARK: - Literals enum
private enum Constants {
    static let controllerTitle = "Recipes"
    static let recipeCollectionItemHeight: CGFloat = 200
    static let recipeCollectionItemWidth: CGFloat = UIScreen.main.bounds.size.width/2 - 16
    static let recipeCollectionMinimumLineSpacing: CGFloat = 15
    static let recipeCollectionMinimumInteritemSpacing: CGFloat = 16
    static let recipeCollectionSideInset: CGFloat = 4
    
}

//MARK: - MainPageController
final class MainPageController: UIViewController {
    
    //MARK: UI Elements
    private lazy var recipesCollectionView = UICollectionView()
    
    //MARK: Properties
    private var recipes: [Recipe] = [
        Recipe(image: UIImage(named: "recipe1")!, name: "Best cake"),
        Recipe(image: UIImage(named: "recipe2")!, name: "Real good dish"),
        Recipe(image: UIImage(named: "recipe3")!, name: "Gods cocktail"),
        Recipe(image: UIImage(named: "recipe4")!, name: "Smth else"),
        Recipe(image: UIImage(named: "recipe5")!, name: "Also smth"),
        Recipe(image: UIImage(named: "recipe3")!, name: "Gods cocktail"),
        Recipe(image: UIImage(named: "recipe4")!, name: "Smth else"),
        Recipe(image: UIImage(named: "recipe5")!, name: "Also smth"),
    ]
    {
        didSet {
            recipesCollectionView.reloadData()
        }
    }
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        recipesCollectionView.reloadData()
    }
    
    //MARK: Private methods
    private func setupUI() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = Constants.controllerTitle
        view.backgroundColor = .systemBackground
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        navigationItem.leftBarButtonItem = editButtonItem
        
        setupRecipesCollection()
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        recipesCollectionView.allowsMultipleSelection = editing
    }
    
    private func setupRecipesCollection() {
        
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: Constants.recipeCollectionItemWidth,
                                 height: Constants.recipeCollectionItemHeight)
        layout.minimumLineSpacing = Constants.recipeCollectionMinimumLineSpacing
        layout.minimumInteritemSpacing = Constants.recipeCollectionMinimumInteritemSpacing
        
        recipesCollectionView = UICollectionView(frame: .zero,
                                                 collectionViewLayout: layout)
        
        recipesCollectionView.backgroundColor = UIColor(named: "BackGround")
        
        recipesCollectionView.register(RecipesCVCell.self,
                                       forCellWithReuseIdentifier: RecipesCVCell.identifier)
        recipesCollectionView.showsHorizontalScrollIndicator = false
        recipesCollectionView.showsVerticalScrollIndicator = false
        
        
        view.addSubview(recipesCollectionView)
        
        recipesCollectionView.dataSource = self
        recipesCollectionView.delegate = self
        
        recipesCollectionView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(Constants.recipeCollectionSideInset)
            $0.trailing.equalToSuperview().inset(Constants.recipeCollectionSideInset)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        
    }
    
    @objc func addTapped() {
        
    }

}

//MARK: - Collection data source
extension MainPageController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        recipes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard !recipes.isEmpty,
              let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecipesCVCell.identifier, for: indexPath) as? RecipesCVCell else {
            return UICollectionViewCell()
        }
        let currentRecipe = recipes[indexPath.row]
        cell.configure(
            withImg: currentRecipe.image,
            withName: currentRecipe.name
        )
        return cell
    }
    
    
}

//MARK: - Collection delegate
extension MainPageController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigationController?.pushViewController(RecipeDetailsController(forRecipe: recipes[indexPath.row]), animated: true)
    }
}
