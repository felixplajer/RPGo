//
//  BattleViewController.swift
//  RPGo
//
//  Created by Felix Plajer on 12/11/17.
//  Copyright © 2017 Felix Plajer. All rights reserved.
//

import UIKit

class BattleViewController: ViewController {
    
    
    @IBOutlet weak var monsterProgress: UIProgressView!
    @IBOutlet weak var playerProgress: UIProgressView!
    @IBOutlet weak var attackButton: UIButton!
    @IBOutlet weak var defendButton: UIButton!
    @IBOutlet weak var healButton: UIButton!
    @IBOutlet weak var forfeitButton: UIButton!
    
    var playerHealth = 0
    var playerDefense = 0
    var monsterHealth = Int(arc4random_uniform(10) + 25)
    var monsterMax = 0
    var monsterAttack = Int(arc4random_uniform(6) + 3)
    var monsterDefense = Int(arc4random_uniform(3) + 0)
    var monsterSpeed = Int(arc4random_uniform(3) + 2)
    
    var battleOver: Bool {
        if monsterHealth <= 0 || playerHealth <= 0 {
            return true
        }
        return false
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        monsterMax = monsterHealth
        playerHealth = player.health
        playerDefense = player.defense
        
        update()
        
        if monsterSpeed > player.speed {
            self.monsterTurn()
        } else {
            self.playerTurn()
        }
    }
    
    func endBattle() {
        if monsterHealth <= 0 {
            win()
        } else {
            lose()
        }
    }
    
    func win() {
        let exp = Int(arc4random_uniform(15) + 10)
        player.exp += Double(exp)
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "You Won!", message: "You got \(exp) exp", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "won"), style: .`default`, handler: { _ in
                NSLog("won")
                self.player.save()
                self.performSegue(withIdentifier: "battleUnwind", sender: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func lose() {
        let exp = Int(arc4random_uniform(15) + 10)
        if Double(exp) > player.exp {
            player.exp = 0
        } else {
            player.exp -= Double(exp)
        }
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "You Lost!", message: "You lost \(exp) exp", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "lost"), style: .`default`, handler: { _ in
                NSLog("lost")
                self.player.save()
                self.performSegue(withIdentifier: "battleUnwind", sender: nil)
            }))

            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func playerForfeit(_ sender: Any) {
        disableButtons()
        playerHealth = 0
        endBattle()
    }
    
    @IBAction func playerHeal(_ sender: Any) {
        disableButtons()
        playerHealth += Int(arc4random_uniform(15) + 6)
        if playerHealth > player.health {
            playerHealth = player.health
        }
        update()
        monsterTurn()
    }
    
    @IBAction func playerAttack(_ sender: Any) {
        disableButtons()
        monsterHealth -= player.effectiveAttack - monsterDefense
        NSLog("\(playerHealth) \(monsterHealth)")
        if battleOver {
            endBattle()
            return
        }
        update()
        usleep(300000)
        monsterTurn()
    }
    
    @IBAction func playerDefend(_ sender: Any) {
        disableButtons()
        playerDefense += Int(arc4random_uniform(2) + 1)
        monsterTurn()
    }
    
    
    func monsterTurn() {
        NSLog("\n\n\n\n\n MONSTER TURN \n\n\n\n\n")
        usleep(300000)
        disableButtons()
        playerHealth -= monsterAttack - playerDefense
        update()
        NSLog("\(playerHealth) \(monsterHealth)")
        if battleOver {
            endBattle()
            return
        }
        usleep(300000)
        playerTurn()
    }
    
    func playerTurn() {
        NSLog("\n\n\n\n\n PLAYER TURN \n\n\n\n\n")
        enableButtons()
    }
    
    func disableButtons() {
        attackButton.isEnabled = false;
        defendButton.isEnabled = false;
        defendButton.isEnabled = false;
        forfeitButton.isEnabled = false;
    }
    
    func enableButtons() {
        attackButton.isEnabled = true;
        defendButton.isEnabled = true;
        defendButton.isEnabled = true;
        forfeitButton.isEnabled = true;
    }
    
    func update() {
        playerProgress.progress = Float(playerHealth) / Float(player.health)
        monsterProgress.progress = Float(monsterHealth) / Float(monsterMax)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        player.save()
        if let dest = segue.destination as? ViewController {
            dest.player = player
        }
    }

}
