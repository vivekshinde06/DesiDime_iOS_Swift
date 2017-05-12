//
//  DeviceToken.swift
//  FleetPlus
//
//  Created by Vivek Shinde on 21/03/17.
//  Copyright © 2017 Jignesh Kalantri. All rights reserved.
//

import UIKit

class DeviceToken: NSObject {

    
    var deviceToken : String = "SimulatorToken"
    
    func getDeviceToke() -> String {
        
        return deviceToken
    }
    
    func setDeviceToken(tokenReceived: String)  {
        deviceToken = tokenReceived
    }
}
