//
//  BuildingsManager.swift
//  MIAapp
//
//  Created by Sören Kirchner (privat) on 07.07.23.
//

import Foundation
import OSLog

// MARK: - BuildingsManager

class BuildingsManager {

    let mapper = BuildingsMapper()

    func getBuildings() async throws -> [Building] {

        let result = await MIAClient.fetch(API.request(for: API.buildings))
        
        switch result {
        case .success(let data):
            
            do {
                
                debugPrint(data.data)
                let jsonData = try JSONDecoder().decode(APIBuildings.self, from: data.data)
                return mapper.map(jsonData)
            } catch {
                Logger.buildingsManager.debug("\(error)")
                throw ManagerError.unknownError
            }

        case .failure(let error):
            Logger.buildingsManager.debug("\(error)")
            throw ManagerError(clientError: error)
        }
    }
    
    func getBuildingDetail(for id: Int) async throws -> BuildingDetail {
        
        let startTime = CFAbsoluteTimeGetCurrent()
        let result = await MIAClient.fetch(API.request(for: API.building(for: id)))
        Logger.buildingsManager.debug("Load Building with id: \(id) - Time Elapsed: \(CFAbsoluteTimeGetCurrent() - startTime)")

        switch result {
        case .success(let data):
            
            do {
                
                let jsonData = try JSONDecoder().decode(APIBuildingDetail.self, from: data.data)
                Logger.buildingsManager.debug("decoded Building with id: \(id) - Time Elapsed: \(CFAbsoluteTimeGetCurrent() - startTime)")
                
                let business = mapper.map(jsonData)
                Logger.buildingsManager.debug("mapped Building with id: \(id) - Time Elapsed: \(CFAbsoluteTimeGetCurrent() - startTime)")
                
                return business
            } catch {
                Logger.buildingsManager.debug("\(error)")
                throw ManagerError.unknownError
            }

        case .failure(let error):
            Logger.buildingsManager.debug("\(error)")
            throw ManagerError(clientError: error)
        }
    }
}

// MARK: - ManagerError

enum ManagerError: Error {

    case networkError
    case unknownError
    case notImplementedError

    init(clientError: ClientError) {
        
        switch clientError {

        case .HTTPClientError(_),
             .HTTPServerError:
            self = .networkError
            
        case .DecodingError(_),
             .InternalError:
            self = .unknownError
        }
    }
}
