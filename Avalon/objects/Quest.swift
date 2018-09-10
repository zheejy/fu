//
//  Quest.swift
//  Avalon
//
//  Created by Zairah Mae J Ylagan on 29/03/2018.
//  Copyright © 2018 Zairah Mae J Ylagan. All rights reserved.
//

import Foundation

enum Quest_Status { case Waiting, Success, Failed }

class Quest: NSObject {
    let name: String;
    let teamCount: Int;
    let failCount: Int;
    let status: Quest_Status = Quest_Status.Waiting;
//    let teamLead: String
    
    init(name: String, teamCount: Int, failCount: Int) {
        self.name = name;
        self.teamCount = teamCount;
        self.failCount = failCount;
        super.init();
    }
}
