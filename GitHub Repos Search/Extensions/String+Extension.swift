//
//  String+Extension.swift
//  GitHub Repos Search
//
//  Created by Andrew Emad on 10/11/2022.
//

import Foundation

extension String {
    var toURl : URL? {
        return URL(string: self)
    }
}
