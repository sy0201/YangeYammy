//
//  SelectDayViewController.swift
//  YangeYammy
//
//  Created by siyeon park on 4/25/24.
//

import UIKit

final class SelectDayViewController: UIViewController {
    weak var selectDayDelegate: DayTableViewCellDelegate?
    var day: [Day] = []
    var selectedDay: Day?
    
    let selectDayView = SelectDayView()
    
    override func loadView() {
        view = selectDayView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        day = Day.allCases
    }
}

// MARK: - private Methods

private extension SelectDayViewController {
    func setupTableView() {
        selectDayView.tableView.dataSource = self
        selectDayView.tableView.delegate = self
        
        selectDayView.tableView.register(DayTableViewCell.self, forCellReuseIdentifier: DayTableViewCell.reuseIdentifier)
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension SelectDayViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Day.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DayTableViewCell.reuseIdentifier, for: indexPath) as? DayTableViewCell else {
            return UITableViewCell() }
        
        let currentDay = day[indexPath.row]
        cell.configure(with: currentDay, isSelected: currentDay == selectedDay)
        cell.delegate = selectDayDelegate
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        44
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let selectedDay = day[indexPath.row]
        selectDayDelegate?.didSelectDay(selectedDay)
    }
}
