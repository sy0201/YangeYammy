//
//  ProfileBView.swift
//  YangeYammy
//
//  Created by siyeon park on 5/8/24.
//

import UIKit

final class ProfileBView: BaseView {
    var scrollView = UIScrollView()
    private let containerView = UIView()
    
    let yesView: UIView = {
        let yes = UIView()
        yes.backgroundColor = .systemBackground
        yes.layer.borderColor = CGColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1.0)
        yes.layer.borderWidth = 1
        return yes
    }()
    let yesLabel: UILabel = {
        let yes = UILabel()
        yes.font = .systemFont(ofSize: 16, weight: .medium)
        yes.text = "네"
        yes.textColor = UIColor(red: 189/255, green: 189/255, blue: 189/255, alpha: 1.0)
        return yes
    }()
    let yesButton = UIButton()
    
    let noView: UIView = {
        let female = UIView()
        female.backgroundColor = .systemBackground
        female.layer.borderColor = CGColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1.0)
        female.layer.borderWidth = 1
        return female
    }()
    
    let noLabel: UILabel = {
        let no = UILabel()
        no.font = .systemFont(ofSize: 16, weight: .medium)
        no.text = "아니오"
        no.textColor = UIColor(red: 189/255, green: 189/255, blue: 189/255, alpha: 1.0)
        return no
    }()
    let noButton = UIButton()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .equalCentering
        stackView.spacing = 8
        return stackView
    }()
    
    var isNeutrificationTapped: Bool = false {
        didSet {
            self.changeState()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupUI() {
        scrollView.backgroundColor = .white
        addSubview(scrollView)
        scrollView.addSubview(containerView)
        
        containerView.addSubview(stackView)
        
        stackView.addSubviews([yesView, noView])
        
        containerView.addSubviews([yesLabel,
                                   yesButton,
                                   noLabel,
                                   noButton])
    }
    
    override func setupConstraint() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        containerView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(scrollView)
            make.height.equalTo(500)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(containerView).offset(50)
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
            make.height.equalTo(50)
        }
        
        yesView.snp.makeConstraints { make in
            make.leading.top.bottom.equalTo(stackView)
            make.width.equalTo(stackView.snp.width).offset(-5).multipliedBy(0.5)
        }
        
        yesLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(yesView)
        }
        
        yesButton.snp.makeConstraints { make in
            make.edges.equalTo(yesView)
        }
        
        noView.snp.makeConstraints { make in
            make.leading.equalTo(yesView.snp.trailing)
            make.trailing.top.bottom.equalTo(stackView)
            make.width.equalTo(stackView.snp.width).offset(-5).multipliedBy(0.5)
        }
        
        noLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(noView)
        }
        
        noButton.snp.makeConstraints { make in
            make.edges.equalTo(noView)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        scrollView.contentSize = containerView.bounds.size
        
        yesView.layer.cornerRadius = 25
        yesView.clipsToBounds = true
        
        noView.layer.cornerRadius = 25
        noView.clipsToBounds = true
    }
    
    func selectYesOrNo(neutrification: Enum.Neutrification) {
        setupButton(view: yesView, label: yesLabel, isNeutrificationTapped: neutrification == .yes)
        setupButton(view: noView, label: noLabel, isNeutrificationTapped: neutrification == .no)
    }
    
    private func setupButton(view: UIView, label: UILabel, isNeutrificationTapped: Bool) {
        if isNeutrificationTapped {
            print("isNeutrificationTapped\(isNeutrificationTapped)")
            view.backgroundColor = UIColor(red: 93/255, green: 176/255, blue: 117/255, alpha: 1.0)
            label.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        } else {
            view.backgroundColor = .systemBackground
            label.textColor = UIColor(red: 189/255, green: 189/255, blue: 189/255, alpha: 1.0)
        }
    }
    
    func changeState() {
        let isSelected = isNeutrificationTapped
        
        yesLabel.font = isSelected ? .systemFont(ofSize: 16, weight: .medium) : .systemFont(ofSize: 16, weight: .bold)
        noLabel.font = isSelected ? .systemFont(ofSize: 16, weight: .medium) : .systemFont(ofSize: 16, weight: .bold)
        
        let textColor = isSelected ? UIColor(red: 189/255, green: 189/255, blue: 189/255, alpha: 1.0) : UIColor(red: 1/255, green: 0/255, blue: 0/255, alpha: 1.0)
        
        yesLabel.textColor = textColor
        noLabel.textColor = textColor
        
        yesView.backgroundColor = isSelected ? .systemBackground : UIColor(red: 93/255, green: 176/255, blue: 117/255, alpha: 1.0)
        noView.backgroundColor = isSelected ? .systemBackground : UIColor(red: 93/255, green: 176/255, blue: 117/255, alpha: 1.0)
    }
}
