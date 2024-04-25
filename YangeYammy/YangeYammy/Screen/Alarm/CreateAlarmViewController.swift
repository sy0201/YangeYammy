//
//  CreateAlarmViewController.swift
//  YangeYammy
//
//  Created by siyeon park on 4/12/24.
//

import UIKit

final class CreateAlarmViewController: UIViewController {
    let createAlarmView = CreateAlarmView()
    var pickedDate: ((_ date: Date) -> Void)?
    
    override func loadView() {
        super.loadView()
        view = createAlarmView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        createAlarmView.delegate = self
    }
    
    func presentAlarmRepeatDetailViewController() {
        let repeatDetailVC = AlarmRepeatDetailViewController()
        navigationController?.pushViewController(repeatDetailVC, animated: true)
    }
}

private extension CreateAlarmViewController {
    func setupNavigationBar() {
        self.title = "알람추가"
        
        let cancelBarButton = UIBarButtonItem(title: "취소",
                                            style: .plain,
                                            target: self,
                                            action: #selector(leftBarButtonTapped))
        let saveBarButton = UIBarButtonItem(title: "저장",
                                            style: .plain,
                                            target: self,
                                            action: #selector(rightBarButtonTapped))

        cancelBarButton.tintColor = .systemOrange
        saveBarButton.tintColor = .systemOrange
        
        self.navigationItem.leftBarButtonItem = cancelBarButton
        self.navigationItem.rightBarButtonItem = saveBarButton
    }
    
    @objc func leftBarButtonTapped() {
        self.dismiss(animated: true)
    }
    
    @objc func rightBarButtonTapped() {
        pickedDate?(createAlarmView.datePickerView.date)
        self.dismiss(animated: true)
    }
}

// MARK: - RepeatedDateViewCellDelegate

extension CreateAlarmViewController: RepeatedDateViewCellDelegate {
    func repeatedDateViewCellDidTapSetDateButton() {
        presentAlarmRepeatDetailViewController()
    }
}
