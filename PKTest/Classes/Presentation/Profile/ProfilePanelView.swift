//
//  Created by Dmitry Sochnev.
//  Copyright © 2018 Sochnev Dmitry. All rights reserved.
//

import UIKit

class ProfilePanelView: UIView {

    private struct Constants {
        static let margin: CGFloat = 8.0
        static let spacing: CGFloat = 8.0
    }

    private lazy var profileTitle: UILabel = {
        let nameTitle = UILabel(frame: .zero)
        nameTitle.translatesAutoresizingMaskIntoConstraints = false
        nameTitle.textColor = .darkGray
        nameTitle.text = "Профиль"
        nameTitle.textAlignment = .center
        return nameTitle
    }()

    private lazy var nameTitle: UILabel = {
        let nameTitle = UILabel(frame: .zero)
        nameTitle.translatesAutoresizingMaskIntoConstraints = false
        nameTitle.textColor = .lightGray
        nameTitle.text = "Имя"
        return nameTitle
    }()
    
    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel(frame: .zero)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.numberOfLines = 0
        return nameLabel
    }()

    private lazy var genderTitle: UILabel = {
        let genderTitle = UILabel(frame: .zero)
        genderTitle.translatesAutoresizingMaskIntoConstraints = false
        genderTitle.textColor = .lightGray
        genderTitle.text = "Пол"
        return genderTitle
    }()

    private lazy var genderLabel: UILabel = {
        let genderLabel = UILabel(frame: .zero)
        genderLabel.translatesAutoresizingMaskIntoConstraints = false
        return genderLabel
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews:
            [profileTitle, nameTitle, nameLabel, genderTitle, genderLabel]
        )
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = Constants.spacing
        return stackView
    }()

    var name: String? {
        didSet {
            nameLabel.text = name?.isEmpty == false ? name : "Не указано"
        }
    }

    var gender: String? = nil {
        didSet {
            genderLabel.text = gender
        }
    }

    override init(frame: CGRect){
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
}

// MARK: Private
extension ProfilePanelView {

    private func setup() {

        layer.borderColor = UIColor.darkGray.cgColor
        layer.borderWidth = 0.5

        addSubview(stackView)

        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.margin),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.margin),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.margin),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.margin)
            ])
    }
}
