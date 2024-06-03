//
//  ProfileListCollectionViewCell.swift
//  YangeYammy
//
//  Created by siyeon park on 5/20/24.
//

import UIKit
import SnapKit

final class ProfileListCollectionViewCell: UICollectionViewCell, ReuseIdentifying {
    
    var profileImage: UIImageView = {
        let profileImage = UIImageView()
        profileImage.contentMode = .scaleToFill
        profileImage.tintColor = .lightGray
        profileImage.isUserInteractionEnabled = true
        profileImage.layer.borderColor = CGColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1.0)
        profileImage.layer.borderWidth = 1
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
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        profileImage.layer.cornerRadius = profileImage.frame.width / 2
        profileImage.clipsToBounds = true
    }
    
    func configure(with profileData: ProfileEntity) {
        guard let profileImageString = profileData.profileImage else {
            profileImage.image = UIImage(systemName: "cat")
            return
        }
        
        if let profileImage = UIImage(data: Data(base64Encoded: profileImageString)!) {
            self.profileImage.image = profileImage
        } else {
            self.profileImage.image = UIImage(systemName: "cat")
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
