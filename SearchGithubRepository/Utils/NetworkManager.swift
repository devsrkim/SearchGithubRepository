//
//  NetworkManager.swift
//  SearchGithubRepository
//
//  Created by srkim on 2024/03/30.
//

import Foundation
import Alamofire
import RxSwift

final class NetworkManager<A: APISpec> {
    private let session: Session
    
    init() {
        let configuration = URLSessionConfiguration.default
        session = Alamofire.Session(configuration: configuration)
    }
    
    func request<T: Decodable>(
        api: A,
        of type: T.Type = T.self
    ) -> Single<Result<T, NetworkError>> {
        return Single.create { [weak self] single in
            guard let self = self else { return Disposables.create() }
            
            let dataRequest = self.request(api: api, of: T.self) { response in
                single(.success(response))
            }
            
            return Disposables.create {
                dataRequest?.cancel()
            }
        }
    }
}

extension NetworkManager {
    private func request<T: Decodable>(
        api: A,
        of type: T.Type = T.self,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) -> DataRequest? {
        do {
            let dataRequest = try makeDataRequest(api)
            
            return dataRequest.responseData { [weak self] responseData in
                guard let self = self else { return }
                
                switch responseData.result {
                case let .success(data):
                    
                    if let networkError = self.checkErrorByStatusCode(from: responseData, of: T.self) {
                        completion(.failure(networkError))
                        return
                    }
                    
                    do {
                        let json = try JSONDecoder().decode(T.self, from: data)
                        completion(.success(json))
                    } catch {
                        let jsonDecodingError = NetworkError.jsonDecoding(
                            responseData.request,
                            responseData.response,
                            data,
                            error
                        )
                        completion(.failure(jsonDecodingError))
                    }

                case let .failure(error):
                    let otherError = NetworkError.other(error)
                    completion(.failure(otherError))
                }
            }
        } catch {
            let parameterError = NetworkError.parameter(api.url, api.parameters, error)
            completion(.failure(parameterError))
            return nil
        }
    }

    private func makeDataRequest(_ api: APISpec) throws -> DataRequest {
        var urlRequest = URLRequest(url: api.url)
        urlRequest.httpMethod = api.method.rawValue
        urlRequest.timeoutInterval = api.timeoutInterval
        
        let encodingType = api.parameterEncodingType ?? URLEncoding.default
        var encodedRequest: URLRequest = try encodingType.encode(urlRequest, with: api.parameters)
        
        if let header = api.header {
            encodedRequest.allHTTPHeaderFields = header
        }
        
        return session.request(encodedRequest)
    }
    
    private func checkErrorByStatusCode<T: Decodable>(
        from dataResponse: AFDataResponse<Data>,
        of type: T.Type = T.self
    ) -> NetworkError? {
        let request = dataResponse.request
        let response = dataResponse.response
        let data = dataResponse.data
        
        guard let statusCode = dataResponse.response?.statusCode else {
            return .status(request, -1, data)
        }
        
        switch statusCode {
        case let code where code >= 400 || code < 200 :
            return .status(request, code, data)
            
        default:
            return nil
        }
    }
}
