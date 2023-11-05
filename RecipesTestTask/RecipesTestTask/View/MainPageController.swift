//
//  MainPageController.swift
//  RecipesTestTask
//
//  Created by Vitaliy Halai on 4.11.23.
//

import UIKit
import SnapKit


protocol PossibleRecipeUpdateDelegate: AnyObject {
    func updateRecipe(with recipe: Recipe?)
}

//MARK: - Literals enum
private enum Constants {
    static let controllerTitle = "Recipes"
    static let recipeCollectionItemHeight: CGFloat = 200
    static let recipeCollectionItemWidth: CGFloat = UIScreen.main.bounds.size.width / 2 - 16
    static let recipeCollectionMinimumLineSpacing: CGFloat = 16
    static let recipeCollectionMinimumInteritemSpacing: CGFloat = 16
    static let recipeCollectionSideInset: CGFloat = 4
}

//MARK: - MainPageController
final class MainPageController: UIViewController {
    
    //MARK: UI Elements
    private lazy var recipesCollectionView = UICollectionView()
    
    //MARK: Properties
    private var recipes: [Recipe] = [
        Recipe(image: AppearenceManager.shared.recipeImage(withNumber: 1), name: "Best cake"),
        Recipe(image: AppearenceManager.shared.recipeImage(withNumber: 2), name: "Real good dish"),
        Recipe(image: AppearenceManager.shared.recipeImage(withNumber: 3), name: "Gods cocktail"),
        Recipe(image: AppearenceManager.shared.recipeImage(withNumber: 4), name: "Really tasty"),
        Recipe(image: AppearenceManager.shared.recipeImage(withNumber: 5), name: "Do u love the taste?"),
        Recipe(image: AppearenceManager.shared.recipeImage(withNumber: 3), name: "Gods cocktail"),
        Recipe(image: AppearenceManager.shared.recipeImage(withNumber: 4), name: "Really tasty"),
        Recipe(image: AppearenceManager.shared.recipeImage(withNumber: 5), name: "Do u love the taste?"),
    ]
    {
        didSet {
            recipesCollectionView.reloadData()
        }
    }
    
    private var indexToUpdate: Int?
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        connectionCheck()
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
    
    //MARK: Override methods
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        if editing {
            let deleteButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteTapped))
            navigationItem.leftBarButtonItems = [editButtonItem, deleteButton]
            navigationItem.rightBarButtonItem?.isHidden = true

        } else {
            navigationItem.leftBarButtonItems = [editButtonItem]
            navigationItem.rightBarButtonItem?.isHidden = false
            recipesCollectionView.indexPathsForSelectedItems?.forEach({ indexPath in
                recipesCollectionView.deselectItem(at: indexPath, animated: false)
            })
        }
    }
    
    //MARK: Private methods
    
    private func connectionCheck() {
        if NetworkMonitorManager.shared.isConnected {
            showInfoAlert(withTitle: "You're connected", withMessage: "Impressive! Your device is connected to the network!")
        } else {
            showInfoAlert(withTitle: "You're not connected :-(", withMessage: "Check your internet connection...")
        }
        
    }
    private func showAddRecipeAlert(
        withTitle title: String,
        withMessage message: String
    ) {
        let alert = UIAlertController(title: title , message: message, preferredStyle: .alert)
        alert.addTextField {
            $0.placeholder = "Recipe image name"
        }
        
        alert.addTextField {
            $0.placeholder = "Recipe name"
        }
        
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { [weak self] _ in
            guard let recipeImageField = alert.textFields?.first,
                  let recipeImageName = recipeImageField.text,
                  recipeImageName != "",
                  let recipeNameField = alert.textFields?[1],
                  let recipeName = recipeNameField.text,
                  recipeName != ""
            else {
                self?.showInfoAlert(withTitle: "Error", withMessage: "Please specify correct information")
                return
            }
            self?.recipes.append(Recipe(image: UIImage(named: recipeImageName) ?? UIImage() , name: recipeName))
            self?.showInfoAlert(withTitle: "Congratulations!", withMessage: "New recipe was succefully added")
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive))
        present(alert, animated: true)
        
    }
    
    //MARK: Targets
    @objc func addTapped() {
        showAddRecipeAlert(withTitle: "Adding new recipe", withMessage: "Please specify the information below")
    }
    
    @objc func deleteTapped() {
        recipesCollectionView.indexPathsForSelectedItems?.forEach({ indexPath in
            recipes.remove(at: indexPath.row)
        })
        isEditing = false
        showInfoAlert(withTitle: "Delete button tapped", withMessage: "Fantastic!")
        
    }
}

//MARK: - UI setup extension
private extension MainPageController {
    func setupUI() {
        title = Constants.controllerTitle
        view.backgroundColor = .systemBackground
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        navigationItem.rightBarButtonItem = addButton
        navigationItem.leftBarButtonItems = [editButtonItem]
        
        setupRecipesCollection()
    }
    
    
    func setupRecipesCollection() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: Constants.recipeCollectionItemWidth,
                                 height: Constants.recipeCollectionItemHeight)
        layout.minimumLineSpacing = Constants.recipeCollectionMinimumLineSpacing
        layout.minimumInteritemSpacing = Constants.recipeCollectionMinimumInteritemSpacing
        
        recipesCollectionView = UICollectionView(frame: .zero,
                                                 collectionViewLayout: layout)
        
        recipesCollectionView.backgroundColor = AppearenceManager.shared.backgroundColor
        
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
}

//MARK: - Collection data source
extension MainPageController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if recipes.isEmpty {
            showInfoAlert(withTitle: "Ooops...", withMessage: "Your recipes collection looks a bit empty ://")
        }
        return recipes.count
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
        guard !isEditing else { return }
        collectionView.deselectItem(at: indexPath, animated: false)
        let detailsVC = RecipeDetailsController(forRecipe: recipes[indexPath.row])
        detailsVC.delegate = self
        navigationController?.pushViewController(detailsVC, animated: true)
        indexToUpdate = indexPath.row
    }
    
    func collectionView(_ collectionView: UICollectionView, canEditItemAt indexPath: IndexPath) -> Bool {
        true
    }
    
}

//MARK: - Recipe delegate implementation
extension MainPageController: PossibleRecipeUpdateDelegate {
    func updateRecipe(with recipe: Recipe?) {
        guard let indexToUpdate,
              let recipe else { return }
        recipes[indexToUpdate] = recipe
    }
   
}
