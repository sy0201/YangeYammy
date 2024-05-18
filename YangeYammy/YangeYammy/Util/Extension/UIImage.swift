//
//  UIImage.swift
//  YangeYammy
//
//  Created by siyeon park on 5/16/24.
//

import Foundation
import UIKit

extension UIImage {
    func toBase64() -> String? {
        guard let imageData = self.jpegData(compressionQuality: 1.0) else {
            return nil
        }
        return imageData.base64EncodedString()
    }
}
