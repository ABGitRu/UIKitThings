//
//  SceneDelegate.swift
//  UIKitThings
//
//  Created by Mac on 25.10.2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
	var window: UIWindow?
	var coordinator: AppCoordinator?
	
	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		guard let scene = (scene as? UIWindowScene) else { return }
		
		let navigationController = UINavigationController()
		navigationController.navigationBar.prefersLargeTitles = true
		
		coordinator = AppCoordinator(navigationController: navigationController)
		coordinator?.start()
		
		window = UIWindow(windowScene: scene)
		window?.rootViewController = navigationController
		window?.makeKeyAndVisible()
	}
}
