//
//  AvalonCharacter.swift
//  Avalon
//
//  Created by Zairah Mae J Ylagan on 29/03/2018.
//  Copyright © 2018 Zairah Mae J Ylagan. All rights reserved.
//

import Foundation

enum CharType {
    case Good, Evil
}

class AvalonCharacter: NSObject {
    let id = NSUUID().uuidString
    let name: String;
    let type: CharType;
    let power: String?;
    let required: Bool;
    let imageName: String;
    
    init(name: String, type: CharType, required: Bool, imageName: String, power: String?) {
        self.name = name;
        self.type = type;
        self.power = power;
        self.required = required;
        self.imageName = imageName;
    }
}
