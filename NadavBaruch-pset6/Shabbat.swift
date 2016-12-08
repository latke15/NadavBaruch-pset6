//
//  Shabbat.swift
//  NadavBaruch-pset6
//
//  Created by Nadav Baruch on 06-12-16.
//  Copyright © 2016 Nadav Baruch. All rights reserved.
//

import Foundation

class shabbat {
   var candleLighting = ""
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
//    print(result)
    
    
//    if let items = dictionary["items"] {
//        if let candleLighting = items["title"] {
//            result.candleLighting = candleLighting as! String
//        }
//    }
    return result
}
