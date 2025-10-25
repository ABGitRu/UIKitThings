//
//  PaddedLabel.swift
//  UIKitThings
//
//  Created by Mac on 25.10.2025.
//

import UIKit

class PaddedLabel: UILabel {
	var textInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
	
	override func drawText(in rect: CGRect) {
		super.drawText(in: rect.inset(by: textInsets))
	}
	
	override var intrinsicContentSize: CGSize {
		let size = super.intrinsicContentSize
		return CGSize(width: size.width + textInsets.left + textInsets.right,
					 height: size.height + textInsets.top + textInsets.bottom)
	}
}
