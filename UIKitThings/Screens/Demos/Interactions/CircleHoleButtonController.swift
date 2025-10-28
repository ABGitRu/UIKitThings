//
//  CircleHoleButtonController.swift
//  UIKitThings
//
//  Created by Mac on 28.10.2025.
//

import UIKit

final class CircleHoleButtonController: DemoContainerViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .systemBackground

		let button = CircleHoleButton(type: .system)
		button.frame = CGRect(x: 100, y: 200, width: 200, height: 200)
		button.backgroundColor = .systemBlue
		button.setTitleColor(.white, for: .normal)
		button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)

		view.addSubview(button)
		addCustomizableHighlightedView(
			frame: CGRect(x: 50, y: 450, width: 320, height: 300),
			infoText:
	"""
	📌 Result:
	Button displays a transparent circular area (hole) in the center.
	Touches inside this hole are ignored — only taps outside the circle trigger the button.
	
	How it works:
	Uses a CAShapeLayer mask to visually cut out the circle from the button
	Overrides point(inside:with:) so tap inside the circle does not trigger actions
	You see and interact with anything behind the hole!
	"""
		)
	}

	@objc private func buttonTapped() {
		let alert = UIAlertController(title: "Tapped!", message: "Taped outside the hole", preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "OK", style: .default))
		present(alert, animated: true)
	}
}
