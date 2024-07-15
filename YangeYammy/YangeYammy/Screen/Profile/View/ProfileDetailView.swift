//
//  ProfileDetailView.swift
//  YangeYammy
//
//  Created by siyeon park on 5/21/24.
//

import UIKit
import SnapKit

final class ProfileDetailView: BaseView {
    var scrollView = UIScrollView()
    private let containerView = UIView()

    var profileImage: UIImageView = {
        let profileImage = UIImageView()
        profileImage.tintColor = .lightGray
        profileImage.contentMode = .scaleAspectFit
        profileImage.layer.masksToBounds = true
        profileImage.image = UIImage(systemName: "cat")
        profileImage.isUserInteractionEnabled = true
        return profileImage
    }()
    
    let genderTitleLabel: UILabel = {
        let genderTitle = UILabel()
        genderTitle.font = .systemFont(ofSize: 16, weight: .medium)
        genderTitle.textColor = UIColor(red: 189/255, green: 189/255, blue: 189/255, alpha: 1.0)
        genderTitle.text = "성별"
        return genderTitle
    }()
    
    let genderLabel: UILabel = {
        let genderLabel = UILabel()
        genderLabel.font = .systemFont(ofSize: 16, weight: .medium)
        genderLabel.textColor = UIColor(red: 189/255, green: 189/255, blue: 189/255, alpha: 1.0)
        genderLabel.text = "여아"
        return genderLabel
    }()
    
    let genderStackView: UIStackView = {
        let genderStackView = UIStackView()
        genderStackView.axis = .horizontal
        genderStackView.alignment = .fill
        genderStackView.distribution = .equalCentering
        genderStackView.spacing = 8
        return genderStackView
    }()
    
    let nameTitleLabel: UILabel = {
        let nameTitle = UILabel()
        nameTitle.font = .systemFont(ofSize: 16, weight: .medium)
        nameTitle.textColor = UIColor(red: 189/255, green: 189/255, blue: 189/255, alpha: 1.0)
        nameTitle.text = "이름"
        return nameTitle
    }()
    
    let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = .systemFont(ofSize: 16, weight: .medium)
        nameLabel.textColor = UIColor(red: 189/255, green: 189/255, blue: 189/255, alpha: 1.0)
        nameLabel.text = "공주"
        return nameLabel
    }()
    
    let nameStackView: UIStackView = {
        let nameStackView = UIStackView()
        nameStackView.axis = .horizontal
        nameStackView.alignment = .fill
        nameStackView.distribution = .equalCentering
        nameStackView.spacing = 8
        return nameStackView
    }()
    
    let ageTitleLabel: UILabel = {
        let ageTitle = UILabel()
        ageTitle.font = .systemFont(ofSize: 16, weight: .medium)
        ageTitle.textColor = UIColor(red: 189/255, green: 189/255, blue: 189/255, alpha: 1.0)
        ageTitle.text = "나이"
        return ageTitle
    }()
    
    let ageLabel: UILabel = {
        let ageLabel = UILabel()
        ageLabel.font = .systemFont(ofSize: 16, weight: .medium)
        ageLabel.textColor = UIColor(red: 189/255, green: 189/255, blue: 189/255, alpha: 1.0)
        return ageLabel
    }()
    
    let ageStackView: UIStackView = {
        let ageStackView = UIStackView()
        ageStackView.axis = .horizontal
        ageStackView.alignment = .fill
        ageStackView.distribution = .equalCentering
        ageStackView.spacing = 8
        return ageStackView
    }()
    
    let weightTitleLabel: UILabel = {
        let weightTitle = UILabel()
        weightTitle.font = .systemFont(ofSize: 16, weight: .medium)
        weightTitle.textColor = UIColor(red: 189/255, green: 189/255, blue: 189/255, alpha: 1.0)
        weightTitle.text = "몸무게"
        return weightTitle
    }()
    
    let weightLabel: UILabel = {
        let weightLabel = UILabel()
        weightLabel.font = .systemFont(ofSize: 16, weight: .medium)
        weightLabel.textColor = UIColor(red: 189/255, green: 189/255, blue: 189/255, alpha: 1.0)
        weightLabel.text = "3.5"
        return weightLabel
    }()
    
    let weightStackView: UIStackView = {
        let weightStackView = UIStackView()
        weightStackView.axis = .horizontal
        weightStackView.alignment = .fill
        weightStackView.distribution = .equalCentering
        weightStackView.spacing = 8
        return weightStackView
    }()
    
    let kcalTitleLabel: UILabel = {
        let kcalTitle = UILabel()
        kcalTitle.font = .systemFont(ofSize: 16, weight: .medium)
        kcalTitle.textColor = UIColor(red: 189/255, green: 189/255, blue: 189/255, alpha: 1.0)
        kcalTitle.text = "현재 사료 칼로리"
        return kcalTitle
    }()
    
    let kcalLabel: UILabel = {
        let kcalLabel = UILabel()
        kcalLabel.font = .systemFont(ofSize: 16, weight: .medium)
        kcalLabel.textColor = UIColor(red: 189/255, green: 189/255, blue: 189/255, alpha: 1.0)
        kcalLabel.text = "405"
        return kcalLabel
    }()
    
    let kcalStackView: UIStackView = {
        let kcalStackView = UIStackView()
        kcalStackView.axis = .horizontal
        kcalStackView.alignment = .fill
        kcalStackView.distribution = .equalCentering
        kcalStackView.spacing = 8
        return kcalStackView
    }()
    
    let neutrificationTitleLabel: UILabel = {
        let neutrificationTitle = UILabel()
        neutrificationTitle.font = .systemFont(ofSize: 16, weight: .medium)
        neutrificationTitle.textColor = UIColor(red: 189/255, green: 189/255, blue: 189/255, alpha: 1.0)
        neutrificationTitle.text = "중성화 여부"
        return neutrificationTitle
    }()
    
    let neutrificationLabel: UILabel = {
        let neutrificationLabel = UILabel()
        neutrificationLabel.font = .systemFont(ofSize: 16, weight: .medium)
        neutrificationLabel.textColor = UIColor(red: 189/255, green: 189/255, blue: 189/255, alpha: 1.0)
        neutrificationLabel.text = "네"
        return neutrificationLabel
    }()
    
    let neutrificationStackView: UIStackView = {
        let neutrificationStackView = UIStackView()
        neutrificationStackView.axis = .horizontal
        neutrificationStackView.alignment = .fill
        neutrificationStackView.distribution = .equalCentering
        neutrificationStackView.spacing = 8
        return neutrificationStackView
    }()
    
    let bcsTitleLabel: UILabel = {
        let bcsTitle = UILabel()
        bcsTitle.font = .systemFont(ofSize: 16, weight: .medium)
        bcsTitle.textColor = UIColor(red: 189/255, green: 189/255, blue: 189/255, alpha: 1.0)
        bcsTitle.text = "BCS 점수"
        return bcsTitle
    }()
    
    let bcsLabel: UILabel = {
        let bcsLabel = UILabel()
        bcsLabel.font = .systemFont(ofSize: 16, weight: .medium)
        bcsLabel.textColor = UIColor(red: 189/255, green: 189/255, blue: 189/255, alpha: 1.0)
        bcsLabel.text = "BCS 4점"
        return bcsLabel
    }()
    
    let bcsStackView: UIStackView = {
        let bcsStackView = UIStackView()
        bcsStackView.axis = .horizontal
        bcsStackView.alignment = .fill
        bcsStackView.distribution = .equalCentering
        bcsStackView.spacing = 8
        return bcsStackView
    }()
    
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
        containerView.addSubviews([profileImage,
                                   genderStackView,
                                   nameStackView,
                                   ageStackView,
                                   weightStackView,
                                   kcalStackView,
                                   neutrificationStackView,
                                   bcsStackView])
        
        genderStackView.addSubviews([genderTitleLabel, genderLabel])
        nameStackView.addSubviews([nameTitleLabel, nameLabel])
        ageStackView.addSubviews([ageTitleLabel, ageLabel])
        weightStackView.addSubviews([weightTitleLabel, weightLabel])
        kcalStackView.addSubviews([kcalTitleLabel, kcalLabel])
        neutrificationStackView.addSubviews([neutrificationTitleLabel, neutrificationLabel])
        bcsStackView.addSubviews([bcsTitleLabel, bcsLabel])
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
        
        nameStackView.snp.makeConstraints { make in
            make.top.equalTo(profileImage.snp.bottom).offset(20)
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
            make.height.equalTo(50)
        }
        
        nameTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(nameStackView)
            make.centerY.equalTo(nameStackView)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(nameTitleLabel.snp.trailing).offset(20)
            make.centerY.equalTo(nameStackView)
        }
        
        ageStackView.snp.makeConstraints { make in
            make.top.equalTo(nameStackView.snp.bottom).offset(10)
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
            make.height.equalTo(50)
        }
        
        ageTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(ageStackView)
            make.centerY.equalTo(ageStackView)
        }
        
        ageLabel.snp.makeConstraints { make in
            make.leading.equalTo(ageTitleLabel.snp.trailing).offset(20)
            make.centerY.equalTo(ageStackView)
        }
        
        weightStackView.snp.makeConstraints { make in
            make.top.equalTo(ageStackView.snp.bottom).offset(10)
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
            make.height.equalTo(50)
        }
        
        weightTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(weightStackView)
            make.centerY.equalTo(weightStackView)
        }
        
        weightLabel.snp.makeConstraints { make in
            make.leading.equalTo(weightTitleLabel.snp.trailing).offset(20)
            make.centerY.equalTo(weightStackView)
        }
        
        kcalStackView.snp.makeConstraints { make in
            make.top.equalTo(weightStackView.snp.bottom).offset(10)
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
            make.height.equalTo(50)
        }
        
        kcalTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(kcalStackView)
            make.centerY.equalTo(kcalStackView)
        }
        
        kcalLabel.snp.makeConstraints { make in
            make.leading.equalTo(kcalTitleLabel.snp.trailing).offset(20)
            make.centerY.equalTo(kcalStackView)
        }
        
        neutrificationStackView.snp.makeConstraints { make in
            make.top.equalTo(kcalStackView.snp.bottom).offset(10)
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
            make.height.equalTo(50)
        }
        
        neutrificationTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(neutrificationStackView)
            make.centerY.equalTo(neutrificationStackView)
        }
        
        neutrificationLabel.snp.makeConstraints { make in
            make.leading.equalTo(neutrificationTitleLabel.snp.trailing).offset(20)
            make.centerY.equalTo(neutrificationStackView)
        }
        
        bcsStackView.snp.makeConstraints { make in
            make.top.equalTo(neutrificationStackView.snp.bottom).offset(10)
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
            make.height.equalTo(50)
        }
        
        bcsTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(bcsStackView)
            make.centerY.equalTo(bcsStackView)
        }
        
        bcsLabel.snp.makeConstraints { make in
            make.leading.equalTo(bcsTitleLabel.snp.trailing).offset(20)
            make.centerY.equalTo(bcsStackView)
        }
    }
}
