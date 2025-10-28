//
//  CircleHoleButton.swift
//  UIKitThings
//
//  Created by Mac on 28.10.2025.
//

import UIKit

final class CircleHoleButton: UIButton {

	/// Radius of the transparent circle (hole)
	var holeRadius: CGFloat = 75 // Increase the value to expand the hole

	override func layoutSubviews() {
		super.layoutSubviews()
		applyHoleMask()
	}
	
	/// Applies a mask with a circle cut out from the button's center (this is only visuals, main magic is in point(inside) method)
	private func applyHoleMask() {
		// Full button rectangle
		let buttonPath = UIBezierPath(rect: bounds)

		// Circular hole in the center
		let circleCenter = CGPoint(x: bounds.midX, y: bounds.midY)
		let circlePath = UIBezierPath(ovalIn: CGRect(
			x: circleCenter.x - holeRadius,
			y: circleCenter.y - holeRadius,
			width: holeRadius * 2,
			height: holeRadius * 2
		))
		// Subtract the circle from the button's shape (even-odd fill rule)
		buttonPath.append(circlePath)
		buttonPath.usesEvenOddFillRule = true

		// Create shape layer with mask
		let maskLayer = CAShapeLayer()
		maskLayer.path = buttonPath.cgPath
		maskLayer.fillRule = .evenOdd

		layer.mask = maskLayer
	}

	/// Touches inside the central circle are ignored, everywhere else triggers the button
	override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
		let circleCenter = CGPoint(x: bounds.midX, y: bounds.midY)
		let distance = hypot(point.x - circleCenter.x, point.y - circleCenter.y)
		// Return false if touch is inside the hole, true elsewhere
		return distance > holeRadius && super.point(inside: point, with: event)
	}
}
