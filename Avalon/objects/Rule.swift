//
//  Rule.swift
//  Avalon
//
//  Created by Zairah Mae J Ylagan on 30/03/2018.
//  Copyright © 2018 Zairah Mae J Ylagan. All rights reserved.
//

import Foundation

enum GameRuleError: Error {
    case invalidPlayerCount,
    characterNotFound
}

class Rule: NSObject {
    var goodCount: Int;
    var evilCount: Int;
    var quests: Array<Quest>
    var characters: [String: AvalonCharacter]
    
    init(goodCount: Int, evilCount: Int, quests: [Quest], characters: [String: AvalonCharacter]) {
        self.goodCount = goodCount
        self.evilCount = evilCount
        self.quests = quests;
        self.characters = characters;
    }
    private func _filterCharacters(type: CharType) -> (String, AvalonCharacter) -> Bool {
        func filter(key: String, char: AvalonCharacter) -> Bool {
            return char.type == type;
        }
        return filter;
    }
    
    func getGoodCharacters() -> [String: AvalonCharacter] {
        return self.characters.filter(_filterCharacters(type: CharType.Good));
    }
    
    func getEvilCharacters() -> [String: AvalonCharacter] {
        return self.characters.filter(_filterCharacters(type: CharType.Evil));
    }
    
    static func GetRule(playerCount: Int) throws -> Rule {
        let maxPlayerCount = try! Reader.GetMaxPlayerCount();
        let minPlayerCount = try! Reader.GetMinPlayerCount();
        
        if(maxPlayerCount < playerCount && minPlayerCount > playerCount) {
            throw GameRuleError.invalidPlayerCount
        }
        
        let goodEvilCount = try! Reader.GetGoodEvilCount(playerCount: playerCount);
        return Rule(
            goodCount: goodEvilCount["goodCount"]!,
            evilCount: goodEvilCount["evilCount"]!,
            quests: try! Reader.GetQuests(playerCount: playerCount),
            characters: try! Reader.GetCharacters()
        )
    }
    
    func getCharacterById(id: String) throws -> AvalonCharacter {
        func filter(a_char: AvalonCharacter) -> Bool { return a_char.id == id }
        let char_array = Array(self.characters.values).filter(filter);
        if char_array.count == 1 {
            return char_array[0]
        }
        throw GameRuleError.characterNotFound;
    }
    
    
}
