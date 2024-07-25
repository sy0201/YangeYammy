//
//  ProfileAViewController.swift
//  YangeYammy
//
//  Created by siyeon park on 4/22/24.
//

import UIKit
import AVFoundation
import Photos

final class ProfileAViewController: UIViewController {
    let profileDataManager = ProfileDataManager.shared
    var profileData: ProfileEntity?
    var genderType: Gender?
    var imagePicker = UIImagePickerController()

    let profileAView = ProfileAView()
    
    override func loadView() {
        view = profileAView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtonTapped()
        setupTextFieldDelegate()
    }
    
    func isProfileInfoComplete() -> Bool {
        let isGenderSelected = profileAView.isGenderTapped
        let isNameEntered = !(profileAView.name.text?.isEmpty ?? true)
        let isAgeEntered = !(profileAView.year.text?.isEmpty ?? true)
        let isWeightEntered = !(profileAView.weight.text?.isEmpty ?? true)
        let isKcalEntered = !(profileAView.kcal.text?.isEmpty ?? true)

        return isGenderSelected && isNameEntered && isAgeEntered && isWeightEntered && isKcalEntered
    }
    
    func setupTextFieldDelegate() {
        profileAView.name.delegate = self
        profileAView.year.delegate = self
        profileAView.weight.delegate = self
        profileAView.kcal.delegate = self
    }
    
    func configure(with profile: ProfileEntity, gender: Gender) {
        if let profileImageString = profile.profileImage,
           let profileImage = UIImage(base64String: profileImageString) {
            profileAView.profileImage.image = profileImage
        } else {
            profileAView.profileImage.image = UIImage(systemName: "cat")
        }
        
        self.genderType = gender
        profileAView.selectGender(gender: Gender(rawValue: gender.rawValue) ?? .female)
        profileAView.name.text = profile.name
        profileAView.year.text = String(profile.birthYear)
        profileAView.month.text = String(profile.birthMonth)
        profileAView.weight.text = String(profile.weight)

        profileAView.kcal.text = String(profile.kcal)
    }
}

extension ProfileAViewController {
    func requestPhotoLibraryPermission(completion: @escaping (Bool) -> Void) {
        let status = PHPhotoLibrary.authorizationStatus(for: .readWrite)
        
        switch status {
        case .authorized:
            completion(true)
        case .notDetermined, .denied, .restricted:
            PHPhotoLibrary.requestAuthorization(for: .readWrite) { newStatus in
                DispatchQueue.main.async {
                    completion(newStatus == .authorized)
                }
            }
        default:
            completion(false)
        }
    }
    
    func requestCameraPermission(completion: @escaping (Bool) -> Void) {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        
        switch status {
        case .authorized:
            completion(true)
        case .notDetermined, .denied, .restricted:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                DispatchQueue.main.async {
                    completion(granted)
                }
            }
        default:
            completion(false)
        }
    }
    
    func showPermissionAlert(message: String) {
        let alertController = UIAlertController(title: "사진 접근 권한이 없습니다. 설정으로 이동하여 권한 설정을 해주세요.", message: message, preferredStyle: .alert)
        
        let settingsAction = UIAlertAction(title: "설정으로 이동", style: .default) { _ in
            if let appSettings = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(appSettings, options: [:], completionHandler: nil)
            }
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alertController.addAction(settingsAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
}

// MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate

extension ProfileAViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func setupButtonTapped() {
        profileAView.editButton.addTarget(self, action: #selector(alertPickerView), for: .touchUpInside)
        
        profileAView.maleButton.addTarget(self, action: #selector(maleButtonTapped), for: .touchUpInside)
        
        profileAView.femaleButton.addTarget(self, action: #selector(femaleButtonTapped), for: .touchUpInside)
    }
    
    @objc func alertPickerView() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let albumAction = UIAlertAction(title: "앨범에서 선택", style: .default) { _ in
            self.checkLibraryPermissionStatus()
        }
        alertController.addAction(albumAction)
        
        let cameraAction = UIAlertAction(title: "카메라로 촬영", style: .default) { _ in
            self.checkCameraPermissionStatus()
        }
        alertController.addAction(cameraAction)
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func checkLibraryPermissionStatus() {
        requestPhotoLibraryPermission { granted in
            if granted {
                self.openLibrary()
            } else {
                self.showPermissionAlert(message: "프로필 사진등록, 편집을 위해 앨범 접근 권한이 필요합니다.")
            }
        }
    }
    
    func checkCameraPermissionStatus() {
        requestCameraPermission { granted in
            if granted {
                self.openCamera()
            } else {
                self.showPermissionAlert(message: "프로필 사진등록, 편집을 위해 카메라 접근 권한이 필요합니다.")
            }
        }
    }

    func openLibrary() {
        DispatchQueue.main.async {
            let imagePickerController = UIImagePickerController()
            
            imagePickerController.delegate = self
            imagePickerController.sourceType = .photoLibrary
            imagePickerController.allowsEditing = true
            
            self.present(imagePickerController, animated: true, completion: nil)
        }
    }
    
    func openCamera() {
        DispatchQueue.main.async {
            guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
                return
            }
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = .camera
            
            self.present(picker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.editedImage] as? UIImage {
            profileAView.profileImage.image = pickedImage
        } else if let pickedImage = info[.originalImage] as? UIImage {
            profileAView.profileImage.image = pickedImage
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true)
    }
    
    @objc func maleButtonTapped() {
        genderType = .male
        profileAView.isGenderTapped = true
        profileAView.selectGender(gender: Gender.male)
    }
    
    @objc func femaleButtonTapped() {
        genderType = .female
        profileAView.isGenderTapped = true
        profileAView.selectGender(gender: Gender.female)
    }
}

// MARK: - UITextFieldDelegate

extension ProfileAViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let profile = profileData else { return }

        switch textField {
        case profileAView.name:
            profile.name = textField.text ?? ""
            
        case profileAView.year:
            if let birthYearText = textField.text,
               let year = Int(birthYearText) {
                profile.birthYear = Int16(year)
            }
            
        case profileAView.month:
            if let birthMonthText = textField.text,
               let month = Int(birthMonthText) {
                profile.birthMonth = Int16(month)
            }
            
        case profileAView.weight:
            if let weightText = textField.text, let weight = Float(weightText) {
                profile.weight = weight
            }
            
        case profileAView.kcal:
            if let kcalText = textField.text,
                let kcal = Int(kcalText) {
                profile.kcal = Int16(kcal)
            }
            
        default:
            break
        }
    }
}
