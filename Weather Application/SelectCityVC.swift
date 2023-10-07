//
//  SelectCityVC.swift
//  Weather Application
//
//  Created by ReMoSTos on 07/10/2023.
//

import UIKit

class SelectCityVC: UIViewController {
    
    var selectedCity: City?
    var cities: [City] = [City(name: "Alex", id: "361058"), City(name: "Sharm-Elshikh", id: "349340"), City(name: "Dahab", id: "358245"), City(name: "Safaga", id: "358620"), City(name: "Hurgada", id: "361291"), City(name: "Al-alamen", id: "361612"), City(name: "Red-sea", id: "361468"), City(name: "Al-arish", id: "361546"),
        City(name: "Marsa-Matrouh", id: "352733")]
    
    @IBOutlet weak var cityPickerView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        cityPickerView.dataSource = self
        cityPickerView.delegate = self
    }
   
    @IBAction func selectCityBtnClicked(_ sender: Any) {
        if let city = selectedCity {
            NotificationCenter.default.post(name: NSNotification.Name("selectedCity"), object: nil, userInfo: ["selectedCity" : city])
        }
        dismiss(animated: true)
    }
}

//MARK: extension for pickerView
extension SelectCityVC: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        cities.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        cities[row].name
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCity = cities[row]
        
    }
    
}
