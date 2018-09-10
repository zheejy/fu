//
//  AvalonFileReader.swift
//  Avalon
//
//  Created by Zairah Mae J Ylagan on 30/03/2018.
//  Copyright © 2018 Zairah Mae J Ylagan. All rights reserved.
//

import Foundation

enum ReaderError: Error {
    case failParsingAvalonInfo, sdg
}

class Reader {
    private static func getInfo() throws -> NSDictionary? {
        if let path = Bundle.main.path(forResource: "AvalonInfo", ofType: "plist") {
            return NSDictionary(contentsOfFile: path)
        }
        throw ReaderError.failParsingAvalonInfo;
    }
    
    static func GetCharacters() throws -> [String: AvalonCharacter] {
        var returnValue = [String: AvalonCharacter]();
        if let dict_avalonInfo = try! Reader.getInfo() {
            let characters = dict_avalonInfo["characters"] as! [String: NSDictionary];
            for(key, value) in characters {
                let name = value["name"] as! String;
                let str_type = value["type"] as! String;
                let required = value["required"] as! Bool;
                let power = value["power"] as? String;
                let type = (str_type == "good") ? CharType.Good:CharType.Evil;
                let avalonChar = AvalonCharacter(name: name, type: type, required: required, imageName: key, power: power);
                returnValue[key] = avalonChar;
            }
            return returnValue
        }
        if(returnValue.isEmpty){
            throw ReaderError.failParsingAvalonInfo
        }
        throw ReaderError.failParsingAvalonInfo
    }
    
    static func GetMinPlayerCount() throws -> Int {
        if let dict_avalonInfo = try! Reader.getInfo() {
            return dict_avalonInfo["minPlayerCount"] as! Int;
        }
        throw ReaderError.failParsingAvalonInfo
    }
    
    static func GetMaxPlayerCount() throws -> Int {
        if let dict_avalonInfo = try! Reader.getInfo() {
            return dict_avalonInfo["maxPlayerCount"] as! Int;
        }
        throw ReaderError.failParsingAvalonInfo
    }
    
    static func GetGoodEvilCount(playerCount: Int) throws -> [String: Int] {
        if let dict_avalonInfo = try! Reader.getInfo() {
            let dict_playersCount = dict_avalonInfo["playerCount"] as! [String: NSDictionary]
            let dict_selectedRule = dict_playersCount[String(playerCount)] as! [String: Any]
            let evilCount = dict_selectedRule["evilCount"] as! Int
            let goodCount = dict_selectedRule["goodCount"] as! Int
            var returnValue = [String: Int]();
            returnValue["goodCount"] = goodCount;
            returnValue["evilCount"] = evilCount;
            return returnValue;
        }
        throw ReaderError.failParsingAvalonInfo;
    }
    
    static func GetQuests(playerCount: Int) throws -> Array<Quest> {
        if let dict_avalonInfo = try! Reader.getInfo() {
            let dict_playersCount = dict_avalonInfo["playerCount"] as! [String: NSDictionary]
            let dict_selectedRule = dict_playersCount[String(playerCount)] as! [String: Any]
            let dict_quests = dict_selectedRule["quest"] as! [String: NSDictionary];
            var set_quest = [Quest]();
            for( name, value ) in dict_quests {
                let teamCount = value["teamCount"] as! Int;
                let failCount = value["failCount"] as! Int;
                let quest = Quest(name: name, teamCount: teamCount, failCount: failCount)
                set_quest.append(quest);
            }
            return set_quest;
            
            
        }
        throw ReaderError.failParsingAvalonInfo;
    }
}
