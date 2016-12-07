//
//  Shabbat.swift
//  NadavBaruch-pset6
//
//  Created by Nadav Baruch on 06-12-16.
//  Copyright © 2016 Nadav Baruch. All rights reserved.
//

import Foundation

class shabbat {
   var Candlelighting = ""
}

func parse(json data: Data) -> [String: Any]? {
    do {
        return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
    } catch {
        return nil
    }
}

func parse(dict dictionary: [String: Any]) -> shabbat! {
    
    let result = shabbat()
    
    if let candleLighting = dictionary["Candle Lighting"] {
        result.Candlelighting = candleLighting as! String
    }
    
    return result
}
