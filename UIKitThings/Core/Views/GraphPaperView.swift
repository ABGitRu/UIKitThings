//
//  GraphPaperView.swift
//  UIKitThings
//
//  Created by Mac on 25.10.2025.
//

import UIKit

final class GraphPaperView: UIView {

	// MARK: - Configuration
	struct Configuration {
		var majorGridSpacing: CGFloat = 50
		var minorGridSpacing: CGFloat = 10
		var majorGridColor: UIColor = UIColor.systemBlue.withAlphaComponent(0.3)
		var minorGridColor: UIColor = UIColor.systemBlue.withAlphaComponent(0.1)
		var axisColor: UIColor = UIColor.systemRed.withAlphaComponent(0.5)
		var labelColor: UIColor = .label
		var labelFont: UIFont = .monospacedSystemFont(ofSize: 10, weight: .regular)
		var showLabels: Bool = true
		var showOrigin: Bool = true
		var originPoint: CGPoint = .zero
	}

	var configuration = Configuration() {
		didSet {
			setNeedsDisplay()
		}
	}

	// MARK: - Initialization
	override init(frame: CGRect) {
		super.init(frame: frame)
		setup()
	}

	required init?(coder: NSCoder) {
		super.init(coder: coder)
		setup()
	}

	private func setup() {
		backgroundColor = .clear
		isOpaque = false
	}
	
	// MARK: - Drawing
	override func draw(_ rect: CGRect) {
		super.draw(rect)

		guard let context = UIGraphicsGetCurrentContext() else { return }

		let config = configuration

		drawGrid(
			in: context,
			rect: rect,
			spacing: config.minorGridSpacing,
			color: config.minorGridColor,
			lineWidth: 0.5
		)

		drawGrid(
			in: context,
			rect: rect,
			spacing: config.majorGridSpacing,
			color: config.majorGridColor,
			lineWidth: 1.0
		)

		if config.showOrigin {
			drawAxes(in: context, rect: rect)
		}

		if config.showLabels {
			drawLabels(rect: rect)
		}
	}
	
	private func drawGrid(
		in context: CGContext,
		rect: CGRect,
		spacing: CGFloat,
		color: UIColor,
		lineWidth: CGFloat
	) {
		context.saveGState()
		context.setStrokeColor(color.cgColor)
		context.setLineWidth(lineWidth)
		
		let origin = configuration.originPoint

		var x = origin.x
		while x <= rect.maxX {
			context.move(to: CGPoint(x: x, y: rect.minY))
			context.addLine(to: CGPoint(x: x, y: rect.maxY))
			x += spacing
		}

		x = origin.x - spacing
		while x >= rect.minX {
			context.move(to: CGPoint(x: x, y: rect.minY))
			context.addLine(to: CGPoint(x: x, y: rect.maxY))
			x -= spacing
		}

		var y = origin.y
		while y <= rect.maxY {
			context.move(to: CGPoint(x: rect.minX, y: y))
			context.addLine(to: CGPoint(x: rect.maxX, y: y))
			y += spacing
		}

		y = origin.y - spacing
		while y >= rect.minY {
			context.move(to: CGPoint(x: rect.minX, y: y))
			context.addLine(to: CGPoint(x: rect.maxX, y: y))
			y -= spacing
		}

		context.strokePath()
		context.restoreGState()
	}

	private func drawAxes(in context: CGContext, rect: CGRect) {
		context.saveGState()
		context.setStrokeColor(configuration.axisColor.cgColor)
		context.setLineWidth(2.0)

		let origin = configuration.originPoint

		context.move(to: CGPoint(x: rect.minX, y: origin.y))
		context.addLine(to: CGPoint(x: rect.maxX, y: origin.y))

		context.move(to: CGPoint(x: origin.x, y: rect.minY))
		context.addLine(to: CGPoint(x: origin.x, y: rect.maxY))
		
		context.strokePath()
		context.restoreGState()
	}
	
	private func drawLabels(rect: CGRect) {
		let config = configuration
		let origin = config.originPoint
		let spacing = config.majorGridSpacing
		
		let paragraphStyle = NSMutableParagraphStyle()
		paragraphStyle.alignment = .center
		
		let attributes: [NSAttributedString.Key: Any] = [
			.font: config.labelFont,
			.foregroundColor: config.labelColor,
			.paragraphStyle: paragraphStyle
		]

		var x = origin.x
		var labelValue = 0
		while x <= rect.maxX {
			if x != origin.x {
				let label = "\(labelValue)" as NSString
				let labelSize = label.size(withAttributes: attributes)
				let labelRect = CGRect(
					x: x - labelSize.width / 2,
					y: origin.y + 4,
					width: labelSize.width,
					height: labelSize.height
				)
				label.draw(in: labelRect, withAttributes: attributes)
			}
			x += spacing
			labelValue += Int(spacing)
		}

		x = origin.x - spacing
		labelValue = -Int(spacing)
		while x >= rect.minX {
			let label = "\(labelValue)" as NSString
			let labelSize = label.size(withAttributes: attributes)
			let labelRect = CGRect(
				x: x - labelSize.width / 2,
				y: origin.y + 4,
				width: labelSize.width,
				height: labelSize.height
			)
			label.draw(in: labelRect, withAttributes: attributes)
			x -= spacing
			labelValue -= Int(spacing)
		}

		var y = origin.y
		labelValue = 0
		while y <= rect.maxY {
			if y != origin.y {
				let label = "\(labelValue)" as NSString
				let labelSize = label.size(withAttributes: attributes)
				let labelRect = CGRect(
					x: origin.x + 4,
					y: y - labelSize.height / 2,
					width: labelSize.width,
					height: labelSize.height
				)
				label.draw(in: labelRect, withAttributes: attributes)
			}
			y += spacing
			labelValue += Int(spacing)
		}

		y = origin.y - spacing
		labelValue = -Int(spacing)
		while y >= rect.minY {
			let label = "\(labelValue)" as NSString
			let labelSize = label.size(withAttributes: attributes)
			let labelRect = CGRect(
				x: origin.x + 4,
				y: y - labelSize.height / 2,
				width: labelSize.width,
				height: labelSize.height
			)
			label.draw(in: labelRect, withAttributes: attributes)
			y -= spacing
			labelValue -= Int(spacing)
		}

		let originLabel = "0" as NSString
		let labelSize = originLabel.size(withAttributes: attributes)
		let labelRect = CGRect(
			x: origin.x + 4,
			y: origin.y + 4,
			width: labelSize.width,
			height: labelSize.height
		)
		originLabel.draw(in: labelRect, withAttributes: attributes)
	}
}

// MARK: - Convenience Extensions
extension GraphPaperView {
	func addInfoLabel(for view: UIView, text: String? = nil) -> UILabel {
		let label = UILabel()
		label.numberOfLines = 0
		label.font = .monospacedSystemFont(ofSize: 11, weight: .medium)
		label.textColor = .label
		label.backgroundColor = UIColor.systemBackground.withAlphaComponent(0.9)
		label.layer.cornerRadius = 6
		label.layer.borderWidth = 1
		label.layer.borderColor = UIColor.separator.cgColor
		label.clipsToBounds = true
		label.textAlignment = .left
		
		let padding: CGFloat = 8
		label.translatesAutoresizingMaskIntoConstraints = false
		
		let info = text ?? """
		Frame: \(formatRect(view.frame))
		Bounds: \(formatRect(view.bounds))
		Center: \(formatPoint(view.center))
		"""
		
		label.text = info

		label.drawText(in: CGRect(
			x: padding,
			y: padding,
			width: label.bounds.width - padding * 2,
			height: label.bounds.height - padding * 2
		))
		
		addSubview(label)
		return label
	}
	
	private func formatRect(_ rect: CGRect) -> String {
		return "(\(Int(rect.origin.x)), \(Int(rect.origin.y)), \(Int(rect.width)), \(Int(rect.height)))"
	}
	
	private func formatPoint(_ point: CGPoint) -> String {
		return "(\(Int(point.x)), \(Int(point.y)))"
	}
}
