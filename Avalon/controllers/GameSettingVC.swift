//
//  SelectCharacterViewController.swift
//  Avalon
//
//  Created by Zairah Mae J Ylagan on 29/03/2018.
//  Copyright © 2018 Zairah Mae J Ylagan. All rights reserved.
//

import Foundation
import UIKit

class GameSettingVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    var charType: CharType = CharType.Good;
    @IBOutlet weak var btn_goodType: UIButton!
    @IBOutlet weak var btn_evilType: UIButton!
    @IBOutlet weak var btn_next: UIButton!
    @IBOutlet weak var iview_type: UIImageView!
    @IBOutlet weak var cview_character: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cview_character.backgroundColor = UIColor.clear;
    }
    
    override var prefersStatusBarHidden: Bool {
        return true;
    }
    
    func showModal(message: String) {
        let modalVC = self.storyboard?.instantiateViewController(withIdentifier: "modalVC") as! ModalVC;
        modalVC.message = message;
        self.present(modalVC, animated: true, completion: nil)
    }
    
    @IBAction func charType_touchup_inside(_ sender: UIButton) {
        if(sender == btn_goodType) {
            self.charType = CharType.Good
            self.iview_type.image = UIImage(named: "loyalservant")
        } else {
            self.charType = CharType.Evil
            self.iview_type.image = UIImage(named: "minions")
        }
        
        self.cview_character.reloadData();
    }
    
    @IBAction func btn_next_touchup_inside(_ sender: Any) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let gameData = GameData.GetGameData();
        switch charType {
            case CharType.Good:
                return gameData.rule.getGoodCharacters().count
            case CharType.Evil:
                return gameData.rule.getEvilCharacters().count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "characterVCCell", for: indexPath) as! CharacterCVCell
        let gameData = GameData.GetGameData();
        var characters = [String: AvalonCharacter]();
        switch charType {
            case CharType.Good:
                characters = gameData.rule.getGoodCharacters()
            case CharType.Evil:
                characters = gameData.rule.getEvilCharacters()
        }
        let name = Array(characters.keys)[indexPath.row];
        let a_character = characters[name] as! AvalonCharacter;
        cell.displayContent(name: name, a_char: a_character, included: gameData.isInCharacters(a_char: a_character))
        
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CharacterCVCell;
        let gameData = GameData.GetGameData();
        if let id = cell.id {
            do {
                let selected = gameData.isInCharacters(a_char: cell.character!)
                if(selected) {
                    try gameData.removeCharacter(id: cell.id!)
                } else {
                    try gameData.addCharacter(id: id)
                }
                cell.updateStatus(included: !selected)
                btn_next.isHidden = gameData.characters.count != gameData.playerCount
            } catch GameDataError.maxCountError {
                self.showModal(message: "Max character count.")
            } catch GameDataError.requiredCharacterError(let name) {
                self.showModal(message: "\(name) a is required character")
            } catch {
                self.showModal(message: "Unexpected error: \(error).")
            }

        }
    }
    
}
