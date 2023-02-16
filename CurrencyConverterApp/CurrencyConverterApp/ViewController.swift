//
//  ViewController.swift
//  CurrencyConverterApp
//
//  Created by Nazlı Bekeç on 16.02.2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tryLabel: UILabel!
    @IBOutlet weak var usdLabel: UILabel!
    @IBOutlet weak var audLabel: UILabel!
    @IBOutlet weak var eurLabel: UILabel!
    @IBOutlet weak var rubLabel: UILabel!
    @IBOutlet weak var gbpLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func getRatesClicked(_ sender: Any) {
    

        // 3) Parsing & JSON Serialization
        
        // 1) Request & Session
        
        let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/CurrencyData/main/currency.json")
        
        let session = URLSession.shared
        
        // Closure
        let task = session.dataTask(with: url!) { data, response, error in
            if error != nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default)
                alert.addAction(okButton)
                self.present(alert, animated: true)
            } else {
                
                // 2) Response & Data
                
                if data != nil {
                    do {
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)
                        
                        //ASYNC
                        
                        DispatchQueue.main.async {
                            print(jsonResponse)
                        }
                        
                    } catch {
                        print("error")
                    }
                    
                }
                
            }
            
        }
        
        task.resume()
    }
    
}


//info:  App Transport Security Setting / Allow Arbitary Loads = YES ile http bağlantılara izin verdik.
