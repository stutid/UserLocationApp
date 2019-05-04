//
//  ViewController.swift
//  locationApp
//
//  Created by admin on 01/08/18.
//  Copyright © 2018 iOS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var btnWeatherInformation: UIButton!
    @IBOutlet weak var btnAbout: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        btnWeatherInformation.layer.cornerRadius = 10
        btnWeatherInformation.layer.borderWidth = 1
        btnWeatherInformation.layer.borderColor = UIColor.white.cgColor
        btnAbout.layer.cornerRadius = 10
        btnAbout.layer.borderWidth = 1
        btnAbout.layer.borderColor = UIColor.white.cgColor
    }
    
    @IBAction func btnWeatherInformationClicked(_ sender: UIButton) {
        navigateToMapScreen()
    }
    
    @IBAction func btnAboutClicked(_ sender: Any) {
        openAlert()
    }
    
    func navigateToMapScreen() {
        let mapVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MapViewController")
        self.navigationController?.pushViewController(mapVC, animated: true)
    }
    
    func openAlert() {
        let alertController = UIAlertController(title: "About the App", message: "This is a Weather and Locations App.", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Okay!", style: .default, handler: nil)
        alertController.addAction(alertAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

