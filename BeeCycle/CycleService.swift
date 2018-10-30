//
//  CycleService.swift
//  BeeCycle
//
//  Created by Aoife McLaughlin on 11/07/2018.
//  Copyright © 2018 Aoife McLaughlin. All rights reserved.
//

import UIKit
import Foundation
import CoreLocation

class CycleService: NSObject {
    let session = URLSession.shared
    let cycleUrl = URL(string:"https://api.cityverve.org.uk/v1/entity/cycle-locker")
    
    
    func requestCycleLocker(completion: @escaping (_ cycleLockerArray: [CycleLocker]) -> ())
    {
        var cycleLockerArray = [CycleLocker]()
        let request = NSMutableURLRequest(url: cycleUrl!)
        request.setValue("595bcd331cbfd800013b226e67bd873996d54e58aaaab9ee4f8e3741", forHTTPHeaderField: "Authorization")
        session.dataTask(with: request as URLRequest){(data: Data?,response: URLResponse?, error: Error?) -> Void in
            
            if let responseData = data
            {
                do{
                    let json = try? JSONSerialization.jsonObject(with: responseData)
                    guard let jsonArray = json as? [[String: Any]] else {
                        return
                    }
                    print(jsonArray)
                    
                    for dic in jsonArray {
                        guard let lockerId = dic["id"] as? String else { return }
                        guard let lockerName = dic["name"] as? String else { return }
                        guard let lockerType = dic["type"] as? String else { return }
                        guard let lockerLocation = dic["loc"] as? [String: Any] else { return }
                        guard let location = lockerLocation["coordinates"] as? [Double] else { return }
                        guard let locationLat = location[1] as? Double else { return }
                        guard let locationLng = location[0] as? Double else { return }
                        
                        cycleLockerArray.append(CycleLocker(location: lockerLocation, type: lockerType, locationType: lockerId, latitude: locationLat, longitude: locationLng, coordinate:CLLocationCoordinate2D(latitude: locationLat, longitude: locationLng)))

                        }

                    print(cycleLockerArray)
                        
                    }
                
                catch{
                    print("Could not serialize")
                }
                completion(cycleLockerArray)
            }
            
            }.resume()
        
        
    }
    
}
