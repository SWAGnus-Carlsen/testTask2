//
//  RecipeDetailsController.swift
//  RecipesTestTask
//
//  Created by Vitaliy Halai on 4.11.23.
//

import UIKit
import SnapKit

//MARK: - Literals enum
private enum Constants {
    static let recipeImageHeight: CGFloat = 200
    static let imageSideOffset: CGFloat = 32
    static let headlineLabelOffset: CGFloat = 16
    static let infoLabelOffset: CGFloat = 32
    static let interLabelsSpacing: CGFloat = 8
}

//MARK: - RecipeDetailsController
final class RecipeDetailsController: UIViewController {

    //MARK: UI elements
    private let recipeImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let ingridientsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.text = "Ingridients:"
        return label
    }()
    
    private let ingredientsInfo: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "Here has to be whole lotta information about ingridients, but I'm just too lazy to do that :-( "
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private let instructionsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.text = "Instructions:"
        return label
    }()
    
    private let instructionsInfo: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "Here has to be whole lotta instructions, but again, I'm just too lazy to do that :-( "
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    weak var delegate: PossibleRecipeUpdateDelegate?
    
    //MARK: Constructor
    init(forRecipe recipe: Recipe) {
        super.init(nibName: nil, bundle: nil)
        fillView(withRecipeData: recipe)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //MARK: Private methods
    private func fillView(withRecipeData recipe: Recipe) {
        title = recipe.name
        recipeImage.image = recipe.image
        if !recipe.ingridients.isEmpty {
            ingredientsInfo.text = recipe.ingridients
        }
        if !recipe.instructions.isEmpty {
            instructionsInfo.text = recipe.instructions
        }
    }
    
    private func showEditRecipeAlert(
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
        
        alert.addTextField {
            $0.placeholder = "Ingridients"
        }
        
        alert.addTextField {
            $0.placeholder = "Instructions"
        }
        
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { [weak self] _ in
            guard let recipeImageField = alert.textFields?.first,
                  let recipeImageName = recipeImageField.text,
                  recipeImageName != "",
                  let recipeNameField = alert.textFields?[1],
                  let recipeName = recipeNameField.text,
                  recipeName != "",
                  let IngridientsField = alert.textFields?[2],
                  let ingridients = IngridientsField.text,
                  ingridients != "",
                  let instructionsField = alert.textFields?[3],
                  let instructions = instructionsField.text,
                  instructions != ""
            else {
                self?.showInfoAlert(withTitle: "Error", withMessage: "Please specify correct information")
                return
            }
            let newRecipeData = Recipe(
                image: UIImage(named: recipeImageName) ?? UIImage(),
                name: recipeName,
                ingridients: ingridients,
                instructions: instructions
            )
            self?.fillView(withRecipeData: newRecipeData)
            self?.delegate?.updateRecipe(with: newRecipeData)
            self?.showInfoAlert(withTitle: "Congratulations!", withMessage: "Recipe was succefully edited")
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive))
        present(alert, animated: true)
        
    }
    //MARK: Targets
    @objc private func editTapped() {
        showEditRecipeAlert(withTitle: "Editing recipe", withMessage: "Please fill correctly all the fields")
    }
}

//MARK: - UI setup extension
private extension RecipeDetailsController {
    func setupUI() {
        navigationController?.navigationBar.prefersLargeTitles = false
        let editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editTapped))
        navigationItem.rightBarButtonItem = editButton
        view.backgroundColor = AppearenceManager.shared.backgroundColor
        setupRecipeImage()
        setupIngridientsLabel()
        setupIngridientsInfo()
        setupInstructionsLabel()
        setupInstructionsInfo()
    }
    
    func setupRecipeImage() {
        view.addSubview(recipeImage)
        recipeImage.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalToSuperview().offset(Constants.imageSideOffset)
            make.trailing.equalToSuperview().inset(Constants.imageSideOffset)
            make.height.equalTo(Constants.recipeImageHeight)
        }
    }
    
    func setupIngridientsLabel() {
        view.addSubview(ingridientsLabel)
        ingridientsLabel.backgroundColor = AppearenceManager.shared.backgroundColor
        ingridientsLabel.textColor = AppearenceManager.shared.foregroundColor
        ingridientsLabel.snp.makeConstraints { make in
            make.top.equalTo(recipeImage.snp.bottom).offset(Constants.headlineLabelOffset)
            make.leading.equalToSuperview().offset(Constants.headlineLabelOffset)
        }
    }
    
    func setupIngridientsInfo() {
        view.addSubview(ingredientsInfo)
        ingredientsInfo.backgroundColor = AppearenceManager.shared.backgroundColor
        ingredientsInfo.textColor = AppearenceManager.shared.foregroundColor
        ingredientsInfo.snp.makeConstraints { make in
            make.top.equalTo(ingridientsLabel.snp.bottom).offset(Constants.interLabelsSpacing)
            make.leading.equalToSuperview().offset(Constants.infoLabelOffset)
            make.trailing.equalToSuperview().inset(Constants.infoLabelOffset)
        }
    }
    
    func setupInstructionsLabel() {
        view.addSubview(instructionsLabel)
        instructionsLabel.backgroundColor = AppearenceManager.shared.backgroundColor
        instructionsLabel.textColor = AppearenceManager.shared.foregroundColor
        instructionsLabel.snp.makeConstraints { make in
            make.top.equalTo(ingredientsInfo.snp.bottom).offset(Constants.headlineLabelOffset)
            make.leading.equalToSuperview().offset(Constants.headlineLabelOffset)
        }
    }
    
    func setupInstructionsInfo() {
        view.addSubview(instructionsInfo)
        instructionsInfo.backgroundColor = AppearenceManager.shared.backgroundColor
        instructionsInfo.textColor = AppearenceManager.shared.foregroundColor
        instructionsInfo.snp.makeConstraints { make in
            make.top.equalTo(instructionsLabel.snp.bottom).offset(Constants.interLabelsSpacing)
            make.leading.equalToSuperview().offset(Constants.infoLabelOffset)
            make.trailing.equalToSuperview().inset(Constants.infoLabelOffset)
        }
    }
}

