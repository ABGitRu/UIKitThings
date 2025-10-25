//
//  BoundsOriginViewController.swift
//  UIKitThings
//
//  Created by Mac on 25.10.2025.
//

import UIKit

final class BoundsOriginViewController: DemoContainerViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		title = ""
		testBoundsOrigin()
	}
	
	private func testBoundsOrigin() {
		addNormalView()
		addOffsetViews()
		addSummaryLabel()
	}

	private func addNormalView() {
		// Parent view with normal bounds.origin
		let normalParentView = UIView(
			frame: CGRect(
				x: 75,
				y: 100,
				width: 150,
				height: 150
			)
		)
		normalParentView.backgroundColor = .systemBlue.withAlphaComponent(0.3)
		
		// Subview inside normal parent
		let normalSubview = UIView(
			frame: CGRect(
				x: 25,
				y: 25,
				width: 100,
				height: 100
			)
		)
		normalSubview.backgroundColor = .systemGreen.withAlphaComponent(0.7)
		normalParentView.addSubview(normalSubview)
		
		addHighlightedView(
			normalParentView,
			withBorder: true,
			showInfo: true,
			infoText: """
			Normal parent
			bounds: \(formatRect(normalParentView.bounds))
			subview.frame: \(formatRect(normalSubview.frame))
			"""
		)
	}

	private func addOffsetViews() {
		// Parent view with changed bounds.origin (we will change it on line 77)
		let offsetParentView = UIView(
			frame: CGRect(
				x: 75,
				y: 325,
				width: 150,
				height: 150
			)
		)
		offsetParentView.backgroundColor = .systemBlue.withAlphaComponent(0.3)
		
		// Subview with the same frame
		let offsetSubview = UIView(
			frame: CGRect(
				x: 25,
				y: 25,
				width: 100,
				height: 100
			)
		)
		offsetSubview.backgroundColor = .systemRed.withAlphaComponent(0.7)
		offsetParentView.addSubview(offsetSubview)
		
		// Changing bounds.origin of parent
		offsetParentView.bounds.origin = CGPoint(x: 30, y: 30)
		
		addHighlightedView(
			offsetParentView,
			withBorder: true,
			showInfo: true,
			infoText: """
			Offset parent
			bounds: \(formatRect(offsetParentView.bounds))
			subview.frame: \(formatRect(offsetSubview.frame))
			Visual shift: (-30, -30)
			"""
		)
	}
	
	private func addSummaryLabel() {
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
		summaryLabel.text = """
		📌 Result:
		Changing bounds.origin offsets all subviews in the OPPOSITE direction.
		
		• Green subview: normal position (25, 25)
		• Red subview: same frame (25, 25), but visually shifted
		• Formula: VisualPosition = frame.origin - superview.bounds.origin
		• Red appears at: (25-30, 25-30) = (-5, -5) relative to parent
		
		This is how UIScrollView works! contentOffset = bounds.origin
		"""
		
		summaryLabel.frame = CGRect(x: 20, y: 550, width: contentView.bounds.width - 40, height: 300)
		summaryLabel.autoresizingMask = [.flexibleWidth]
		contentView.addSubview(summaryLabel)
	}
	
	private func formatRect(_ rect: CGRect) -> String {
		return "(\(Int(rect.origin.x)), \(Int(rect.origin.y)), \(Int(rect.width))×\(Int(rect.height)))"
	}
}
