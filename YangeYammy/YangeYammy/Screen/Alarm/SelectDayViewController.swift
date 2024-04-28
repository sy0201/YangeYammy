//
//  SelectDayViewController.swift
//  YangeYammy
//
//  Created by siyeon park on 4/25/24.
//

import UIKit

final class SelectDayViewController: UIViewController {
    let selectDayView = SelectDayView()
    
    override func loadView() {
        view = selectDayView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
