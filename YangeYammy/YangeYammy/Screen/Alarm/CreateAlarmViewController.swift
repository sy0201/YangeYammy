//
//  CreateAlarmViewController.swift
//  YangeYammy
//
//  Created by siyeon park on 4/12/24.
//

import UIKit

final class CreateAlarmViewController: UIViewController {
    let createAlarmView = CreateAlarmView()
    let alarmManager = AlarmManager.shared
    weak var delegate: AlarmDelegate?
    
    override func loadView() {
        view = createAlarmView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        createAlarmView.delegate = self
    }
    
    func presentAlarmRepeatDetailViewController() {
        let selectDayVC = SelectDayViewController()
        navigationController?.pushViewController(selectDayVC, animated: true)
    }
}

// MARK: - Private Methods

private extension CreateAlarmViewController {
    func setupNavigationBar() {
        self.title = "알람추가"
        
        let cancelBarButton = UIBarButtonItem(title: "취소",
                                            style: .plain,
                                            target: self,
                                            action: #selector(cancelBarButtonTapped))
        let saveBarButton = UIBarButtonItem(title: "저장",
                                            style: .plain,
                                            target: self,
                                            action: #selector(saveBarButtonTapped))

        cancelBarButton.tintColor = .systemOrange
        saveBarButton.tintColor = .systemOrange
        
        self.navigationItem.leftBarButtonItem = cancelBarButton
        self.navigationItem.rightBarButtonItem = saveBarButton
    }
    
    @objc func cancelBarButtonTapped() {
        self.dismiss(animated: true)
    }
    
    @objc func saveBarButtonTapped() {
        let newAlarm = AlarmModel(date: createAlarmView.datePickerView.date, isOn: true, repeatedDays: [])
        
        alarmManager.saveAlarm(date: newAlarm.date, isOn: newAlarm.isOn, repeatedDays: newAlarm.repeatedDays)

        delegate?.addNewAlarm(newAlarm)
        delegate?.reloadAlarmView()
        
        self.dismiss(animated: true)
    }
}

// MARK: - RepeatedDateViewCellDelegate

extension CreateAlarmViewController: RepeatedDateViewCellDelegate {
    func repeatedDateViewCellDidTapSetDateButton() {
        presentAlarmRepeatDetailViewController()
    }
}
