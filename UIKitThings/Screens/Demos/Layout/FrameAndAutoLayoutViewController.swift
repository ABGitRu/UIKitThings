//
//  FrameAndAutoLayoutViewController.swift
//  UIKitThings
//
//  Created by Mac on 28.10.2025.
//

import UIKit

final class FrameAndAutoLayoutViewController: DemoContainerViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		title = .empty
		testFrameOnAutoLayout()
	}

	private func testFrameOnAutoLayout() {
		// Parent container with fixed size
		let parentView = UIView(frame: CGRect(x: 150, y: 100, width: 100, height: 100))
		contentView.addSubview(parentView)
		parentView.backgroundColor = UIColor.green.withAlphaComponent(0.3)
		
		// Subview pinned to parentView using Auto Layout constraints
		let autoLayoutSubview = UIView()
		autoLayoutSubview.backgroundColor = UIColor.red.withAlphaComponent(0.85)
		autoLayoutSubview.translatesAutoresizingMaskIntoConstraints = false
		parentView.addSubview(autoLayoutSubview)
		
		NSLayoutConstraint.activate([
			autoLayoutSubview.topAnchor.constraint(equalTo: parentView.bottomAnchor, constant: 20),
			autoLayoutSubview.leadingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: 20),
			autoLayoutSubview.widthAnchor.constraint(equalToConstant: 100),
			autoLayoutSubview.heightAnchor.constraint(equalToConstant: 100)
		])
		
		// Do initial layout, store frame after constraints
		parentView.layoutIfNeeded()
		let frameBefore = autoLayoutSubview.frame
		
		// Try to manually change the frame
		autoLayoutSubview.frame = CGRect(x: 50, y: 50, width: 80, height: 40)
		let frameAfter = autoLayoutSubview.frame
		
		// Trigger layout again
		parentView.layoutIfNeeded()
		let frameAfterLayout = autoLayoutSubview.frame

	let rect = CGRect(x: 50, y: 350, width: 320, height: 400)
		addCustomizableHighlightedView(
			frame: rect,
			infoText: 
	 """
	 📐 Subview with Auto Layout
	 
	 ▪ Before setting frame: \(formatRect(frameBefore))
	 ▪ After setting frame: \(formatRect(frameAfter))
	 ▪ After layoutIfNeeded(): \(formatRect(frameAfterLayout))
	 
	 Any attempt to set frame of a view, managed by Auto Layout constraints, will be overridden at the next layout pass — frame is always recalculated by Auto Layout. Even setting frame in viewDidLayoutSubviews will apply your value, but still will be lost as soon as any layout update occurs.
	 """
		)
	}

	private func formatRect(_ rect: CGRect) -> String {
		return "(\(Int(rect.origin.x)), \(Int(rect.origin.y)), \(Int(rect.width))×\(Int(rect.height)))"
	}
}

