//
//  OverlappingShadowViewController.swift
//  UIKitThings
//
//  Created by Mac on 10.11.2025.
//

import UIKit

final class OverlappingShadowViewController: DemoContainerViewController {
	
	private let topBar = UIView()
	private let bottomBar = UIView()
	private let containerView = UIView()
	private var unifiedShadowLayer: CAShapeLayer?
	
	// MARK: - Lifecycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		title = .empty
		
		// Switch between setups for demo
//		setupSeparateViews() // Shows both shadows separately
		 setupTShapeViews() // Shows T-shape with unified shadow
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		updateUnifiedShadow()
	}
	
	// MARK: - Separate Views Setup
	
	/// Setup 1: Views positioned separately to show both shadows clearly
	private func setupSeparateViews() {
		// Top horizontal bar (top part of T)
		topBar.frame = CGRect(x: 100, y: 100, width: 250, height: 40)
		topBar.backgroundColor = .systemGreen
		topBar.layer.cornerRadius = 12
		addStandardShadow(to: topBar)
		contentView.addSubview(topBar)
		
		// Bottom vertical bar (bottom part of T)
		bottomBar.frame = CGRect(x: 205, y: 120, width: 40, height: 260)
		bottomBar.backgroundColor = .systemGreen
		bottomBar.layer.cornerRadius = 12
		addStandardShadow(to: bottomBar)
		contentView.addSubview(bottomBar)
		
		addSummaryLabel(text: """
		📌 Separate Views (Standard Shadows):
		Both views have standard shadows applied via layer properties.
		
		• Top bar: shadow visible on all sides
		• Bottom bar: shadow visible on all sides
		• Shadows are independent and overlap each other
		• You can see shadow from top bar falling on bottom bar
		""")
	}
	
	// MARK: - T-Shape Setup
	
	/// Setup 2: Views arranged as T-shape with unified shadow outline
	private func setupTShapeViews() {
		// Container for both bars with unified shadow
		containerView.frame = CGRect(x: 100, y: 100, width: 250, height: 280)
		containerView.backgroundColor = .clear
		containerView.layer.masksToBounds = false
		contentView.addSubview(containerView)
		
		// Top horizontal bar (top part of T) - relative to container
		topBar.frame = CGRect(x: 0, y: 0, width: 250, height: 40)
		topBar.backgroundColor = .systemGreen
		topBar.layer.cornerRadius = 12
		containerView.addSubview(topBar)
		
		// Bottom vertical bar (bottom part of T) - relative to container
		bottomBar.frame = CGRect(x: 105, y: 20, width: 40, height: 260)
		bottomBar.backgroundColor = .systemGreen
		bottomBar.layer.cornerRadius = 12
		containerView.addSubview(bottomBar)
		
		addSummaryLabel(text: """
		📌 T-Shape with Unified Shadow:
		Both views are placed in a container with one shadow path for the entire T-shape.
		
		• Shadow follows the outer contour of the T
		• No shadows at intersection point
		• Renders as single unified object
		• Shadow path combines both shapes using UIBezierPath.append()
		
		How it works:
		1. Create container view for both bars
		2. Build combined path: top bar + bottom bar shapes
		3. Apply single shadow to container using combined path
		4. Result: shadow only on outer edges
		
		Use case: Material design elevation, unified card stacks, connected UI elements
		""")
	}
	
	// MARK: - Helpers
	
	private func addStandardShadow(to view: UIView) {
		view.layer.shadowColor = UIColor.black.cgColor
		view.layer.shadowOpacity = 0.8
		view.layer.shadowRadius = 12
		view.layer.shadowOffset = CGSize(width: 0, height: 6)
		view.layer.masksToBounds = false
	}
	
	private func updateUnifiedShadow() {
		// Only apply unified shadow if container exists
		guard containerView.superview != nil else { return }
		
		// Remove previous shadow layer if exists
		unifiedShadowLayer?.removeFromSuperlayer()
		
		let shadowLayer = CAShapeLayer()
		
		// Create combined path for T-shape
		let combinedPath = UIBezierPath()
		
		// Add top bar path
		let topBarPath = UIBezierPath(
			roundedRect: topBar.frame,
			cornerRadius: topBar.layer.cornerRadius
		)
		combinedPath.append(topBarPath)
		
		// Add bottom bar path
		let bottomBarPath = UIBezierPath(
			roundedRect: bottomBar.frame,
			cornerRadius: bottomBar.layer.cornerRadius
		)
		combinedPath.append(bottomBarPath)
		
		// Configure shadow layer with combined path
		shadowLayer.path = combinedPath.cgPath
		shadowLayer.fillColor = UIColor.clear.cgColor
		shadowLayer.shadowColor = UIColor.black.cgColor
		shadowLayer.shadowOpacity = 0.8
		shadowLayer.shadowRadius = 12
		shadowLayer.shadowOffset = CGSize(width: 0, height: 6)
		shadowLayer.shadowPath = combinedPath.cgPath
		
		// Insert shadow layer behind content
		containerView.layer.insertSublayer(shadowLayer, at: 0)
		unifiedShadowLayer = shadowLayer
	}
	
	private func addSummaryLabel(text: String) {
		let summaryLabel = PaddedLabel()
		summaryLabel.numberOfLines = 0
		summaryLabel.font = .systemFont(ofSize: 14, weight: .medium)
		summaryLabel.textColor = .label
		summaryLabel.backgroundColor = UIColor.systemBackground.withAlphaComponent(0.95)
		summaryLabel.layer.cornerRadius = 12
		summaryLabel.layer.borderWidth = 2
		summaryLabel.layer.borderColor = UIColor.systemOrange.cgColor
		summaryLabel.clipsToBounds = true
		summaryLabel.textAlignment = .left
		summaryLabel.text = text
		
		summaryLabel.frame = CGRect(x: 20, y: 400, width: contentView.bounds.width - 40, height: 450)
		summaryLabel.autoresizingMask = [.flexibleWidth]
		contentView.addSubview(summaryLabel)
	}
}
