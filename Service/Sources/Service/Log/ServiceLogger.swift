//
//  ServiceLogger.swift
//  
//
//  Created by Gizem Fitoz on 24.02.2022.
//

import Alamofire

final class ServiceLogger: EventMonitor {
    func requestDidResume(_ request: Request) {
        let url = request.request?.url?.absoluteString ?? ""
        let method = request.request?.method?.rawValue ?? ""
        print("⚡️ \(method.uppercased()) \(url)")
    }
}
