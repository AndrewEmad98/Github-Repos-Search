//
//  UIImageView+Extension.swift
//  GitHub Repos Search
//
//  Created by Andrew Emad on 15/11/2022.
//

import Foundation
import UIKit

extension UIImageView {
    func setImage(with url:URL?) {
        self.kf.setImage(with: url)
    }
}
