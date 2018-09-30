//
//  Created by Dmitry Sochnev.
//  Copyright © 2018 Sochnev Dmitry. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    private struct Constants {
        static let margin: CGFloat = 16.0
    }

    private var storage: StorageProtocol! {
        didSet {
            profile = storage.retrieveProfile()
        }
    }

    private var profile: Profile! {
        didSet {
            profilePanel.name = profile.name
            profilePanel.gender = profile.gender.title
        }
    }

    private lazy var profilePanel: ProfilePanelView = {
        let profilePanel = ProfilePanelView(frame: .zero)
        profilePanel.translatesAutoresizingMaskIntoConstraints = false
        profilePanel.name = profile.name
        profilePanel.gender = profile.gender.title
        return profilePanel
    }()

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private lazy var contentView: UIView = {
        let contentView = UIView(frame: .zero)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
}

// MARK: View lifecycle
extension ProfileViewController {

    override func loadView() {
        super.loadView()
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(profilePanel)
        setupConstraints()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        setupNavigationItems()
    }
}

// MARK: Public
extension ProfileViewController {
    func setStorage(_ storage: StorageProtocol) {
        self.storage = storage
    }
}

// MARK: Private
extension ProfileViewController {

    private func setupNavigationItems() {
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Редактировать",
            style: .plain,
            target: self,
            action: #selector(onEditAction)
        )
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),

            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(greaterThanOrEqualTo: scrollView.heightAnchor),

            contentView.heightAnchor.constraint(greaterThanOrEqualTo: profilePanel.heightAnchor,
                                                constant: Constants.margin * 2),

            profilePanel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            profilePanel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            profilePanel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                  constant: Constants.margin),
            profilePanel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                   constant: -Constants.margin)
            ])
    }

    @objc private func onEditAction() {
        let profileEditorViewController = ControllerFactory.profileEditorViewController()
        profileEditorViewController.setProfile(profile)
        profileEditorViewController.onSaveEditedProfile = { [weak self] profile in
            self?.profile = profile
            self?.storage.saveProfile(profile)
        }
        navigationController?.pushViewController(profileEditorViewController, animated: true)
    }
}
