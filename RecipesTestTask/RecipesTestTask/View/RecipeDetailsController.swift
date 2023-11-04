//
//  RecipeDetailsController.swift
//  RecipesTestTask
//
//  Created by Vitaliy Halai on 4.11.23.
//

import UIKit
import SnapKit

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
        label.text = "Here has to be whole lotta instructions, but I'm just too lazy to do that :-( "
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    //MARK: Constructor
    init(forRecipe recipe: Recipe) {
        super.init(nibName: nil, bundle: nil)
        title = recipe.name
        recipeImage.image = recipe.image
        
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
    private func setupUI() {
        navigationController?.navigationBar.prefersLargeTitles = false
        view.backgroundColor = .systemBackground
        setupRecipeImage()
        setupIngridientsLabel()
        setupIngridientsInfo()
        setupInstructionsLabel()
        setupInstructionsInfo()
    }
    
    private func setupRecipeImage() {
        view.addSubview(recipeImage)
        recipeImage.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalToSuperview().inset(-32)
            make.trailing.equalToSuperview().offset(32)
            make.height.equalTo(200)
        }
    }
    
    private func setupIngridientsLabel() {
        view.addSubview(ingridientsLabel)
        ingridientsLabel.snp.makeConstraints { make in
            make.top.equalTo(recipeImage.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
        }
    }
    
    private func setupIngridientsInfo() {
        view.addSubview(ingredientsInfo)
        ingredientsInfo.snp.makeConstraints { make in
            make.top.equalTo(ingridientsLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(32)
            make.trailing.equalToSuperview().inset(32)
        }
    }
    
    private func setupInstructionsLabel() {
        view.addSubview(instructionsLabel)
        instructionsLabel.snp.makeConstraints { make in
            make.top.equalTo(ingredientsInfo.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
        }
    }
    
    private func setupInstructionsInfo() {
        view.addSubview(instructionsInfo)
        instructionsInfo.snp.makeConstraints { make in
            make.top.equalTo(instructionsLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(32)
            make.trailing.equalToSuperview().inset(32)
        }
    }

}
