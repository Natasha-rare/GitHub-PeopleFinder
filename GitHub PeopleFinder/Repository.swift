//
//  Repository.swift
//  GitHub PeopleFinder
//
//  Created by Наталья Автухович on 28.06.2021.
//

import Foundation
import UIKit

class Repository{
    let name: String
    let private_repo: Bool
    let description: String
    let language: String?
    let size: Int
    
    init(name:String, private_repo: Bool, description: String, language: String, size: Int) {
        self.name = name
        self.private_repo = private_repo
        self.description = description
        self.language = language
        self.size = size
    }
}
