//
//  CurrentWeather.swift
//  rainycloudyshiny
//
//  Created by Sabrina Fletcher on 8/25/17.
//  Copyright © 2017 Sabrina Fletcher. All rights reserved.
//

import Foundation
import Alamofire

class CurrentWeather{
    var _cityName: String!
    var _date: String!
    var _weatherType: String!
    var _currentTemp: Double!
    
    var cityName: String{
        if _cityName == nil{
            _cityName = ""
        }
        return _cityName
    }
    
    var date: String{
        if _date == nil{
            _date = ""
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        let currentDate = dateFormatter.string(from: Date())
        self._date = "Today, \(currentDate)"
        return _date
        
    }
    
    var weatherType: String{
        if _weatherType == nil{
            _weatherType = ""
        }
        return _weatherType
    }
    
    var currentTemp: Double{
        if _currentTemp == nil{
            _currentTemp = 0.0
        }
        return _currentTemp
    }
    
    
    func downloadWeatherDetails(completed: @escaping DownloadComplete){
        let session = URLSession.shared
        let weatherURL = URL(string: CURRENT_WEATHER_URL)
        
        let task = session.dataTask(with: weatherURL!, completionHandler: { (data, response, error) in
            if error != nil{
                print(error as Any)
            } else{
                if let urlContent = data{
                    do{
                        let parsedData = try JSONSerialization.jsonObject(with: urlContent) as Any
                        if let dict = parsedData as? Dictionary<String, AnyObject>{
                            if let name = dict["name"] as? String{
                                self._cityName = name.capitalized
                                print(self._cityName)
                            }
                            if let weather = dict["weather"] as? [Dictionary<String, AnyObject>] {
                                if let main = weather[0]["main"] as? String{
                                    self._weatherType = main.capitalized
                                    print(self.weatherType)
                                }
                            }
                            
                            if let main = dict["main"] as? Dictionary<String, AnyObject> {
                                if let temp = main["temp"] as? Double{
                                    let kToFPreDivide = (temp * (9/5) - 459.67)
                                    let currentTemp = Double(round(10 * kToFPreDivide/10))
                                    self._currentTemp = currentTemp
                                    print(self._currentTemp)
                                }
                            }                            
                        }
                    }catch let error as NSError{
                        print(error)
                    }
                }
            }
        })
        task.resume()
        completed()
    }
    
}


/*
 
 self._cityName = name.capitalized
 print(self._cityName)
 }
 if let weather = parsedData?["weather"] as? [Dictionary<String,Any>]{
 if let main = weather[0]["main"] as? String{
 self._weatherType = main.capitalized
 print(self._weatherType)
 }
 }
 
 if let main = parsedData?["main"] as? Dictionary<String,Any> {
 if let temp = main["temp"]  as? Double{
 let kToFPreDivide = (temp * (9/5) - 459.67)
 let currentTemp = Double(round(10 * kToFPreDivide/10))
 self._currentTemp = currentTemp
 print(self._currentTemp)
 }
 }
 }catch let error as NSError{
 print(error)
 */
 
    /*func downloadWeatherDetails(completed: @escaping DownloadComplete){
        let currentWeatherURL = URL(string: CURRENT_WEATHER_URL)!
        Alamofire.request(currentWeatherURL).responseJSON { response in
            let result = response.result
 
            if let dict = result.value as? Dictionary<String, AnyObject>{
 
                if let name = dict["name"] as? String{
                    self._cityName = name.capitalized
                    print(self._cityName)
                }
                
                if let weather = dict["weather"] as? [Dictionary<String, AnyObject>] {
                    if let main = weather[0]["main"] as? String{
                        self._weatherType = main.capitalized
                        print(self.weatherType)
                    }
                }
                
                if let main = dict["main"] as? Dictionary<String, AnyObject> {
                    if let temp = main["temp"] as? Double{
                        let kToFPreDivide = (temp * (9/5) - 459.67)
                        let currentTemp = Double(round(10 * kToFPreDivide/10))
                        self._currentTemp = currentTemp
                        print(self._currentTemp)
                    }
                }
            }
            completed()
        }
    }*/
    


