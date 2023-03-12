//
//  DetailsVC.swift
//  EnglishWordsList
//
//  Created by Ecem Öztürk on 12.03.2023.
//

import UIKit
import CoreData

class DetailsVC: UIViewController {
    
    
    @IBOutlet weak var wordText: UITextField!
    @IBOutlet weak var meaningTextView: UITextView!
    
    var chosenWord = ""
    var chosenId : UUID?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // eğer seçilen kelime boş değil ise tableview'dan tıklandığında bilgilerini göstermek için CoreData'dan çekmemiz lazım
        if chosenWord != "" {
            //veriyi göstermek için çekmemiz lazım, bunun için ViewController'da selectedWord ve selectedId değişkenlerini oluşturup burada kullanıyoruz
            
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "EnglishWords")
            
            let idString = chosenId?.uuidString
            
            //filtreleme
            fetchRequest.predicate = NSPredicate(format: "id=%@", idString!)
            
            fetchRequest.returnsObjectsAsFaults = false
            
            do {
                let results = try context.fetch(fetchRequest)
                if results.count > 0 {
                    for result in results as! [NSManagedObject] {
                        if let word = result.value(forKey: "words") as? String {
                            wordText.text = word
                        }
                        if let translate = result.value(forKey: "translate") as? String {
                            meaningTextView.text = translate
                        }
                    }
                }
            } catch {
                print("error")
            }
            
            
        } else {
            // boş ise bir yere gitmemeli, bir şey göstermemeli
        }
      
    }
    
    @IBAction func saveButtonClicked(_ sender: Any) {
        // AppDelegate'teki "context"'e ulaşabilmemiz için appdelegate'i bir değişken olarak tanımlamamız gerekiyor
        // UIApplication = aplikasyonun kendisi
        // .shared = UIApplication'dan oluşturulan bir obje
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        //context çağıralacak
        let context = appDelegate.persistentContainer.viewContext
        
        //context'in içine ne konulacağını söyleyelim
        let newWord = NSEntityDescription.insertNewObject(forEntityName: "EnglishWords", into: context)
        
        //Ekleyelim
        newWord.setValue(wordText.text!, forKey: "words")
        newWord.setValue(meaningTextView.text!, forKey: "translate")
        newWord.setValue(UUID(), forKey: "id")
        
        // CoreData'ya veri kaydetmemizi sağlayan fonksiyon(context.save()).AppDelegate dosyasından geliyor. Fakat throws özelliği olduğu için do-try-catch kullanılmalı
        do {
            try context.save()
            print("success")
        } catch {
            print("error")
        }
        
        //diğer viewcontroller'lara mesaj yollamamızı sağlıyor
        //burada NSNotification.Name'e bir mesaj atıyoruz, diğer ViewController'a da bu mesajı alırsa ne yapması gerektiğini belirtiyoruz.
        NotificationCenter.default.post(name: NSNotification.Name("newData"), object: nil) // bütün app'in içine newData diye bir mesaj yollar, bunu ViewController içinde kontrol etmeliyiz. ViewController'daki viewWillApper içinde kontrol edeceğiz.
        
        //save button ile kaydetme yaptıktan sonra bir önceki sayfaya dönülmesi
        self.navigationController?.popViewController(animated: true)
        
    }
    
}
