//
//  Player.swift
//  Avalon
//
//  Created by Zairah Mae J Ylagan on 30/03/2018.
//  Copyright © 2018 Zairah Mae J Ylagan. All rights reserved.
//

import Foundation



class Player: NSObject {
    let id = NSUUID().uuidString;
    let name: String;
    var character: AvalonCharacter?;
    var status: String?;
    
    init(name: String) {
        self.name = name
    }

}
