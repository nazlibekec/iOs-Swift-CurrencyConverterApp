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
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, Any>
                        
                // 3) Parsing & JSON Serialization
                        
                        //ASYNC
                        DispatchQueue.main.async {
                            if let rates = jsonResponse["rates"] as? [String :  Any] {
                    
                                if let turkish = rates["TRY"] as? Double {
                                    self.tryLabel.text = "TRY: \(turkish)"
                                }
                                if let usd = rates["USD"] as? Double {
                                    self.usdLabel.text = "USD: \(usd)"
                                }
                                if let aud = rates["AUD"] as? Double {
                                    self.audLabel.text = "AUD: \(aud)"
                                }
                                if let eur = rates["EUR"] as? Double {
                                    self.eurLabel.text = "EUR: \(eur)"
                                }
                                if let rub = rates["RUB"] as? Double {
                                    self.rubLabel.text = "RUB: \(rub)"
                                }
                                if let gbp = rates["GBP"] as? Double {
                                    self.gbpLabel.text = "GBP: \(gbp)"
                                }
                            }
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
