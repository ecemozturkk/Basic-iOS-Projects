//
//  ViewController.swift
//  GesturePractice
//
//  Created by Ecem Öztürk on 1.03.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var myLabel: UILabel!
    
    var isMorty = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //ImageView'a tıklandığında image değişsin
        imageView.isUserInteractionEnabled = true //Kullanıcı üstüne tıklayabilsin
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(changePic))
        imageView.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func changePic(){
        if isMorty == true {
            imageView.image = UIImage(named: "Rick")
            myLabel.text = "Rick"
            isMorty = false
        } else {
            imageView.image = UIImage(named: "Morty")
            myLabel.text = "Morty"
            isMorty = true
        }
    }
}

