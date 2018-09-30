//
//  Created by Dmitry Sochnev.
//  Copyright © 2018 Sochnev Dmitry. All rights reserved.
//

import UIKit

class ProfileEditorViewController: UIViewController {

    private struct Constants {
        static let margin: CGFloat = 16.0
        static let spacing: CGFloat = 8.0
    }

    private var profile: Profile! {
        didSet {
            editedProfile = profile
        }
    }

    private var editedProfile: Profile!

    var onSaveEditedProfile: ((Profile) -> Void)?

    private lazy var nameTitle: UILabel = {
        let nameTitle = UILabel(frame: .zero)
        nameTitle.translatesAutoresizingMaskIntoConstraints = false
        nameTitle.textColor = .lightGray
        nameTitle.text = "Имя"
        return nameTitle
    }()

    private lazy var nameTextField: UITextField = {
        let nameTextField = UITextField(frame: .zero)
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.text = profile?.name
        nameTextField.placeholder = "Введите имя"
        nameTextField.addTarget(self, action: #selector(nameTextFieldDidChange(_:)), for: .editingChanged)
        return nameTextField
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
        genderLabel.text = profile?.gender.title
        genderLabel.isUserInteractionEnabled = true
        return genderLabel
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews:
            [nameTitle, nameTextField, genderTitle, genderLabel]
        )
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = Constants.spacing
        return stackView
    }()
}

// MARK: View lifecycle
extension ProfileEditorViewController {

    override func loadView() {
        super.loadView()
        view.addSubview(stackView)
        setupConstraints()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        setupNavigationItems()
        setupGestureRecognizers()
    }
}

// MARK: Public
extension ProfileEditorViewController {
    func setProfile(_ profile: Profile) {
        self.profile = profile
    }
}

// MARK: Private
extension ProfileEditorViewController {

    private func setupNavigationItems() {
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Назад",
            style: .plain,
            target: self,
            action: #selector(onBackAction)
        )
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                                               constant: Constants.margin),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                                                constant: -Constants.margin),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
    }

    private func setupGestureRecognizers() {
        let viewTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(onViewTap))
        view.addGestureRecognizer(viewTapRecognizer)

        let genderTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(onGenderLabelTap))
        genderLabel.addGestureRecognizer(genderTapRecognizer)
    }

    @objc private func onBackAction() {
        if profile.isEqual(with: editedProfile) {
            goBack()
        } else {
            showSaveConfirmAlert()
        }
    }

    private func showSaveConfirmAlert() {
        let alert = UIAlertController(
            title: nil,
            message: "Сохранить изменения перед возвратом?",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Да", style: .default) { [weak self] _ in
            guard let `self` = self, let profile = self.editedProfile else { return }
            self.onSaveEditedProfile?(profile)
            self.goBack()
        })
        alert.addAction(UIAlertAction(title: "Нет", style: .cancel) { [weak self] _ in
            self?.goBack()
        })
        present(alert, animated: true, completion: nil)
    }

    private func goBack() {
        navigationController?.popViewController(animated: true)
    }

    @objc private func onViewTap() {
        nameTextField.resignFirstResponder()
    }

    @objc private func onGenderLabelTap() {
        
        nameTextField.resignFirstResponder()

        let genderPicker = AlertPicker(title: "Выберите пол", items: Gender.allCases)
        genderPicker.setCurrentItem(editedProfile.gender, animated: false)
        genderPicker.dismissOnSelect = true
        genderPicker.preferredContentHeight = 120
        genderPicker.onSelectItem = { [weak self] item in
            self?.genderLabel.text = item.title
            self?.editedProfile.gender = item as! Gender
        }
        genderPicker.show(from: self)
    }

    @objc private func nameTextFieldDidChange(_ textField: UITextField) {
        editedProfile.name = textField.text ?? ""
    }
}
