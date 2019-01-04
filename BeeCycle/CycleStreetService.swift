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
import MapKit

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
    var attributeArray: [[String: String]] = []
    var journeyLegArray: [JourneyLeg] = []
    


    func requestCycleStreet(coordinates: String, completion: @escaping( _ journeyPlannerResult: JourneyPlannerResult) -> ())
    {
        let urlString = String(format: "https://www.cyclestreets.net/api/journey.json?key=%@&itinerarypoints=%@&plan=%@", self.key, coordinates, self.typeCycle)
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
            let journeyPlanResponse = try! JSONDecoder().decode(JourneyPlanResult.self, from: responseData)
            let fullJourneyAttributes = journeyPlanResponse.marker[0].attributes
            let startName = fullJourneyAttributes["start"]
            let endName = fullJourneyAttributes["finish"]
            let name = fullJourneyAttributes["name"]
            let duration = Int(Double(fullJourneyAttributes["time"]!)!/60)
            let startLat = Double(fullJourneyAttributes["start_latitude"]!)
            let startLng = Double(fullJourneyAttributes["start_longitude"]!)
            let endLat = Double(fullJourneyAttributes["finish_latitude"]!)
            let endLng = Double(fullJourneyAttributes["finish_longitude"]!)
            let startCoord = CLLocationCoordinate2D(latitude: startLat ?? 0, longitude: startLng ?? 0)
            let endCoord = CLLocationCoordinate2D(latitude: endLat ?? 0 , longitude: endLng ?? 0)
          
            let coordinatesString = fullJourneyAttributes["coordinates"] as? String
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
            
            
            for marker in journeyPlanResponse.marker
            {
                self.attributeArray.append(marker.attributes)
            }
            
            for attribute in self.attributeArray
            {
                let turn = attribute["turn"]
                let distance = attribute["distance"]
                let duration = Int(attribute["time"]!)
                let name = attribute["name"]
                
                let journeyLeg = JourneyLeg(turn: turn, distance: distance, duration: duration, name: name)
                self.journeyLegArray.append(journeyLeg)
            }
            
            
            let result = JourneyPlannerResult(polylineCoordinates: self.coordinateArray, startName: startName!, endName: endName!, duration: duration, name: name, journeyLegs: self.journeyLegArray)
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
struct JourneyPlanResult: Codable {
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







