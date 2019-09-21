//
//  EventsOutputProtocol.swift
//  whereToGoApp
//
//  Created by Nickolay Nickitin on 14/09/2019.
//  Copyright © 2019 Nickolay Nickitin. All rights reserved.
//

import Foundation

protocol EventsOutputProtocol: class {
    func didCityChanged(name: String, slug: String)
}
