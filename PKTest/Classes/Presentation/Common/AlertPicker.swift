//
//  Created by Dmitry Sochnev.
//  Copyright © 2018 Sochnev Dmitry. All rights reserved.
//

import UIKit

protocol AlertPickerItem {
    var title: String { get }
}

class AlertPicker: UIViewController {

    private var items: [AlertPickerItem]!

    var onSelectItem: ((AlertPickerItem) -> Void)?

    var dismissOnSelect: Bool = false

    var preferredContentHeight: CGFloat {
        get { return preferredContentSize.height }
        set { preferredContentSize.height = newValue }
    }

    private lazy var pickerView: UIPickerView = {
        let pickerView = UIPickerView(frame: .zero)
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        pickerView.delegate = self
        pickerView.dataSource = self
        return pickerView
    }()

    convenience init(title: String, items: [AlertPickerItem]) {
        self.init()
        self.title = title
        self.items = items
    }
}

// MARK: View lifecicle
extension AlertPicker {
    override func loadView() {
        view = pickerView
    }
}

// Public
extension AlertPicker {
    func setCurrentItem(_ item: AlertPickerItem, animated: Bool) {
        let index = items.firstIndex { $0.title == item.title } ?? 0
        pickerView.selectRow(index , inComponent: 0, animated: animated)
    }

    func show(from controller: UIViewController) {
        let alertViewController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alertViewController.setValue(self, forKey: "contentViewController")
        alertViewController.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        controller.present(alertViewController, animated: true, completion: nil)
    }
}

// MARK: UIPickerViewDelegate
extension AlertPicker: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return items[row].title
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        onSelectItem?(items[row])
        if dismissOnSelect {
            parent?.dismiss(animated: true, completion: nil)
        }
    }
}

// MARK: UIPickerViewDataSource
extension AlertPicker: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return items.count
    }
}
