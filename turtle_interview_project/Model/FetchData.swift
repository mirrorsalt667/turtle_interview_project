//
//  FetchData.swift
//  turtle_interview_project
//
//  Created by Stephen on 2023/9/12.
//

import Foundation

class FetchData {
    
    func fetchData(completion: @escaping ([YoubikeType]) -> Void) {
        var request = URLRequest(url: URL(string: "https://tcgbusfs.blob.core.windows.net/dotapp/youbike/v2/youbike_immediate.json")!,timeoutInterval: Double.infinity)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                return
            }
            let decoder = JSONDecoder()
            do {
                let receiveData = try decoder.decode([YoubikeType].self, from: data)
                completion(receiveData)
            } catch let getError {
                print("get Error: \(getError)")
            }
        }
        task.resume()
    }
}
