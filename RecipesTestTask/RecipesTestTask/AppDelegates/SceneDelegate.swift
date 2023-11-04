//
//  SceneDelegate.swift
//  RecipesTestTask
//
//  Created by Vitaliy Halai on 4.11.23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: scene)
        let navigationController = UINavigationController(rootViewController: MainPageController())
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
    }
    


}

