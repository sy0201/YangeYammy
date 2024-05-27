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
    
    let neutrificationTitle: UILabel = {
        let title = UILabel()
        title.font = UIFont.systemFont(ofSize: 16)
        title.textColor = UIColor(red: 93/255, green: 176/255, blue: 117/255, alpha: 1.0)
        title.text = "중성화를 하셨나요?"
        return title
    }()
    
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
        yes.textColor = UIColor(red: 189/255, green: 189/255, blue: 189/255, alpha: 1.0)
        yes.text = "네"
        return yes
    }()
    let yesButton = UIButton()
    
    let noView: UIView = {
        let noView = UIView()
        noView.backgroundColor = .systemBackground
        noView.layer.borderColor = CGColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1.0)
        noView.layer.borderWidth = 1
        return noView
    }()
    let noLabel: UILabel = {
        let no = UILabel()
        no.font = .systemFont(ofSize: 16, weight: .medium)
        no.textColor = UIColor(red: 189/255, green: 189/255, blue: 189/255, alpha: 1.0)
        no.text = "아니오"
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
    
    let bcsTitle: UILabel = {
        let bcsTitle = UILabel()
        bcsTitle.font = UIFont.systemFont(ofSize: 16)
        bcsTitle.textColor = UIColor(red: 93/255, green: 176/255, blue: 117/255, alpha: 1.0)
        bcsTitle.text = "고양이 비만 정도를 측정하는 BCS(총 5단계)"
        return bcsTitle
    }()
    
    let bcs1View: UIView = {
        let bcs1View = UIView()
        bcs1View.backgroundColor = .systemBackground
        bcs1View.layer.borderColor = CGColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1.0)
        bcs1View.layer.borderWidth = 1
        return bcs1View
    }()
    let bcs1Label: UILabel = {
        let bcs1Label = UILabel()
        bcs1Label.font = .systemFont(ofSize: 16, weight: .medium)
        bcs1Label.textColor = UIColor(red: 189/255, green: 189/255, blue: 189/255, alpha: 1.0)
        bcs1Label.text = "BCS 1점, 마름"
        return bcs1Label
    }()
    let bcs1Button = UIButton()
    
    let bcs2View: UIView = {
        let bcs2View = UIView()
        bcs2View.backgroundColor = .systemBackground
        bcs2View.layer.borderColor = CGColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1.0)
        bcs2View.layer.borderWidth = 1
        return bcs2View
    }()
    let bcs2Label: UILabel = {
        let bcs2Label = UILabel()
        bcs2Label.font = .systemFont(ofSize: 16, weight: .medium)
        bcs2Label.textColor = UIColor(red: 189/255, green: 189/255, blue: 189/255, alpha: 1.0)
        bcs2Label.text = "BCS 2점, 약간마름"
        return bcs2Label
    }()
    let bcs2Button = UIButton()
    
    let bcs3View: UIView = {
        let bcs3View = UIView()
        bcs3View.backgroundColor = .systemBackground
        bcs3View.layer.borderColor = CGColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1.0)
        bcs3View.layer.borderWidth = 1
        return bcs3View
    }()
    
    let bcs3Label: UILabel = {
        let bcs3Label = UILabel()
        bcs3Label.font = .systemFont(ofSize: 16, weight: .medium)
        bcs3Label.textColor = UIColor(red: 189/255, green: 189/255, blue: 189/255, alpha: 1.0)
        bcs3Label.text = "BCS 3점, 이상적"
        return bcs3Label
    }()
    let bcs3Button = UIButton()
    
    let bcs4View: UIView = {
        let bcs4View = UIView()
        bcs4View.backgroundColor = .systemBackground
        bcs4View.layer.borderColor = CGColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1.0)
        bcs4View.layer.borderWidth = 1
        return bcs4View
    }()
    let bcs4Label: UILabel = {
        let bcs4Label = UILabel()
        bcs4Label.font = .systemFont(ofSize: 16, weight: .medium)
        bcs4Label.textColor = UIColor(red: 189/255, green: 189/255, blue: 189/255, alpha: 1.0)
        bcs4Label.text = "BCS 4점, 경도의 비만"
        return bcs4Label
    }()
    let bcs4Button = UIButton()
    
    let bcs5View: UIView = {
        let bcs5View = UIView()
        bcs5View.backgroundColor = .systemBackground
        bcs5View.layer.borderColor = CGColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1.0)
        bcs5View.layer.borderWidth = 1
        return bcs5View
    }()
    let bcs5Label: UILabel = {
        let bcs5Label = UILabel()
        bcs5Label.font = .systemFont(ofSize: 16, weight: .medium)
        bcs5Label.textColor = UIColor(red: 189/255, green: 189/255, blue: 189/255, alpha: 1.0)
        bcs5Label.text = "BCS 5점, 비만"
        return bcs5Label
    }()
    let bcs5Button = UIButton()
    
    let bcsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalCentering
        stackView.spacing = 0
        return stackView
    }()
    
    var isNeutrificationTapped: Bool = false {
        didSet {
            self.changeNeutrificationState()
        }
    }
    
    var isBcsTapped: Bool = false {
        didSet {
            self.changeBcsState()
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
        
        containerView.addSubviews([neutrificationTitle, 
                                   stackView,
                                   bcsTitle,
                                   bcsStackView])
        
        stackView.addSubviews([yesView, noView])
        bcsStackView.addSubviews([bcs1View, 
                                  bcs2View,
                                  bcs3View,
                                  bcs4View,
                                  bcs5View])
        
        containerView.addSubviews([yesLabel,
                                   yesButton,
                                   noLabel,
                                   noButton,
                                   bcs1Label,
                                   bcs1Button,
                                   bcs2Label,
                                   bcs2Button,
                                   bcs3Label,
                                   bcs3Button,
                                   bcs4Label,
                                   bcs4Button,
                                   bcs5Label,
                                   bcs5Button])
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
        
        neutrificationTitle.snp.makeConstraints { make in
            make.top.equalTo(containerView).offset(50)
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(neutrificationTitle.snp.bottom).offset(10)
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
        
        bcsTitle.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(20)
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
        }
        
        bcsStackView.snp.makeConstraints { make in
            make.top.equalTo(bcsTitle.snp.bottom).offset(10)
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
        }
        
        bcs1View.snp.makeConstraints { make in
            make.edges.equalTo(bcsStackView)
            make.height.equalTo(50)
        }
        
        bcs1Label.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(bcs1View)
        }
        
        bcs1Button.snp.makeConstraints { make in
            make.edges.equalTo(bcs1View)
        }
        
        bcs2View.snp.makeConstraints { make in
            make.leading.trailing.equalTo(bcsStackView)
            make.top.equalTo(bcs1View.snp.bottom).offset(5)
            make.height.equalTo(50)
        }
        
        bcs2Label.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(bcs2View)
        }
        
        bcs2Button.snp.makeConstraints { make in
            make.edges.equalTo(bcs2View)
        }
        
        bcs3View.snp.makeConstraints { make in
            make.leading.trailing.equalTo(bcsStackView)
            make.top.equalTo(bcs2View.snp.bottom).offset(5)
            make.height.equalTo(50)
        }
        
        bcs3Label.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(bcs3View)
        }
        
        bcs3Button.snp.makeConstraints { make in
            make.edges.equalTo(bcs3View)
        }
        
        bcs4View.snp.makeConstraints { make in
            make.leading.trailing.equalTo(bcsStackView)
            make.top.equalTo(bcs3View.snp.bottom).offset(5)
            make.height.equalTo(50)
        }
        
        bcs4Label.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(bcs4View)
        }
        
        bcs4Button.snp.makeConstraints { make in
            make.edges.equalTo(bcs4View)
        }
        
        bcs5View.snp.makeConstraints { make in
            make.leading.trailing.equalTo(bcsStackView)
            make.top.equalTo(bcs4View.snp.bottom).offset(5)
            make.height.equalTo(50)
        }
        
        bcs5Label.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(bcs5View)
        }
        
        bcs5Button.snp.makeConstraints { make in
            make.edges.equalTo(bcs5View)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        scrollView.contentSize = containerView.bounds.size
        
        yesView.layer.cornerRadius = 25
        yesView.clipsToBounds = true
        
        noView.layer.cornerRadius = 25
        noView.clipsToBounds = true
        
        bcs1View.layer.cornerRadius = 25
        bcs1View.clipsToBounds = true
        
        bcs2View.layer.cornerRadius = 25
        bcs2View.clipsToBounds = true
        
        bcs3View.layer.cornerRadius = 25
        bcs3View.clipsToBounds = true
        
        bcs4View.layer.cornerRadius = 25
        bcs4View.clipsToBounds = true
        
        bcs5View.layer.cornerRadius = 25
        bcs5View.clipsToBounds = true
    }
    
    func selectNeutrification(neutrification: Neutrification) {
        isNeutrificationTapped = true
        setupNeutrificationButton(view: yesView, label: yesLabel, isNeutrificationTapped: neutrification == .yes)
        setupNeutrificationButton(view: noView, label: noLabel, isNeutrificationTapped: neutrification == .no)
    }
    
    private func setupNeutrificationButton(view: UIView, label: UILabel, isNeutrificationTapped: Bool) {
        if isNeutrificationTapped {
            print("isNeutrificationTapped\(isNeutrificationTapped)")
            view.backgroundColor = UIColor(red: 93/255, green: 176/255, blue: 117/255, alpha: 1.0)
            label.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        } else {
            view.backgroundColor = .systemBackground
            label.textColor = UIColor(red: 189/255, green: 189/255, blue: 189/255, alpha: 1.0)
        }
    }
    
    func changeNeutrificationState() {
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

extension ProfileBView {
    func selectBcs(bcs: BcsType) {
        isBcsTapped = true
        setupBcsButton(view: bcs1View, label: bcs1Label, isBcsTapped: bcs == .bcs1)
        setupBcsButton(view: bcs2View, label: bcs2Label, isBcsTapped: bcs == .bcs2)
        setupBcsButton(view: bcs3View, label: bcs3Label, isBcsTapped: bcs == .bcs3)
        setupBcsButton(view: bcs4View, label: bcs4Label, isBcsTapped: bcs == .bcs4)
        setupBcsButton(view: bcs5View, label: bcs5Label, isBcsTapped: bcs == .bcs5)
    }
    
    private func setupBcsButton(view: UIView, label: UILabel, isBcsTapped: Bool) {
        if isBcsTapped {
            view.backgroundColor = UIColor(red: 93/255, green: 176/255, blue: 117/255, alpha: 1.0)
            label.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        } else {
            view.backgroundColor = .systemBackground
            label.textColor = UIColor(red: 189/255, green: 189/255, blue: 189/255, alpha: 1.0)
        }
    }
    
    func selectBcsState() {
        let isSelected = isBcsTapped
        bcs1View.backgroundColor = isSelected ? .systemBackground : UIColor(red: 93/255, green: 176/255, blue: 117/255, alpha: 1.0)
        bcs2View.backgroundColor = isSelected ? .systemBackground : UIColor(red: 93/255, green: 176/255, blue: 117/255, alpha: 1.0)
        bcs3View.backgroundColor = isSelected ? .systemBackground : UIColor(red: 93/255, green: 176/255, blue: 117/255, alpha: 1.0)
        bcs4View.backgroundColor = isSelected ? .systemBackground : UIColor(red: 93/255, green: 176/255, blue: 117/255, alpha: 1.0)
        bcs5View.backgroundColor = isSelected ? .systemBackground : UIColor(red: 93/255, green: 176/255, blue: 117/255, alpha: 1.0)
    }
    
    func changeBcsState() {
        let isSelected = isBcsTapped
        bcs1Label.font = isSelected ? .systemFont(ofSize: 16, weight: .medium) : .systemFont(ofSize: 16, weight: .bold)
        bcs2Label.font = isSelected ? .systemFont(ofSize: 16, weight: .medium) : .systemFont(ofSize: 16, weight: .bold)
        bcs3Label.font = isSelected ? .systemFont(ofSize: 16, weight: .medium) : .systemFont(ofSize: 16, weight: .bold)
        bcs4Label.font = isSelected ? .systemFont(ofSize: 16, weight: .medium) : .systemFont(ofSize: 16, weight: .bold)
        bcs5Label.font = isSelected ? .systemFont(ofSize: 16, weight: .medium) : .systemFont(ofSize: 16, weight: .bold)
        
        let textColor = isSelected ? UIColor(red: 189/255, green: 189/255, blue: 189/255, alpha: 1.0) : UIColor(red: 1/255, green: 0/255, blue: 0/255, alpha: 1.0)
        
        bcs1Label.textColor = textColor
        bcs2Label.textColor = textColor
        bcs3Label.textColor = textColor
        bcs4Label.textColor = textColor
        bcs5Label.textColor = textColor
        

    }
}
