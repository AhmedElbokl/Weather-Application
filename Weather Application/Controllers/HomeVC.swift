//
//  ViewController.swift
//  Weather Application
//
//  Created by ReMoSTos on 07/10/2023.
//

import UIKit
import Alamofire


class HomeVC: UIViewController {

    @IBOutlet weak var loadingActivityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    var cityId = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(handelNotification), name: NSNotification.Name("selectedCity"), object: nil)
        // Do any additional setup after loading the view.
        requestApi()
        
    }

    @objc func handelNotification(notification: Notification) {
        if let city = notification.userInfo?["selectedCity"] as? City {
            cityNameLabel.text = city.name
            cityId = city.id
        }
        requestApi()
    }
    
    // function for handel API requests
    func requestApi(){
        let params = ["id": cityId, "appid": "7fe71fb7ef0a7d7591d6939a0f1d9b4a"]
        loadingActivityIndicatorView.isHidden = false
        loadingActivityIndicatorView.startAnimating()
        AF.request("https://api.openweathermap.org/data/2.5/weather", parameters: params, encoder: URLEncodedFormParameterEncoder.default).responseJSON { response in
            if let result = response.value {
                let jsonResult = result as! NSDictionary
                if let main = jsonResult["main"] as? NSDictionary {
                    let kelvinTemp = main["temp"] as! Double
                    let celsiusTemp = round(kelvinTemp - 272.15)
                    let pressure = main["pressure"] as! Double
                    let humidity = main["humidity"] as! Double
                    
                    self.loadingActivityIndicatorView.stopAnimating()
                    
                    self.tempLabel.text = String("\(celsiusTemp)°C")
                    self.pressureLabel.text = String("\(pressure)°P")
                    self.humidityLabel.text = String("\(humidity)°")
                
                    
                }
            }
        }
    }
}

