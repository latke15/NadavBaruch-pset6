//
//  ViewController.swift
//  NadavBaruch-pset6
//
//  Created by Nadav Baruch on 06-12-16.
//  Copyright © 2016 Nadav Baruch. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var countryCodeInput: UITextField!
    @IBOutlet weak var cityInput: UITextField!
    
//    var shabbatInfo = [String: AnyObject]()
    var result: shabbat?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func checkShabbat(_ sender: Any) {
        if countryCodeInput.text == "" || cityInput.text == "" {
            showAlertView(title: "Attention!", withDescription: "You forgot your input!", buttonText: "Understood!")
        }
        
        let countryCode = countryCodeInput.text
        let city = cityInput.text
        
        let url = URL(string: "https://www.hebcal.com/shabbat/?cfg=json&city=" + countryCode! + "-" + city! + "&m=50")
//        print(url!)
//        print(shabbat())
        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
            guard error == nil else {
                self.showAlertView(title:"Attention!", withDescription:"Error occured!", buttonText:"Understood!")
                print("error!")
                return
            }
            guard let data = data else {
                self.showAlertView(title:"Attention!", withDescription:"No data could be found!", buttonText:"Understood!")
                print("Data is empty")
                return
            }
            
            // Get status code
            let httpResponse = response as! HTTPURLResponse
            if httpResponse.statusCode == 400{
                self.showAlertView(title:"Attention!", withDescription:"Bad request, please contact the administrator.", buttonText:"Understood!")
            }
            if httpResponse.statusCode == 500{
                self.showAlertView(title:"Attention!", withDescription:"Internal server error, please contact the administrator.", buttonText:"Understood!")
            }
            
            if httpResponse.statusCode == 200{
                print("Succeed to maintain data!")
            }
            
            
            let myJSON = try! JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String : Any]
            //print(myJSON!)
            let shabbat = parse(dict: myJSON! as! [String : Any]) as? shabbat
            if let items = myJSON!["items"] as? [[String: AnyObject]] {
                if let title = items[0] as? [[String : AnyObject]]{
                    for row in title{
                        let candle = row["title"] as! [[String : AnyObject]]
                            print(candle)
                    }
                }
            }
//            let items = dict?["items"]
//            print(items[0]["date"])
//                if let candleLighting = items["title"] {
//                    result.candleLighting = candleLighting as! String
//                    print(candleLighting)
            
            
            DispatchQueue.main.async {
//                self.shabbatInfo = dict as! [String : AnyObject]
                self.performSegue(withIdentifier: "secondVCID", sender: shabbat!)
            }
            
        }
        task.resume()
    }
    
    // Show an alert
    func showAlertView(title: String, withDescription description: String, buttonText text: String) {
        let alertController = UIAlertController(title: title, message: description, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: text, style: .default, handler: nil)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
    
    // segue contents to the rawtext variable in the the next view
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // check if we go to 2nd VC
        if segue.identifier == "secondVCID" {
            if let destination = segue.destination as? SecondViewController {
                destination.result = sender as? shabbat
            }
        }


}
}
