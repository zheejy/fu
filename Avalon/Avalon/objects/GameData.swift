//
//  GameData.swift
//  Avalon
//
//  Created by Zairah Mae J Ylagan on 29/03/2018.
//  Copyright © 2018 Zairah Mae J Ylagan. All rights reserved.
//

import Foundation

var GAME_DATA_INSTANCE: GameData?;

enum GameStatus { case Waiting, Started }
enum GameDataError: Error {
    case maxCountError,
    requiredCharacterError(name: String),
    characterNoFound,
    playerNotFound
}

class GameData: NSObject {
    public let playerCount: Int;
    public var status: GameStatus = GameStatus.Waiting;
    public var characters = [AvalonCharacter]();
    private var _rule: Rule?;
    public var rule: Rule {
        get {
            if((self._rule) == nil) {
                self._rule = try! Rule.GetRule(playerCount: self.playerCount)
            }
            return self._rule!;
        }
    }
    
    public var players = [Player]();
    
    init(playerCount: Int) {
        self.playerCount = playerCount;
        super.init();
        
        for (_, character) in self.rule.characters {

            if(character.required) {
                self.characters.append(character)
            }
        }
    }
    
    func addCharacter(id: String) throws {
        let character: AvalonCharacter = try! self.rule.getCharacterById(id: id)
        func filterChar(type: CharType) -> Array<AvalonCharacter> {
            return self.characters.filter({ (a_char) -> Bool in
                return a_char.type == type
            })
        }
        switch character.type {
            case CharType.Evil:
                if(self.rule.evilCount <= filterChar(type: CharType.Evil).count) {
                    throw GameDataError.maxCountError
                }
            case CharType.Good:
                if(self.rule.goodCount <= filterChar(type: CharType.Good).count) {
                    throw GameDataError.maxCountError
                }
        }
        self.characters.append(character)
    }

    func removeCharacter(id: String) throws {
        func whereCB(a_character: AvalonCharacter) -> Bool {
            return a_character.id == id
        }
        if let index = self.characters.index(where: whereCB) {
            let a_char = self.characters[index];
            if(a_char.required) {
                throw GameDataError.requiredCharacterError(name: a_char.name)
            }
            self.characters.remove(at: index)
        }
    }
    
    func isInCharacters(a_char: AvalonCharacter) -> Bool {
        func whereCB(a_character: AvalonCharacter) -> Bool {
            return a_character.id == a_char.id
        }
        if self.characters.index(where: whereCB) != nil {
            return true;
        } else {
            return false;
        }
    }
    
    func getCharacterById(id: String) throws -> AvalonCharacter {
        if let index = self.characters.index(where: { (char) -> Bool in return char.id == id }) {
            return self.characters[index];
        }
        throw GameDataError.characterNoFound
    }
    
    func addPlayer(name: String) {
        self.players.append(Player(name: name));
    }
    
    func setPlayerCharacter(playerId: String, a_charId: String) {
        let char = try? getCharacterById(id: a_charId);
        self.players = self.players.map { (player) -> Player in
            if(player.id == playerId) {
                player.character = char;
                return player;
            }
            return player;
        }
    }
    
    func getPlayerById(id: String) throws -> Player {
        if let index = self.players.index(where: { (char) -> Bool in return char.id == id }) {
            return self.players[index];
        }
        throw GameDataError.playerNotFound
    }
    
    static func GetGameData(playerCount: Int) -> GameData {
        if (GAME_DATA_INSTANCE == nil) {
            GAME_DATA_INSTANCE = GameData(playerCount: playerCount);
        }
        return GAME_DATA_INSTANCE!;
    }
    
    static func GetGameData() -> GameData {
        return GAME_DATA_INSTANCE!;
    }
    
}
