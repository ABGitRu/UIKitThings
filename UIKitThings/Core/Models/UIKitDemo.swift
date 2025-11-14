//
//  UIKitDemo.swift
//  UIKitThings
//
//  Created by Mac on 25.10.2025.
//

import UIKit

struct UIKitDemo {
	let title: String
	let description: String
	let viewController: UIViewController
	let category: Category
	
	enum Category: String {
		case views = "Views"
		case layout = "Layout"
		case animation = "Animation"
		case interactions = "Interactions"
		case advanced = "Advanced"
		
		var color: UIColor {
			switch self {
			case .views: return UIColor.systemBlue
			case .layout: return UIColor.systemGreen
			case .animation: return UIColor.systemOrange
			case .interactions: return UIColor.systemPurple
			case .advanced: return UIColor.systemRed
			}
		}
	}
}

// MARK: - Demo Registry
extension UIKitDemo {
	static var allDemos: [UIKitDemo] {
		return [
			 UIKitDemo(
			     title: "Negative Subview Size",
			     description: "What happens when subview has negative dimensions",
			     viewController: NegativeSizeViewController(),
			     category: .views
			 ),
			 UIKitDemo(
				title: "Bounds Origin Effect",
				description: "How does changing bounds.origin affect subviews?",
				viewController: BoundsOriginViewController(),
				category: .views
			 ),
			 UIKitDemo(
				title: "Frame vs Auto Layout",
				description: "What will happen if we manually change the frame of a view that already works with Auto Layout?",
				viewController: FrameAndAutoLayoutViewController(),
				category: .layout
			 ),
			 UIKitDemo(
				title: "Button with a hole",
				description: "How to make button that contains hole that is not interactable?",
				viewController: CircleHoleButtonController(),
				category: .interactions
			 ),
			 UIKitDemo(
				title: "Expanding Textfield",
				description: "How to Create an Expanding Text Field in UIKit",
				viewController: ExpandingTextFieldViewController(),
				category: .interactions
			 ),
			 UIKitDemo(
				title: "Overlapping Shadow",
				description: "How to Create an overlapping shadow",
				viewController: OverlappingShadowViewController(),
				category: .advanced
			 )
		]
	}
}
