//
//  Protocol.swift
//  YangeYammy
//
//  Created by siyeon park on 4/25/24.
//

import Foundation

protocol DayTableViewCellDelegate: AnyObject {
    func didSelectDay(_ day: [Day])
}

protocol SwitchValueDelegate: AnyObject {
    func switchValueChanged(isOn: Bool)
}

protocol LabelTableViewCellDelegate: AnyObject {
    func textFieldDidChange(text: String?)
}

protocol AlarmSelectionDelegate: AnyObject {
    func didSelectAlarm(_ alarm: AlarmEntity)
}
