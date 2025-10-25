//
//  DemoTableViewCell.swift
//  UIKitThings
//
//  Created by Mac on 25.10.2025.
//

import UIKit

final class DemoTableViewCell: UITableViewCell {
	static let identifier = "DemoTableViewCell"
	
	private let containerView: UIView = {
		let view = UIView()
		view.backgroundColor = .secondarySystemGroupedBackground
		view.layer.cornerRadius = 12
		view.layer.masksToBounds = true
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	private let categoryIndicator: UIView = {
		let view = UIView()
		view.layer.cornerRadius = 3
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	private let titleLabel: UILabel = {
		let label = UILabel()
		label.font = .systemFont(ofSize: 17, weight: .semibold)
		label.textColor = .label
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	private let descriptionLabel: UILabel = {
		let label = UILabel()
		label.font = .systemFont(ofSize: 14, weight: .regular)
		label.textColor = .secondaryLabel
		label.numberOfLines = 2
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	private let categoryLabel: UILabel = {
		let label = UILabel()
		label.font = .systemFont(ofSize: 12, weight: .medium)
		label.textColor = .secondaryLabel
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	private let chevronImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.image = UIImage(systemName: "chevron.right")
		imageView.tintColor = .tertiaryLabel
		imageView.contentMode = .scaleAspectFit
		imageView.translatesAutoresizingMaskIntoConstraints = false
		return imageView
	}()
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupUI()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setupUI() {
		backgroundColor = .clear
		selectionStyle = .none
		
		contentView.addSubview(containerView)
		containerView.addSubview(categoryIndicator)
		containerView.addSubview(titleLabel)
		containerView.addSubview(descriptionLabel)
		containerView.addSubview(categoryLabel)
		containerView.addSubview(chevronImageView)
		
		NSLayoutConstraint.activate([
			containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
			containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
			containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
			containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
			
			categoryIndicator.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
			categoryIndicator.topAnchor.constraint(equalTo: containerView.topAnchor),
			categoryIndicator.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
			categoryIndicator.widthAnchor.constraint(equalToConstant: 6),
			
			titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
			titleLabel.leadingAnchor.constraint(equalTo: categoryIndicator.trailingAnchor, constant: 12),
			titleLabel.trailingAnchor.constraint(equalTo: chevronImageView.leadingAnchor, constant: -8),
			
			descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
			descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
			descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
			
			categoryLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8),
			categoryLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
			categoryLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
			categoryLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12),
			
			chevronImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
			chevronImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
			chevronImageView.widthAnchor.constraint(equalToConstant: 14),
			chevronImageView.heightAnchor.constraint(equalToConstant: 14)
		])
	}
	
	func configure(with demo: UIKitDemo) {
		titleLabel.text = demo.title
		descriptionLabel.text = demo.description
		categoryLabel.text = demo.category.rawValue.uppercased()
		categoryIndicator.backgroundColor = demo.category.color
	}
	
	override func setHighlighted(_ highlighted: Bool, animated: Bool) {
		super.setHighlighted(highlighted, animated: animated)
		
		UIView.animate(withDuration: 0.2) {
			self.containerView.transform = highlighted ? CGAffineTransform(scaleX: 0.97, y: 0.97) : .identity
			self.containerView.alpha = highlighted ? 0.8 : 1.0
		}
	}
}
