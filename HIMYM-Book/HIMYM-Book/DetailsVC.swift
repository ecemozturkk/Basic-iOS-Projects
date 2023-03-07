//
//  DetailsVC.swift
//  HIMYM-Book
//
//  Created by Ecem Öztürk on 7.03.2023.
//

import UIKit

class DetailsVC: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var jobLabel: UILabel!
    
    var selectedCharacter : Characters?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = selectedCharacter?.name
        jobLabel.text = selectedCharacter?.job
        imageView.image = selectedCharacter?.image
        
    }

}
