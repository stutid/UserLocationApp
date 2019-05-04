//
//  MapViewModel.swift
//  locationApp
//
//  Created by admin on 02/08/18.
//  Copyright © 2018 iOS. All rights reserved.
//

import Foundation
import CoreLocation
import Alamofire
import SwiftyJSON

class MapViewModel {
    
    let WEATHER_URL = "https://samples.openweathermap.org/data/2.5/weather?"
    let APP_ID = "20eb6c47522cfde9c342b1aece2ea94c"
    private var modelObj = CallOutViewModel()
    
    func getWeatherData(for location: CLLocation) {
        let myStrLatitude = String(location.coordinate.latitude)
        let myStrLongitude = String(location.coordinate.longitude)
        let params = ["lat": myStrLatitude, "lon": myStrLongitude, "appid": APP_ID]
        Alamofire.request(WEATHER_URL, method: .get, parameters: params).responseJSON { (response) in
            if response.result.isSuccess {
                let weatherJSON: JSON = JSON(response.result.value!)
                print(weatherJSON)
                self.getWeatherInformation(from: weatherJSON)
            }
            else {
                print(response.result.error!)
                print("No Internet connection")
            }
        }
    }
    
    func getAddressFromCoordinates(location: CLLocation) {
        CLGeocoder().reverseGeocodeLocation(location) { (placemarks, err) -> Void in
            if let p = placemarks {
                let address = p[0].name
                self.modelObj.address = address
            }
        }
    }
    
    func getCallOutValues() -> CallOutViewModel {
        return modelObj
    }
    
    private func getWeatherInformation(from json: JSON) {
        if let weatherInfo = json["weather"][0]["main"].string {
            modelObj.weather = weatherInfo
        }
        else {
            print("No data found")
        }
    }
}


struct CallOutViewModel {
    var name: String = "John"
    var address: String?
    var date: String = DateFormatter.localizedString(from: Date(), dateStyle: .medium, timeStyle: .short)
    var weather: String?
}
