// 
//  Copyright © 2019 Nobina AB. All rights reserved.
//

import UIKit
import CoreLocation

// Enum for the Theme color mode
enum Theme {
    case dark
    case light
    
    static var current: Theme {
        get {
            switch ThemeSetting.current {
            case .day:
                return .light
            
            case .night:
                return .dark
            
            case .auto:
                return .light
            }
        }
    }
}

// Enum for Theme settings
enum ThemeSetting: String {
    case day
    case night
    case auto
    
    private static var storedThemeSetting: ThemeSetting = {
        return .day
    }()
    
    private (set) static var current: ThemeSetting = storedThemeSetting {
        didSet {
        }
    }
    
    var image: UIImage {
        switch self {
        case .day:    return UIImage(named: "dag")!
        case .night:  return UIImage(named: "natt")!
        case .auto:   return UIImage(named: "dayNight")!
        }
    }
    
    var name: String {
        switch self {
        case .day:    return NSLocalizedString("settings_theme_section_light_mode", comment: "")
        case .night:  return NSLocalizedString("settings_theme_section_dark_mode", comment: "")
        case .auto:   return NSLocalizedString("settings_theme_section_auto", comment: "")
        }
    }
    
    static func applyTheme(_ newTheme: ThemeSetting) {
        ThemeSetting.current = newTheme
    }
    
}
