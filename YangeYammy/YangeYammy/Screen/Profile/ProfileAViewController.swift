//
//  ProfileAViewController.swift
//  YangeYammy
//
//  Created by siyeon park on 4/22/24.
//

import UIKit
import Photos

final class ProfileAViewController: UIViewController {
    let profileAView = ProfileAView()
    var imagePicker = UIImagePickerController()
    var imageHandler: (UIImage) -> () = { _ in }

    override func loadView() {
        view = profileAView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtonTapped()
    }
}

// MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate

extension ProfileAViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func setupButtonTapped() {
        print("setupButtonTapped")
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
            print("이 소스 타입은 사용할 수 없습니다.")
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
            print("이 소스 타입은 사용할 수 없습니다.")
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
        profileAView.selectGender(gender: Gender.male)
    }
    
    @objc func femaleButtonTapped() {
        profileAView.selectGender(gender: Gender.female)
    }
}
