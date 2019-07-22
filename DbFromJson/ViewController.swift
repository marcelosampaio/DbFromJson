//
//  ViewController.swift
//  DbFromJson
//
//  Created by Marcelo Sampaio on 22/07/19.
//  Copyright © 2019 Marcelo Sampaio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    // MARK: - UI Actions
    @IBAction func generateDB(_ sender: Any) {
        let cities = readJSONFromFile(fileName: "cidades")
        print("🎁 cities: \(cities)")
    }
    
    
    // MARK: - Local JSON Reader
    private func readJSONFromFile(fileName: String) -> [City] {
        var cities = [City]()

        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let json = try! JSONSerialization.jsonObject(with: data, options: [])
                let dataArray : NSArray = json as! NSArray
                
                for item in dataArray {
                    let dic = item as! NSDictionary
                    let city = City(dictionary: dic)
                    cities.append(city!)
                }

            } catch {
                // handle error
                print("error: \(error)")
                print("....")
            }
        }
        
        
        return cities
    }
    
}

