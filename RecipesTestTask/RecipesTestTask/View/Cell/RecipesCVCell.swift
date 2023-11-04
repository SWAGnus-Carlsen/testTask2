//
//  RecipesCVCell.swift
//  RecipesTestTask
//
//  Created by Vitaliy Halai on 4.11.23.
//


import UIKit

final class RecipesCVCell: UICollectionViewCell {
    
    //MARK: Properties
    static let identifier = String(describing: RecipesCVCell.self)
    
    //MARK: UI Elements
    private let nameLabel: UILabel = {
        var label = UILabel ()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let imageView: UIImageView = {
        var imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    
    //MARK: Override methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(nameLabel)
        contentView.addSubview(imageView)
        contentView.backgroundColor = UIColor(named: "BackGround")
        contentView.layer.borderColor = UIColor(named: "ForeGround")?.cgColor
        contentView.layer.borderWidth = 1
        nameLabel.textColor = UIColor(named: "ForeGround")
        contentView.layer.cornerRadius = contentView.frame.height / 8
        contentView.clipsToBounds = true
        //imageView.layer.cornerRadius = contentView.layer.cornerRadius
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = CGRect (x: 0,
                                     y: 0,
                                     width: contentView.frame.size.width,
                                     height: contentView.frame.size.height * 2/3)
        nameLabel.frame = CGRect (x: 0,
                                     y: imageView.frame.maxY,
                                     width: contentView.frame.size.width,
                                     height: contentView.frame.size.height * 1/3)
        
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        nameLabel.text = nil
        contentView.layer.borderColor = UIColor(named: "ForeGround")?.cgColor
       
    }
    

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Custom methods declaration
    public func configure(
        withImg image: UIImage,
        withName name: String
    ) {
        imageView.image = image
        nameLabel.text = name
    }
    
   
}
