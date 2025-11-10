//
//  ExpandingTextFieldViewController.swift
//  UIKitThings
//
//  Created by Mac on 28.10.2025.
//

import UIKit

final class ExpandingTextFieldViewController: DemoContainerViewController {

	// MARK: - UI Components

	/// The expanding text view
	private let expandingTextView: UITextView = {
		let textView = UITextView()
		textView.translatesAutoresizingMaskIntoConstraints = false
		textView.font = .systemFont(ofSize: 16)
		textView.textColor = .label
		textView.backgroundColor = .systemBackground
		textView.layer.cornerRadius = 12
		textView.layer.borderWidth = 2
		textView.layer.borderColor = UIColor.systemBlue.cgColor
		textView.textContainerInset = UIEdgeInsets(top: 12, left: 8, bottom: 12, right: 8)
		textView.isScrollEnabled = false // Key property for auto-resizing
		return textView
	}()

	/// Label showing the current height info
	private let infoLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = .monospacedSystemFont(ofSize: 14, weight: .regular)
		label.textColor = .secondaryLabel
		label.numberOfLines = 0
		label.textAlignment = .center
		return label
	}()

	/// Label with demo description
	private let descriptionLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = .systemFont(ofSize: 14, weight: .medium)
		label.textColor = .label
		label.numberOfLines = 0
		label.textAlignment = .left
		label.text = """
		📝 Expanding Text Field Demo

		This text field automatically increases its size as you type.
		It uses UITextView with isScrollEnabled = false and dynamic constraints.

		Try typing several lines of text!
		"""
		return label
	}()

	/// Height constraint for textView (updated dynamically)
	private var textViewHeightConstraint: NSLayoutConstraint!

	// MARK: - Lifecycle

	override func viewDidLoad() {
		super.viewDidLoad()
		title = .empty
		setupUI()
		updateInfoLabel()
	}

	// MARK: - Setup

	/// UI and constraints setup
	private func setupUI() {
		expandingTextView.delegate = self

		contentView.addSubview(descriptionLabel)
		contentView.addSubview(expandingTextView)
		contentView.addSubview(infoLabel)

		// Initial height (minimum for one line)
		textViewHeightConstraint = expandingTextView.heightAnchor.constraint(greaterThanOrEqualToConstant: 44)

		NSLayoutConstraint.activate([
			// Description Label
			descriptionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 120),
			descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
			descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),

			// Expanding TextView
			expandingTextView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 24),
			expandingTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
			expandingTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
			textViewHeightConstraint,

			// Info Label
			infoLabel.topAnchor.constraint(equalTo: expandingTextView.bottomAnchor, constant: 16),
			infoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
			infoLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
		])

		addTechnicalNote()
	}

	/// Adds a technical note at the bottom of the screen
	private func addTechnicalNote() {
		let noteLabel = UILabel()
		noteLabel.translatesAutoresizingMaskIntoConstraints = false
		noteLabel.numberOfLines = 0
		noteLabel.font = .systemFont(ofSize: 13, weight: .regular)
		noteLabel.textColor = .secondaryLabel
		noteLabel.backgroundColor = UIColor.systemGray6.withAlphaComponent(0.5)
		noteLabel.layer.cornerRadius = 8
		noteLabel.clipsToBounds = true
		noteLabel.textAlignment = .left

		let paragraphStyle = NSMutableParagraphStyle()
		paragraphStyle.lineSpacing = 4
		paragraphStyle.paragraphSpacing = 8
		paragraphStyle.firstLineHeadIndent = 12
		paragraphStyle.headIndent = 12
		paragraphStyle.tailIndent = -12

		let attributedText = NSMutableAttributedString(string: """
		💡 Technical details:

		• isScrollEnabled = false — disables scrolling so UITextView expands
		• contentSize changes automatically as you type
		• UITextViewDelegate.textViewDidChange is called on each modification
		• Animated height changes with UIView.animate
		• heightConstraint is updated based on contentSize.height
		""")

		attributedText.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedText.length))
		noteLabel.attributedText = attributedText

		contentView.addSubview(noteLabel)

		NSLayoutConstraint.activate([
			noteLabel.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 24),
			noteLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
			noteLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
			noteLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -20)
		])
	}

	// MARK: - Helper Methods

	/// Updates info label with current parameters
	private func updateInfoLabel() {
		let contentHeight = expandingTextView.contentSize.height
		let frameHeight = expandingTextView.frame.height
		let lineCount = (expandingTextView.text as NSString).components(separatedBy: "\n").count

		infoLabel.text = """
		contentSize.height: \(Int(contentHeight))pt
		frame.height: \(Int(frameHeight))pt
		lines: \(lineCount)
		"""
	}
}

// MARK: - UITextViewDelegate

extension ExpandingTextFieldViewController: UITextViewDelegate {

	/// Called on each text change
	/// Here we update the textView's height according to contentSize
	func textViewDidChange(_ textView: UITextView) {
		// Animate constraint update
		UIView.animate(withDuration: 0.2, animations: {
			self.view.layoutIfNeeded()
		})

		// Update info label
		updateInfoLabel()
	}

	/// Called when editing begins
	func textViewDidBeginEditing(_ textView: UITextView) {
		UIView.animate(withDuration: 0.3) {
			textView.layer.borderColor = UIColor.systemGreen.cgColor
		}
	}

	/// Called when editing ends
	func textViewDidEndEditing(_ textView: UITextView) {
		UIView.animate(withDuration: 0.3) {
			textView.layer.borderColor = UIColor.systemBlue.cgColor
		}
	}
}
