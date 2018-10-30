//
//  CycleStreetService.swift
//  BeeCycle
//
//  Created by Aoife McLaughlin on 29/07/2018.
//  Copyright © 2018 Aoife McLaughlin. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation

class CycleStreetService: NSObject {
    let decoder = JSONDecoder()
    let coordinates = "0.117950,52.205302,City+Centre%7C0.131402,52.221046,Mulberry+Close%7C0.147324,52.199650,Thoday+Street"
    let typeCycle = "quietest"
    let cycleStreetSession = URLSession.shared
    let key = "9b2d9f7de999e9f3"
    var latStringArray : [String] = []
    var lngStringArray : [String] = []
    var latDoubleArray : [Double] = []
    var lngDoubleArray : [Double] = []
    var coordinateArray: [CLLocationCoordinate2D] = []

    func requestCycleStreet(completion: @escaping( _ journeyPlannerResult: JourneyPlannerResult) -> ())
    {
        let urlString = String(format: "https://www.cyclestreets.net/api/journey.json?key=%@&itinerarypoints=%@&plan=%@", self.key, self.coordinates, self.typeCycle)
        print(urlString)
        
        guard let cycleStreetUrl = URL(string: urlString) else {
            return
        }
        Alamofire.request(cycleStreetUrl).validate().responseJSON(completionHandler: { (response) in
            guard response.result.isSuccess
                else
            {
                print("error with request")
                return
            }
            print("Successful")
            let responseData = Data(response.data!)
            let myResponse = try! JSONDecoder().decode(Welcome.self, from: responseData)
            print(myResponse)
            print(myResponse.marker)
            print(myResponse.waypoint)
            let myAttributes = myResponse.marker[0].attributes
            let startLat = Double(myAttributes["start_latitude"]!)
            let startLng = Double(myAttributes["start_longitude"]!)
            let endLat = Double(myAttributes["finish_latitude"]!)
            let endLng = Double(myAttributes["finish_longitude"]!)
            let startCoord = CLLocationCoordinate2D(latitude: startLat ?? 0, longitude: startLng ?? 0)
            let endCoord = CLLocationCoordinate2D(latitude: endLat ?? 0 , longitude: endLng ?? 0)
          
            let coordinatesString = myAttributes["coordinates"] as? String
            let coordinates = coordinatesString?.components(separatedBy: " ")

            for coordinate in coordinates!
            {
                var coordinateArray = coordinate.components(separatedBy: ",")
                self.latStringArray.append(coordinateArray[1])
                self.lngStringArray.append(coordinateArray[0])
            }
            self.createDoubleCoordinateArray()
            self.createCoordinateArray()
            print(self.createCoordinateArray())
            let result = JourneyPlannerResult(polylineCoordinates: self.coordinateArray)
            completion(result)

            
        })
        
    }
    
    func createDoubleCoordinateArray()
    {
        for latString in latStringArray
        {
            let latDouble = Double(latString)
            self.latDoubleArray.append(latDouble!)
        }
        for lngString in lngStringArray
        {
            let lngDouble = Double(lngString)
            self.lngDoubleArray.append(lngDouble!)
        }
        
    }
    
    func createCoordinateArray() -> [CLLocationCoordinate2D]
    {
        for i in latDoubleArray.indices {
            let coordinate = CLLocationCoordinate2D(latitude: latDoubleArray[i], longitude: lngDoubleArray[i])
            coordinateArray.append(coordinate)
        }
        return coordinateArray
    }
}
struct Welcome: Codable {
    let marker: [Marker]
    let waypoint: [Waypoint]
}

struct Marker: Codable {
    let attributes: [String: String]
    
    enum CodingKeys: String, CodingKey {
        case attributes = "@attributes"
    }
}

struct Waypoint: Codable {
    let attributes: Attributes
    
    enum CodingKeys: String, CodingKey {
        case attributes = "@attributes"
    }
}

struct Attributes: Codable {
    let sequenceID, longitude, latitude: String
    
    enum CodingKeys: String, CodingKey {
        case sequenceID = "sequenceId"
        case longitude, latitude
    }
}







