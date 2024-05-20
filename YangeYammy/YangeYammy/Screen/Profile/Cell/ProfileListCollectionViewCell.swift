//
//  ProfileListCollectionViewCell.swift
//  YangeYammy
//
//  Created by siyeon park on 5/20/24.
//

import UIKit
import SnapKit

final class ProfileListCollectionViewCell: UICollectionViewCell, ReuseIdentifying {
    var profileData: ProfileEntity? {
        didSet {
            configure()
        }
    }
    
    var profileImage: UIImageView = {
        let profileImage = UIImageView()
        profileImage.tintColor = .purple
        profileImage.contentMode = .scaleAspectFit
        profileImage.layer.masksToBounds = true
        profileImage.isUserInteractionEnabled = true
        return profileImage
    }()
    
    var detailButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        profileImage.layer.cornerRadius = 25
        profileImage.clipsToBounds = true
    }
    
    func configure() {
        guard let profileData = profileData else {
            return
        }
        
        guard let profileImage = profileData.profileImage else {
            return
        }
    }
}

// MARK: - Private Methods

private extension ProfileListCollectionViewCell {
    func setupUI() {
        contentView.addSubviews([profileImage,
                                detailButton])
    }
    
    func setupConstraint() {
        profileImage.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.height.equalTo(100)
        }
    }
}
