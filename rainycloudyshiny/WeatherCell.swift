//
//  WeatherCell.swift
//  rainycloudyshiny
//
//  Created by Sabrina Fletcher on 8/25/17.
//  Copyright © 2017 Sabrina Fletcher. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {
    
    
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var dayLBL: UILabel!
    @IBOutlet weak var weatherType: UILabel!
    @IBOutlet weak var highTemp: UILabel!
    @IBOutlet weak var lowTemp: UILabel!

    func configureCell(forecast:Forecast){
        lowTemp.text = "\(forecast.lowTemp)"
        highTemp.text = "\(forecast.highTemp)"
        weatherType.text = forecast.weatherType
        dayLBL.text = forecast.date
        weatherIcon.image = UIImage(named: forecast.weatherType)
    }

}
