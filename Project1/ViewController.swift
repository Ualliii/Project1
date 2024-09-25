//
//  ViewController.swift
//  Project1
//
//  Created by Uali Alman on 25.09.2024.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var getWeatherButton: UIButton!
    @IBOutlet weak var clothingLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
    }


    @IBAction func getWeatherAction(_ sender: Any) {
    
        let urlString = "https://api.open-meteo.com/v1/forecast?latitude=52.52&longitude=13.41&current=temperature_2m"
               let url = URL(string: urlString)!
               let reqest = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: reqest){data, reqest, error in
            if let data, let weather = try? JSONDecoder().decode(WeatherData.self, from: data){
                DispatchQueue.main.async {
                    self.weatherLabel.text = "\(weather.current.temperature2M) °"
                    let temperature = weather.current.temperature2M
                    self.clothingLabel.text = self.getClothingAdvice(for: temperature)
                }
            }else{
                print("Fail!")
            }
        }
        task.resume()
    }
    func getClothingAdvice(for temperature: Double) -> String {
            switch temperature {
            case ..<0:
                return "Очень холодно, наденьте зимнюю куртку, шапку и перчатки."
            case 0..<10:
                return "Прохладно, наденьте пальто или теплую куртку."
            case 10..<20:
                return "Слегка прохладно, наденьте свитер или легкую куртку."
            case 20..<30:
                return "Тепло, можно надеть футболку и легкие штаны."
            case 30...:
                return "Жарко, наденьте шорты и футболку."
            default:
                return "Температура неизвестна, оденьтесь по погоде."
            }
    }
}

