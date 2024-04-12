//
//  AlarmView.swift
//  YangeYammy
//
//  Created by siyeon park on 4/12/24.
//

import UIKit
import SnapKit

final class AlarmView: BaseView {
    var alarmList: [AlarmModel] = []
    
    private let containerView = UIView()
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.collectionView = collectionView
        setupUI()
        setupConstraint()
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupUI() {
        addSubview(containerView)
        containerView.addSubview(collectionView)
    }
    
    override func setupConstraint() {
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(containerView)
        }
    }
}

// MARK: - Private Methods

private extension AlarmView {
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeGesture.direction = .left
        collectionView.addGestureRecognizer(swipeGesture)
        
        collectionView.register(AlarmCollectionViewCell.self, forCellWithReuseIdentifier: AlarmCollectionViewCell.reuseIdentifier)
    }
    
    @objc func handleSwipe(_ gesture: UISwipeGestureRecognizer) {
        guard let indexPath = collectionView.indexPathForItem(at: gesture.location(in: collectionView)) else {
            return
        }
        
        alarmList.remove(at: indexPath.row)
        
        // collectionView에서 해당 셀을 삭제
        collectionView.performBatchUpdates({
            collectionView.deleteItems(at: [indexPath])
        }, completion: nil)
    }
}

// MARK: - UICollectionView Protocol

extension AlarmView: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        alarmList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AlarmCollectionViewCell.reuseIdentifier, for: indexPath) as? AlarmCollectionViewCell else {
            return UICollectionViewCell() }
        
        cell.setSwitchButton.isOn = alarmList[indexPath.row].isOn
        cell.timeLabel.text = alarmList[indexPath.row].time
        cell.meridiemLabel.text = alarmList[indexPath.row].meridiem
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.bounds.width, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, canEditItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if #available(iOS 14.0, *) {
//            guard collectionView.isEditing else { return }
//        } else {
//            // Fallback on earlier versions
//        }
//        let selectedIndex = indexPath.item
//        
//        alarmList.remove(at: selectedIndex)
//        collectionView.deleteItems(at: [indexPath])
//    }
}
