//
//  AppearenceManager.swift
//  RecipesTestTask
//
//  Created by Vitaliy Halai on 5.11.23.
//

import UIKit

final class AppearenceManager : NSObject {
    
    //MARK: Singleton
    static let shared = AppearenceManager()
    
    //MARK: Constructor
    private override init(){ }
    
    //MARK: Colors
    public var backgroundColor: UIColor = UIColor(named: "BackGround") ?? .black
    public var foregroundColor: UIColor = UIColor(named: "ForeGround") ?? .white
    
    //MARK: Images
    public func recipeImage(withNumber number: Int) -> UIImage {
        UIImage(named: "recipe\(number)") ?? UIImage()
    }
}
