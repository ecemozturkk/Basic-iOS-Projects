//
//  ViewController.swift
//  EnglishWordsList
//
//  Created by Ecem Öztürk on 12.03.2023.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    
    @IBOutlet weak var tableView: UITableView!
    
    var wordArray = [String]()
    var idArray = [UUID]()
    
    var selectedWord = ""
    var selectedId : UUID? // bu verileri almak için didSelectRow ve prepareForSegue kullanıldı en sonda
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //Sağ üst köşeye "+" eklenmesi
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addButtonClicked))
        
        getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //newData mesajı için gözlemci ekliyoruz, newData mesajını gördüğünde getData fonksiyonunu çağıracak
        NotificationCenter.default.addObserver(self, selector: #selector(getData), name: NSNotification.Name(rawValue: "newData"), object: nil)
    }
    
    @objc func getData() {
        //duplicatelerden kaçınmak için
        wordArray.removeAll(keepingCapacity: false)
        idArray.removeAll(keepingCapacity: false)
        
        
        //veriyi çekmek için de AppDelegate'e ve içindeki "context"e ulaşmak lazım
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        //fetch request
        //context.fetch() fonksiyonunu kullanacağız. Bunu kullanırken NSFetchRequest tipinde bir şey oluşturmamız lazım. Bunu yine do-try-catch içinde yapmamız lazım.
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "EnglishWords")
        //işlemlerin hızlı okunmasıyla ilgili bir kod, küçük veri setlerinde çok fark yaratmasa da büyük veri setlerinde hızlandırıcı etkisi var
        fetchRequest.returnsObjectsAsFaults = false
        
        //context.fetch(fetchRequest) => dizi geri döndürür
        // bunu bir döngüye atamamız gerekiyor ki dizi içindeki elemanları ele alabilelim.
        do {
            let results = try context.fetch(fetchRequest) //results bir dizi
            
            //sonuçları tek tek ele almak için
            for result in results as! [NSManagedObject] { //NSManagedObject bir CoreData model objesi. Results'ın elemanlarını CoreData objesi ele almamız lazım ki attributelerini (words, id vs..) buradan çekebilelim.
                if let words = result.value(forKey: "words") as? String {
                    self.wordArray.append(words)
                }
                if let id = result.value(forKey: "id") as? UUID {
                    self.idArray.append(id)
                }
                //yeni veri eklendikten sonra tableview'ın refresh edilmesi
                self.tableView.reloadData()
            }
        } catch {
            
        }
    }
    
    @objc func addButtonClicked() {
        selectedWord = "" // +'ya tıklandıysa mevcut bir görsel seçilmedi anlamında
        performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wordArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        //cell.textLabel?.text = "test"
        var content = cell.defaultContentConfiguration()
        content.text = wordArray[indexPath.row]
        cell.contentConfiguration = content
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsVC" {
            let destinationVC = segue.destination as! DetailsVC
            destinationVC.chosenWord = selectedWord
            destinationVC.chosenId = selectedId
        }
    }
    
    //veriye tıklandığında segue yapıcaz
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedWord = wordArray[indexPath.row]
        selectedId = idArray[indexPath.row]
        performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }


}

