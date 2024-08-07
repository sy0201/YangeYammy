//
//  ProfileAView.swift
//  YangeYammy
//
//  Created by siyeon park on 4/22/24.
//

import UIKit
import SnapKit

final class ProfileAView: BaseView {
    var scrollView = UIScrollView()
    private let containerView = UIView()
    var profileImage: UIImageView = {
        let profileImage = UIImageView()
        profileImage.tintColor = .lightGray
        profileImage.contentMode = .scaleAspectFit
        profileImage.image = UIImage(systemName: "cat")
        profileImage.isUserInteractionEnabled = true
        profileImage.layer.borderColor = CGColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1.0)
        profileImage.layer.borderWidth = 1
        profileImage.layer.cornerRadius = profileImage.frame.width / 2
        profileImage.clipsToBounds = true
        return profileImage
    }()
    let editButton = UIButton()
    
    let maleView: UIView = {
        let male = UIView()
        male.backgroundColor = .systemBackground
        male.layer.borderColor = CGColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1.0)
        male.layer.borderWidth = 1
        return male
    }()
    let maleLabel: UILabel = {
        let male = UILabel()
        male.font = .systemFont(ofSize: 16, weight: .medium)
        male.textColor = UIColor(red: 189/255, green: 189/255, blue: 189/255, alpha: 1.0)
        male.text = "남아"
        return male
    }()
    let maleButton = UIButton()
    
    let femaleView: UIView = {
        let female = UIView()
        female.backgroundColor = .systemBackground
        female.layer.borderColor = CGColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1.0)
        female.layer.borderWidth = 1
        return female
    }()
    
    let femaleLabel: UILabel = {
        let female = UILabel()
        female.font = .systemFont(ofSize: 16, weight: .medium)
        female.textColor = UIColor(red: 189/255, green: 189/255, blue: 189/255, alpha: 1.0)
        female.text = "여아"
        return female
    }()
    let femaleButton = UIButton()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .equalCentering
        stackView.spacing = 8
        return stackView
    }()
    
    var name: UITextField = {
        let name = UITextField()
        name.borderStyle = .roundedRect
        name.keyboardType = .default
        name.backgroundColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1.0)
        name.attributedPlaceholder = NSAttributedString(string: "이름을 입력해주세요.", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 189/255, green: 189/255, blue: 189/255, alpha: 1.0)])

        return name
    }()
    
    var year: UITextField = {
        let year = UITextField()
        year.borderStyle = .roundedRect
        year.keyboardType = .numberPad
        year.backgroundColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1.0)
        year.attributedPlaceholder = NSAttributedString(string: "연도 예시)2024", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 189/255, green: 189/255, blue: 189/255, alpha: 1.0)])
        
        return year
    }()
    
    var month: UITextField = {
        let month = UITextField()
        month.borderStyle = .roundedRect
        month.keyboardType = .numberPad
        month.backgroundColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1.0)
        month.attributedPlaceholder = NSAttributedString(string: "월 예시)03", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 189/255, green: 189/255, blue: 189/255, alpha: 1.0)])
        
        return month
    }()
    
    let birthStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .equalCentering
        stackView.spacing = 8
        return stackView
    }()
    
    var weight: UITextField = {
        let weight = UITextField()
        weight.borderStyle = .roundedRect
        weight.keyboardType = .numbersAndPunctuation
        weight.backgroundColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1.0)
        weight.attributedPlaceholder = NSAttributedString(string: "몸무게를 입력해주세요. 예시) 3.0", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 189/255, green: 189/255, blue: 189/255, alpha: 1.0)])

        return weight
    }()
    
    var kcal: UITextField = {
        let kcal = UITextField()
        kcal.borderStyle = .roundedRect
        kcal.keyboardType = .numberPad
        kcal.backgroundColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1.0)
        kcal.attributedPlaceholder = NSAttributedString(string: "현재 사료 칼로리를 입력해주세요.", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 189/255, green: 189/255, blue: 189/255, alpha: 1.0)])

        return kcal
    }()
    
    var isGenderTapped: Bool = false {
        didSet {
            self.changeState()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraint()
        viewTapGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupUI() {
        scrollView.backgroundColor = .white
        addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubviews([profileImage,
                                   editButton,
                                   stackView,
                                   maleLabel,
                                   maleButton,
                                   femaleLabel,
                                   femaleButton,
                                   name,
                                   birthStackView,
                                   weight,
                                   kcal])
        
        stackView.addSubviews([maleView, femaleView])
        birthStackView.addSubviews([year, month])
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
        
        profileImage.snp.makeConstraints { make in
            make.top.equalTo(containerView).offset(20)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(128)
        }
        
        editButton.snp.makeConstraints { make in
            make.edges.equalTo(profileImage)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(editButton.snp.bottom).offset(20)
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
            make.height.equalTo(50)
        }
        
        maleView.snp.makeConstraints { make in
            make.leading.top.bottom.equalTo(stackView)
            make.width.equalTo(stackView.snp.width).offset(-5).multipliedBy(0.5)
        }
        
        maleLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(maleView)
        }
        
        maleButton.snp.makeConstraints { make in
            make.edges.equalTo(maleView)
        }
        
        femaleView.snp.makeConstraints { make in
            make.leading.equalTo(maleView.snp.trailing)
            make.trailing.top.bottom.equalTo(stackView)
            make.width.equalTo(stackView.snp.width).offset(-5).multipliedBy(0.5)
        }
        
        femaleLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(femaleView)
        }
        
        femaleButton.snp.makeConstraints { make in
            make.edges.equalTo(femaleView)
        }
        
        name.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(20)
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
            make.height.equalTo(50)
        }
        
        birthStackView.snp.makeConstraints { make in
            make.top.equalTo(name.snp.bottom).offset(20)
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
            make.height.equalTo(50)
        }
        
        year.snp.makeConstraints { make in
            make.leading.top.bottom.equalTo(birthStackView)
            make.width.equalTo(birthStackView.snp.width).offset(-5).multipliedBy(0.5)
            make.height.equalTo(50)
        }
        
        month.snp.makeConstraints { make in
            make.leading.equalTo(year.snp.trailing)
            make.trailing.top.bottom.equalTo(birthStackView)
            make.width.equalTo(birthStackView.snp.width).offset(-5).multipliedBy(0.5)
        }
        
        weight.snp.makeConstraints { make in
            make.top.equalTo(birthStackView.snp.bottom).offset(20)
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
            make.height.equalTo(50)
        }
        
        kcal.snp.makeConstraints { make in
            make.top.equalTo(weight.snp.bottom).offset(20)
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
            make.height.equalTo(50)
        }
    }
    
    override func draw(_ rect: CGRect) {
        scrollView.contentSize = containerView.bounds.size
        
        profileImage.layer.cornerRadius = profileImage.frame.width / 2
        profileImage.clipsToBounds = true
        
        maleView.layer.cornerRadius = 25
        maleView.clipsToBounds = true
        
        femaleView.layer.cornerRadius = 25
        femaleView.clipsToBounds = true
    }
    
    func viewTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        scrollView.addGestureRecognizer(tapGesture)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrameValue = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }
        
        let keyboardFrame = keyboardFrameValue.cgRectValue
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: (keyboardFrame.height)+20, right: 0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
        
        var rect = self.frame
        rect.size.height -= keyboardFrame.size.height
        if !rect.contains(kcal.frame.origin) {
            scrollView.scrollRectToVisible(kcal.frame, animated: true)
        }
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        scrollView.contentInset = .zero
        scrollView.scrollIndicatorInsets = .zero
    }
    
    @objc private func handleTap() {
        endEditing(true)
    }

    func selectGender(gender: Gender) {
        isGenderTapped = true
        setupButton(view: maleView, label: maleLabel, isGenderTapped: gender == .male)
        setupButton(view: femaleView, label: femaleLabel, isGenderTapped: gender == .female)
    }
    
    private func setupButton(view: UIView, label: UILabel, isGenderTapped: Bool) {
        if isGenderTapped {
            view.backgroundColor = UIColor(red: 93/255, green: 176/255, blue: 117/255, alpha: 1.0)
            label.textColor = .white
        } else {
            view.backgroundColor = .systemBackground
            label.textColor = UIColor(red: 189/255, green: 189/255, blue: 189/255, alpha: 1.0)
        }
    }

    
    func changeState() {
        let isSelected = isGenderTapped
        
        maleLabel.font = isSelected ? .systemFont(ofSize: 16, weight: .bold) : .systemFont(ofSize: 16, weight: .medium)
        femaleLabel.font = isSelected ? .systemFont(ofSize: 16, weight: .bold) : .systemFont(ofSize: 16, weight: .medium)
        
        let textColor = isSelected ? UIColor(red: 1/255, green: 0/255, blue: 0/255, alpha: 1.0) : UIColor(red: 189/255, green: 189/255, blue: 189/255, alpha: 1.0)
        
        maleLabel.textColor = textColor
        femaleLabel.textColor = textColor
        
        maleView.backgroundColor = isSelected ? UIColor(red: 93/255, green: 176/255, blue: 117/255, alpha: 1.0) : .systemBackground
        femaleView.backgroundColor = isSelected ? UIColor(red: 93/255, green: 176/255, blue: 117/255, alpha: 1.0) : .systemBackground
    }
}
