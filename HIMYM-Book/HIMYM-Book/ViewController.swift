//
//  ViewController.swift
//  HIMYM-Book
//
//  Created by Ecem Öztürk on 7.03.2023.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var myCharacters = [Characters]()
    var chosenCharacter : Characters?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.dataSource = self
        tableView.delegate = self
        
        //Character Objects
        let ted = Characters(name: "Ted Mosby", job: "Architect Professor", image: UIImage(named: "TedMosby")!)
        let robin = Characters(name: "Robin Scherbatsky", job: "Television Journalist", image: UIImage(named: "RobinScherbatsky")!)
        let lily = Characters(name: "Lily Aldrin", job: "Art consultant", image: UIImage(named: "LilyAldrin")!)
        let barney = Characters(name: "Barney Stinson", job: "P.L.E.A.S.E", image: UIImage(named: "BarneyStinson")!)
        let marshall = Characters(name: "Marshall Eriksen", job: "Judge", image: UIImage(named: "MarshallEriksen")!)

        myCharacters.append(ted)
        myCharacters.append(robin)
        myCharacters.append(lily)
        myCharacters.append(barney)
        myCharacters.append(marshall)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myCharacters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = myCharacters[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chosenCharacter = myCharacters[indexPath.row]
        self.performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsVC" {
            let destinationVC = segue.destination as! DetailsVC
            destinationVC.selectedCharacter = chosenCharacter
        }
    }


}

