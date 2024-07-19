//
//  Resources.swift
//  SkyCast
//
//  Created by Василий Тихонов on 19.07.2024.
//

import Foundation

enum Resources {
    
    enum Strings {
        
        static let weatherTitleText = "Weather Options"
        
        enum TypeOfWeathers {
            static let sunny = "Sunny"
            static let snow  = "Snow"
            static let rain  = "Rain"
            static let night = "Night"
            static let fog   = "Fog"
            static let storm = "Storm"
        }
        enum ImageNameForWeatherType {
            static let sunny = "cloud.sun"
            static let snow  = "sun.snow.fill"
            static let rain  = "cloud.moon.rain.fill"
            static let night = "moon.stars.circle"
            static let fog   = "cloud.fog"
            static let storm = "cloud.bolt.rain"
        }
        
        enum ImageName {
            static let darkClouds  = "dark clouds"
            static let fog         = "fog"
            static let lightning   = "lightning"
            static let clouds      = "clouds"
            static let dropOfRain  = "drop of rain"
            static let whiteClouds = "white clouds"
            static let snowflake   = "snowflake"
            static let comet       = "comet"
            static let star        = "star"
            static let cloudySky   = "cloudy sky"
            static let sunGlow     = "sun_glow"
            static let sun         = "sun"
            static let waterLine   = "water line"
        }
    }
}
