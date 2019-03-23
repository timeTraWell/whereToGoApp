//
//  ImagesLoader.swift
//  whereToGoApp
//
//  Created by Nickolay Nickitin on 08/03/2019.
//  Copyright © 2019 Nickolay Nickitin. All rights reserved.
//

import Alamofire
import AlamofireImage

class ImagesLoader {
    public func getImage(_ url:String, handler: @escaping (UIImage?)->Void) {
        Alamofire.request(url, method: .get).responseImage { response in
            if let data = response.result.value {
                handler(data)
            } else {
                handler(nil)
            }
        }
    }
}
