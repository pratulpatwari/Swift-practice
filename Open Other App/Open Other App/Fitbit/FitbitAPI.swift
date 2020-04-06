//
//  FitbitAPI.swift
//  Open Other App
//
//  Created by pratul patwari on 6/15/18.
//  Copyright © 2018 pratul patwari. All rights reserved.
//

import UIKit

class FitbitAPI {
    
    static let sharedInstance: FitbitAPI = FitbitAPI()
    
    static let baseAPIURL = URL(string: "https://api.fitbit.com/1")
    
    var session: URLSession?
    
    func  authorize(with token: String) {
        let sessionConfiguration = URLSessionConfiguration.default
        var headers = sessionConfiguration.httpAdditionalHeaders ?? [:]
        headers["Authorization"] = "Bearer \(token)"
        headers["Accept-Language"] = "en_US"
        sessionConfiguration.httpAdditionalHeaders = headers
        session = URLSession(configuration: sessionConfiguration)
    }
    

}

extension Decodable {
    static func decode(data: Data) throws -> Self {
        let decoder = JSONDecoder()
        return try decoder.decode(Self.self, from: data)
    }
}

extension Encodable {
    func encode() throws -> Data {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        return try encoder.encode(self)
    }
}

func getAccessTokenUrl(token: String?, grantType: String, refreshToken: String?) -> String{
    var finalUrl = String()
    let clientId = "client_id="+clientID
    let grant = "&grant_type="+grantType
    if grantType == "authorization_code" && token != nil{
        let redirectUri = "&redirect_uri="+redirectURI
        let code = "&code="+token!
        finalUrl = baseTokenUrlString+clientId+grant+redirectUri+code
    } else if grantType == "refresh_token" {
        if let refresh = refreshToken {
            let refresh_token = "&refresh_token="+refresh
            finalUrl = baseTokenUrlString+clientId+grant+refresh_token
        } else {
            print("Error in generating url to get the acces token")
        }
        
    }
    return finalUrl
}

func getBase64Basic() -> NSString{
    let baseString = clientID + ":" + clientSecret
    var baseCode = NSString()
    if let b = baseString.data(using: String.Encoding.utf8) {
        let myBase = b.base64EncodedData(options: NSData.Base64EncodingOptions.endLineWithLineFeed)
        guard let resultNSString = NSString(data: myBase as Data, encoding: String.Encoding.utf8.rawValue) else {
            return ""
        }
        baseCode = resultNSString
    }
    print("Authentication token:     ", baseCode)
    return baseCode
}

func getAccessToken(token: String?, grantType: String ,refreshToken: String? ,completion: @escaping(AccessObject) -> ()){
    
    guard let url = URL(string: getAccessTokenUrl(token: token, grantType: grantType, refreshToken: refreshToken)) else {
        print("Error while drafting the url to fetch the access token")
        return
    }
    let request = NSMutableURLRequest(url: url)
    request.addValue("application/x-www-form-urlencoded",forHTTPHeaderField: "Content-Type")
    request.addValue("Basic \(getBase64Basic())",forHTTPHeaderField: "Authorization")
    request.httpMethod = "POST"
    
    let task = URLSession.shared.dataTask(with: request as URLRequest){
        (data,response,error)  in
        if let error = error{
            print(error)
        }
        else{
            if let unwrappedData = data{
                if let tokenDetails = String(data: unwrappedData, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue)) {
                    do{
                        if let data = tokenDetails.data(using: .utf8){
                            let finalObject = try AccessObject.decode(data: data)
                            completion(finalObject)
                        } else {print("No encoded data present")}
                    }
                    catch let error as NSError {
                        print(error)
                    }
                } else {
                    print("Error while encoding the data returned by Fitbit server")
                }
            }
        }
    }
    task.resume()
}

struct StepStat {
    
    let day: Date
    let steps: UInt
  
    init?(withDictionary data: [String: Any]) {
        guard let dateTime = data["dateTime"] as? DateComponents,
            let dateComponents = dateTime.date else {
                return nil
        }
        
        guard let stepCount = (data["value"] as? NSNumber)?.uintValue ?? UInt((data["value"] as? String) ?? "") else {
            return nil
        }
        
        day = dateComponents
        steps = stepCount
    }
    
    
    static func fetchTodaysStepStat(/*completion: @escaping (Array<Dictionary<String, Any>>, Error?) -> ()*/){
        
        guard let session = FitbitAPI.sharedInstance.session,
            let stepURL = URL(string: "https://api.fitbit.com/1/user/-/activities/steps/date/today/1d.json") else {
                return
        }
        
        let dataTask = session.dataTask(with: stepURL) { (data, response, error) in
            guard let response = response as? HTTPURLResponse, response.statusCode < 300 else {
                DispatchQueue.main.async {
                    lastUpdateLabel.text = "There was some error. Please try again !!!"
                }
                return
            }
            
            guard let data = data,
                let dictionary = (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [String: AnyObject] else {
                    DispatchQueue.main.async {
                        lastUpdateLabel.text = "There was some error. Please try again !!!"
                    }
                    return
            }
            //print(dictionary)
            guard let steps = dictionary["activities-steps"] as? [[String: AnyObject]] else { return }
            print(steps)
            //let stats = steps.compactMap({ StepStat(withDictionary: $0) })
            DispatchQueue.main.async {
                for i in steps {
                    if let value = i["value"] as? String {
                        stepCounttLabel.text = "Steps Count:   \(value)"
                    }
                }
               
                //completion(steps, nil)
            }
        }
        dataTask.resume()
    }
}

struct SyncData : Decodable {
    let battery : String
    let batteryLevel : Int
    let deviceVersion : String
    let id : String
    let lastSyncTime : String
    let mac : String
    let type : String
    
  static  func fetchDataSyncTime(/*completion: @escaping ([SyncData]?)->Void*/) {
        guard let session = FitbitAPI.sharedInstance.session,
            let stepURL = URL(string: deviceUrl) else {
                return
        }
        
        let task = session.dataTask(with: stepURL){
            (data,response,error)  in
            if let error = error{
                print(error)
            }
            else{
                if let unwrappedData = data{
                    if let tokenDetails = String(data: unwrappedData, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue)) {
                        do{
                            if let data = tokenDetails.data(using: .utf8){
                                let finalObject = try JSONDecoder().decode([SyncData].self, from: data)
                                //print(finalObject)
                                
                                DispatchQueue.main.async {
                                    for i in finalObject {
                                        lastUpdateLabel.text = "Data Sync:   \(i.lastSyncTime)"
                                    }
                                }
                                //completion(finalObject)
                            } else {print("No encoded data present")}
                        }
                        catch let error as NSError {
                            print(error)
                        }
                        
                    } else {
                        print("Error while encoding the data returned by Fitbit server")
                    }
                }
            }
        }
        task.resume()
    }
}


