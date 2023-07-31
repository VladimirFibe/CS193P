//
//  OnboardingView.swift
//  OnboardingExample
//
//  Created by Vladimir Fibe on 31.07.2023.
//

import UIKit

final class OnboardingView: UIView {
    private let stackView = UIStackView()
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    func configure(with model: Onboarding) {
        titleLabel.text = model.title
        descriptionLabel.text = model.description
        imageView.image = UIImage.gifImageWithName("funny")
    }
}

extension OnboardingView {
    private func setupViews() {
        setupView()
        setupStackView()
        setupImageView()
        setupTitleLabel()
        setupDescriptionLabel()
    }
    
    private func setupView() {
        backgroundColor = .systemBackground
    }
    
    private func setupStackView() {
        addSubview(stackView)
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 40)
        ])
    }
    
    private func setupImageView() {
        stackView.addArrangedSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        imageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.35).isActive = true
    }
    
    private func setupTitleLabel() {
        stackView.addArrangedSubview(titleLabel)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 2
        titleLabel.font = .boldSystemFont(ofSize: 20)
        titleLabel.textColor = .label
    }
    
    private func setupDescriptionLabel() {
        stackView.addArrangedSubview(descriptionLabel)
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = .systemFont(ofSize: 17)
        descriptionLabel.textColor = .secondaryLabel
    }
}
