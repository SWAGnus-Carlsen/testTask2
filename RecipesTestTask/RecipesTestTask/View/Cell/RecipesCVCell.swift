//
//  RecipesCVCell.swift
//  RecipesTestTask
//
//  Created by Vitaliy Halai on 4.11.23.
//


import UIKit

class RecipesCVCell: UICollectionViewCell {
    
    //MARK: Properties
    static let identifier = String(describing: RecipesCVCell.self)
    
    //MARK: UI Elements
    private let nameLabel: UILabel = {
        var label = UILabel ()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let image: UIImageView = {
        var imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    
    //MARK: Override methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(nameLabel)
        contentView.addSubview(image)
        contentView.backgroundColor = UIColor(named: "BackGround")
        contentView.layer.borderColor = UIColor(named: "ForeGround")?.cgColor
        contentView.layer.borderWidth = 1
        nameLabel.textColor = UIColor(named: "ForeGround")
        contentView.layer.cornerRadius = contentView.frame.height / 8
        image.layer.cornerRadius = contentView.layer.cornerRadius
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        image.frame = CGRect (x: 8,
                                     y: 0,
                                     width: contentView.frame.size.width - 16,
                                     height: contentView.frame.size.height * 1/2)
        nameLabel.frame = CGRect (x: 0,
                                     y: image.frame.maxY,
                                     width: contentView.frame.size.width,
                                     height: contentView.frame.size.height * 1/2)
        
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        image.image = nil
        nameLabel.text = nil
        contentView.layer.borderColor = UIColor(named: "ForeGround")?.cgColor
       
    }
    

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Custom methods declaration
    func config() {
   
    }
    
   
}
