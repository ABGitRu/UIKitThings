//
//  HighlightedView.swift
//  UIKitThings
//
//  Created by Mac on 28.10.2025.
//

import UIKit

final class HighlightedView: UIView {
	private let infoLabel = UILabel()

	init(
		frame: CGRect,
		borderColor: UIColor = .systemYellow,
		borderWidth: CGFloat = 3,
		cornerRadius: CGFloat = 12,
		infoText: String? = nil,
		infoFont: UIFont = .systemFont(ofSize: 15, weight: .medium),
		infoTextColor: UIColor = .label,
		infoBgColor: UIColor = .secondarySystemBackground.withAlphaComponent(0.95)
	) {
		super.init(frame: frame)
		backgroundColor = .clear
		layer.borderColor = borderColor.cgColor
		layer.borderWidth = borderWidth
		layer.cornerRadius = cornerRadius
		clipsToBounds = true

		if let infoText = infoText {
			infoLabel.numberOfLines = 0
			infoLabel.font = infoFont
			infoLabel.textColor = infoTextColor
			infoLabel.backgroundColor = infoBgColor
			infoLabel.text = infoText
			infoLabel.translatesAutoresizingMaskIntoConstraints = false
			addSubview(infoLabel)

			NSLayoutConstraint.activate([
				infoLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
				infoLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
				infoLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
				infoLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8)
			])
		}
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

