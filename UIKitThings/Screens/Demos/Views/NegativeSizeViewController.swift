//
//  NegativeSizeViewController.swift
//  UIKitThings
//
//  Created by Mac on 25.10.2025.
//

import UIKit

final class NegativeSizeViewController: DemoContainerViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		title = "Negative Subview Size"
		testNegativeSize()
	}
	
	private func testNegativeSize() {
		let normalView = UIView(
			frame: CGRect(
				x: 200,
				y: 250,
				width: 50,
				height: 50
			)
		)
		normalView.backgroundColor = .systemGreen.withAlphaComponent(0.5)
		addHighlightedView(
			normalView,
			withBorder: true,
			showInfo: true,
			infoText: """
  Normal view
  frame: \(formatRect(normalView.frame))
  bounds: \(formatRect(normalView.bounds))
  """
		)
	
		let negativeView = UIView(
			frame: CGRect(
				x: 200,
				y: 250,
				width: -50,
				height: -50
			)
		)
		negativeView.backgroundColor = .systemRed.withAlphaComponent(0.5)
		addHighlightedView(
			negativeView,
			withBorder: true,
			showInfo: true,
			infoText: """
 Negative width and height
 frame: \(formatRect(negativeView.frame))
 bounds: \(formatRect(negativeView.bounds))
 """
		)
		addSummaryLabel()
	}
	
	private func addSummaryLabel() {
		let summaryLabel = PaddedLabel()
		summaryLabel.numberOfLines = 0
		summaryLabel.font = .systemFont(ofSize: 14, weight: .medium)
		summaryLabel.textColor = .label
		summaryLabel.backgroundColor = UIColor.systemBackground.withAlphaComponent(0.95)
		summaryLabel.layer.cornerRadius = 12
		summaryLabel.layer.borderWidth = 2
		summaryLabel.layer.borderColor = UIColor.systemBlue.cgColor
		summaryLabel.clipsToBounds = true
		summaryLabel.textAlignment = .left
		
		summaryLabel.text = """
		  📌 Result:
		Negative width/height causes bounds.origin to shift by the negative offset.

		bounds.size becomes positive, and the actual rectangular area is not negative in size.

		The view appears in the calculated location as if defined with positive size, just with a shifted origin.
		"""
		
		summaryLabel.frame = CGRect(x: 20, y: 400, width: contentView.bounds.width - 40, height: 300)
		summaryLabel.autoresizingMask = [.flexibleWidth]
		
		contentView.addSubview(summaryLabel)
	}
	
	private func formatRect(_ rect: CGRect) -> String {
		return "(\(Int(rect.origin.x)), \(Int(rect.origin.y)), \(Int(rect.width))×\(Int(rect.height)))"
	}
}
