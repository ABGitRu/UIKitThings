//
//  Coordinator.swift
//  UIKitThings
//
//  Created by Mac on 25.10.2025.
//

import UIKit

protocol Coordinator: AnyObject {
	var navigationController: UINavigationController { get set }
	func start()
}

final class AppCoordinator: Coordinator {
	var navigationController: UINavigationController
	
	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}
	
	func start() {
		let rootVC = RootViewController()
		rootVC.coordinator = self
		navigationController.pushViewController(rootVC, animated: false)
	}
	
	func showDemo(_ demo: UIKitDemo) {
		let demoVC = demo.viewController
		demoVC.title = demo.title
		navigationController.pushViewController(demoVC, animated: true)
	}
}
