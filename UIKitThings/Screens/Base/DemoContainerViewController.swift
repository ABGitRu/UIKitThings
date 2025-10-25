//
//  DemoContainerViewController.swift
//  UIKitThings
//
//  Created by Mac on 25.10.2025.
//

import UIKit

class DemoContainerViewController: UIViewController {
	
	// MARK: - Properties
	private(set) var graphPaperView: GraphPaperView!
	private(set) var contentView: UIView!
	
	var graphConfiguration: GraphPaperView.Configuration {
		get { graphPaperView.configuration }
		set { graphPaperView.configuration = newValue }
	}
	
	// MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		setupGraphPaperBackground()
		setupContent()
	}
	
	// MARK: - Setup
	private func setupGraphPaperBackground() {
		graphPaperView = GraphPaperView(frame: view.bounds)
		graphPaperView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		view.addSubview(graphPaperView)
	}
	
	private func setupContent() {
		view.backgroundColor = UIColor.lightBLue
		contentView = UIView(frame: view.bounds)
		contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		contentView.backgroundColor = .clear
		view.addSubview(contentView)
	}
	
	// MARK: - Helpers
	func addHighlightedView(
		_ view: UIView,
		withBorder: Bool = true,
		showInfo: Bool = true,
		infoText: String? = nil
	) {
		contentView.addSubview(view)
		
		if withBorder {
			highlightView(view)
		}
		
		if showInfo {
			addInfoLabel(for: view, text: infoText)
		}
	}

	func highlightView(_ view: UIView, color: UIColor = .systemPink) {
		view.layer.borderWidth = 2
		view.layer.borderColor = color.cgColor
	}

	@discardableResult
	func addInfoLabel(for view: UIView, text: String? = nil, position: InfoLabelPosition = .automatic) -> UILabel {
		let label = UILabel()
		label.numberOfLines = 0
		label.font = .monospacedSystemFont(ofSize: 11, weight: .medium)
		label.textColor = .label
		label.backgroundColor = UIColor.systemBackground.withAlphaComponent(0.95)
		label.layer.cornerRadius = 8
		label.layer.borderWidth = 1.5
		label.layer.borderColor = UIColor.systemPink.cgColor
		label.clipsToBounds = true
		label.textAlignment = .left
		
		let info = text ?? generateInfoText(for: view)
		label.text = "  \(info)  "
		label.sizeToFit()

		label.frame.size.width += 16
		label.frame.size.height += 12

		positionInfoLabel(label, relativeTo: view, position: position)
		
		contentView.addSubview(label)
		return label
	}
	
	enum InfoLabelPosition {
		case automatic
		case top
		case bottom
		case left
		case right
		case topLeft
		case topRight
		case bottomLeft
		case bottomRight
	}
	
	private func positionInfoLabel(_ label: UILabel, relativeTo view: UIView, position: InfoLabelPosition) {
		let offset: CGFloat = 8
		let viewFrameInContent = contentView.convert(view.frame, from: view.superview)
		
		let actualPosition: InfoLabelPosition
		if position == .automatic {

			if viewFrameInContent.maxY + label.frame.height + offset < contentView.bounds.height {
				actualPosition = .bottom
			} else if viewFrameInContent.minY - label.frame.height - offset > 0 {
				actualPosition = .top
			} else if viewFrameInContent.maxX + label.frame.width + offset < contentView.bounds.width {
				actualPosition = .right
			} else {
				actualPosition = .topRight
			}
		} else {
			actualPosition = position
		}
		
		switch actualPosition {
		case .automatic:
			break
		case .top:
			label.frame.origin = CGPoint(
				x: viewFrameInContent.midX - label.frame.width / 2,
				y: viewFrameInContent.minY - label.frame.height - offset
			)
		case .bottom:
			label.frame.origin = CGPoint(
				x: viewFrameInContent.midX - label.frame.width / 2,
				y: viewFrameInContent.maxY + offset
			)
		case .left:
			label.frame.origin = CGPoint(
				x: viewFrameInContent.minX - label.frame.width - offset,
				y: viewFrameInContent.midY - label.frame.height / 2
			)
		case .right:
			label.frame.origin = CGPoint(
				x: viewFrameInContent.maxX + offset,
				y: viewFrameInContent.midY - label.frame.height / 2
			)
		case .topLeft:
			label.frame.origin = CGPoint(
				x: viewFrameInContent.minX - label.frame.width - offset,
				y: viewFrameInContent.minY - label.frame.height - offset
			)
		case .topRight:
			label.frame.origin = CGPoint(
				x: viewFrameInContent.maxX + offset,
				y: viewFrameInContent.minY - label.frame.height - offset
			)
		case .bottomLeft:
			label.frame.origin = CGPoint(
				x: viewFrameInContent.minX - label.frame.width - offset,
				y: viewFrameInContent.maxY + offset
			)
		case .bottomRight:
			label.frame.origin = CGPoint(
				x: viewFrameInContent.maxX + offset,
				y: viewFrameInContent.maxY + offset
			)
		}
	}
	
	private func generateInfoText(for view: UIView) -> String {
		return """
		frame: \(formatRect(view.frame))
		bounds: \(formatRect(view.bounds))
		center: \(formatPoint(view.center))
		"""
	}
	
	private func formatRect(_ rect: CGRect) -> String {
		return "(\(Int(rect.origin.x)), \(Int(rect.origin.y)), \(Int(rect.width))×\(Int(rect.height)))"
	}
	
	private func formatPoint(_ point: CGPoint) -> String {
		return "(\(Int(point.x)), \(Int(point.y)))"
	}
}
