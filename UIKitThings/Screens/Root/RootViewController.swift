//
//  RootViewController.swift
//  UIKitThings
//
//  Created by Mac on 25.10.2025.
//

import UIKit

final class RootViewController: UIViewController {
	weak var coordinator: AppCoordinator?
	
	private let demos = UIKitDemo.allDemos
	
	private lazy var tableView: UITableView = {
		let table = UITableView(frame: .zero, style: .insetGrouped)
		table.backgroundColor = .systemGroupedBackground
		table.delegate = self
		table.dataSource = self
		table.register(DemoTableViewCell.self, forCellReuseIdentifier: DemoTableViewCell.identifier)
		table.separatorStyle = .none
		table.rowHeight = UITableView.automaticDimension
		table.estimatedRowHeight = 120
		table.translatesAutoresizingMaskIntoConstraints = false
		return table
	}()
	
	private let emptyStateView: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		
		let stackView = UIStackView()
		stackView.axis = .vertical
		stackView.alignment = .center
		stackView.spacing = 12
		stackView.translatesAutoresizingMaskIntoConstraints = false
		
		let imageView = UIImageView(image: UIImage(systemName: "doc.text.magnifyingglass"))
		imageView.tintColor = .secondaryLabel
		imageView.contentMode = .scaleAspectFit
		imageView.translatesAutoresizingMaskIntoConstraints = false
		
		let label = UILabel()
		label.text = "No demos yet"
		label.font = .systemFont(ofSize: 17, weight: .medium)
		label.textColor = .secondaryLabel
		label.textAlignment = .center
		
		let descriptionLabel = UILabel()
		descriptionLabel.text = "Add your demo in UIKitDemo.swift"
		descriptionLabel.font = .systemFont(ofSize: 14, weight: .regular)
		descriptionLabel.textColor = .tertiaryLabel
		descriptionLabel.textAlignment = .center
		descriptionLabel.numberOfLines = 0
		
		stackView.addArrangedSubview(imageView)
		stackView.addArrangedSubview(label)
		stackView.addArrangedSubview(descriptionLabel)
		
		view.addSubview(stackView)
		
		NSLayoutConstraint.activate([
			imageView.widthAnchor.constraint(equalToConstant: 64),
			imageView.heightAnchor.constraint(equalToConstant: 64),
			
			stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
			stackView.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 32),
			stackView.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -32)
		])
		
		return view
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
	}
	
	private func setupUI() {
		title = "UIKit Demos"
		view.backgroundColor = .systemGroupedBackground
		
		navigationController?.navigationBar.prefersLargeTitles = true
		
		view.addSubview(tableView)
		view.addSubview(emptyStateView)
		
		NSLayoutConstraint.activate([
			tableView.topAnchor.constraint(equalTo: view.topAnchor),
			tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			
			emptyStateView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			emptyStateView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			emptyStateView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			emptyStateView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])
		
		updateEmptyState()
	}
	
	private func updateEmptyState() {
		emptyStateView.isHidden = !demos.isEmpty
		tableView.isHidden = demos.isEmpty
	}
}

// MARK: - UITableViewDataSource
extension RootViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return demos.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(
			withIdentifier: DemoTableViewCell.identifier,
			for: indexPath
		) as? DemoTableViewCell else {
			return UITableViewCell()
		}
		
		cell.configure(with: demos[indexPath.row])
		return cell
	}
}

// MARK: - UITableViewDelegate
extension RootViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let demo = demos[indexPath.row]
		coordinator?.showDemo(demo)
	}
}
