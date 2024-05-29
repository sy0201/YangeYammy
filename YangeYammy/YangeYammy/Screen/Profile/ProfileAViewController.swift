//
//  ProfileAViewController.swift
//  YangeYammy
//
//  Created by siyeon park on 4/22/24.
//

import UIKit
import Photos

final class ProfileAViewController: UIViewController {
    let profileDataManager = ProfileDataManager.shared
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
        let isAgeEntered = !(profileAView.age.text?.isEmpty ?? true)
        let isWeightEntered = !(profileAView.weight.text?.isEmpty ?? true)
        let isKcalEntered = !(profileAView.kcal.text?.isEmpty ?? true)
        
        print("isGenderSelected \(isGenderSelected)")
        print("isNameEntered \(isNameEntered)")
        print("isAgeEntered \(isAgeEntered)")
        print("isWeightEntered \(isWeightEntered)")
        print("isKcalEntered \(isKcalEntered)")

        print("ProfileAAInfoComplete \(isNameEntered && isAgeEntered && isGenderSelected && isKcalEntered)")
        return isGenderSelected && isNameEntered && isAgeEntered && isWeightEntered && isKcalEntered
    }
    
    func setupTextFieldDelegate() {
        profileAView.name.delegate = self
        profileAView.age.delegate = self
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
        profileAView.age.text = profile.age
        profileAView.weight.text = String(profile.weight)
        profileAView.kcal.text = String(profile.kcal)
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
            self.openLibrary()
        }
        
        alertController.addAction(albumAction)
        
        let cameraAction = UIAlertAction(title: "카메라로 촬영", style: .default) { _ in
            self.openCamera()
        }
        
        alertController.addAction(cameraAction)
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func openLibrary(sourceType: UIImagePickerController.SourceType) {
        guard UIImagePickerController.isSourceTypeAvailable(sourceType) else {
            return
        }
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = sourceType

        present(imagePicker, animated: true, completion: nil)
    }
    
    func openLibrary() {
        let imagePickerController = UIImagePickerController()
        
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.allowsEditing = true
        
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func openCamera() {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            return
        }
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .camera
        
        present(picker, animated: true, completion: nil)
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
        switch textField {
        case profileAView.name:
            profileDataManager.saveProfileDetail(name: textField.text ?? "")
            
        case profileAView.age:
            profileDataManager.saveProfileDetail(age: textField.text ?? "")
            
        case profileAView.weight:
            if let weightText = textField.text, let weight = Float(weightText) {
                profileDataManager.saveProfileDetail(weight: weight)
            }
            
        case profileAView.kcal:
            if let kcalText = textField.text, let kcal = Int(kcalText) {
                profileDataManager.saveProfileDetail(kcal: kcal)
            }
            
        default:
            break
        }
    }
}
