//
//  NetworkExtensions.swift
//
//
//  Created by BlueSkyAnimal on 2023/09/10.
//

import Foundation

public enum RequestError: LocalizedError {
    case clientError(ClientError), serverError(ServerError), responseError, encodingError, decodingError
    
    public var errorDescription: String? {
        switch self {
            case .clientError(let clientError):
                clientError.errorDescription
            case .serverError(let serverError):
                serverError.errorDescription
            case .responseError:
                "Response Error"
            case .encodingError:
                "Encoding Error"
            case .decodingError:
                "Decoding Error"
        }
    }
}

public extension RequestError {
    enum ClientError: Int, LocalizedError {
        case badRequest = 400
        case unAuthorized = 401
        case paymentRequired = 402
        case forBidden = 403
        case notFound = 404
        case methodNotAllowed = 405
        case notAcceptable = 406
        case proxyAuthenticationRequired = 407
        case requestTimeout = 408
        case conflict = 409
        case gone = 410
        case lengthRequired = 411
        case preconditionFailed  = 412
        case payloadTooLarge = 413
        case uriTooLong = 414
        case unsupportedMediaType = 415
        case rangeNotSatisfiable = 416
        case expectationFailed = 417
        case teapot = 418
        case misdirectedRequest = 421
        case unprocessableEntity = 422
        case locked = 423
        case failedDependency = 424
        case tooEarly = 425
        case upgradeRequired = 426
        case preconditionRequired = 428
        case tooManyRequests = 429
        case requestHeaderFieldsTooLarge = 431
        case unavailableForLegalReasons = 451
        
        public var errorDescription: String? {
            return "Client Error: \(rawValue)"
        }
    }
}

public extension RequestError {
    enum ServerError: Int, LocalizedError {
        case internalServerError = 500
        case notImpremented = 501
        case badGateway = 502
        case serviceUnavailable = 503
        case gatewayTimeout = 504
        case httpVersionNotSupported = 505
        case variantAlsoNegotiates = 506
        case insufficientStorage = 507
        case loopDetected = 508
        case notExtended = 510
        case networkAuthenticationRequired = 511
        
        public var errorDescription: String? {
            return "Server Error: \(rawValue)"
        }
    }
}

public extension URL {
    static func string(_ string: String) -> URL? {
        return URL(string: string)
    }
    
    var request: URLRequest {
        return .init(url: self)
    }
    
    func get(headers: [String : String] = [:]) async -> Result<Data, RequestError> {
        return await request.get(headers: headers)
    }
    
    func post(headers: [String : String] = [:], body: Data? = nil) async -> Result<Data, RequestError> {
        return await request.post(headers: headers, body: body)
    }
}

public extension URLRequest {
    func get(headers: [String : String] = [:]) async -> Result<Data, RequestError> {
        var request = self
        request.allHTTPHeaderFields = headers
        request.httpMethod = "GET"
        
        guard let response = try? await URLSession.shared.data(for: request) else {
            return .failure(.responseError)
        }
        
        guard let httpURLResponse = response.1 as? HTTPURLResponse else {
            return .failure(.responseError)
        }
        
        guard httpURLResponse.statusCode == 200 else {
            if let clientError = RequestError.ClientError(rawValue: httpURLResponse.statusCode) {
                return .failure(.clientError(clientError))
            } else if let serverError = RequestError.ServerError(rawValue: httpURLResponse.statusCode) {
                return .failure(.serverError(serverError))
            } else {
                return .failure(.responseError)
            }
        }
        
        return .success(response.0)
    }
}

public extension URLRequest {
    func post(headers: [String : String] = [:], body: Data? = nil) async -> Result<Data, RequestError> {
        var request = self
        request.allHTTPHeaderFields = headers
        request.httpBody = body
        request.httpMethod = "POST"
        
        guard let response = try? await URLSession.shared.data(for: request) else {
            return .failure(.responseError)
        }
        
        guard let httpURLResponse = response.1 as? HTTPURLResponse else {
            return .failure(.responseError)
        }
        
        guard httpURLResponse.statusCode == 200 else {
            if let clientError = RequestError.ClientError(rawValue: httpURLResponse.statusCode) {
                return .failure(.clientError(clientError))
            } else if let serverError = RequestError.ServerError(rawValue: httpURLResponse.statusCode) {
                return .failure(.serverError(serverError))
            } else {
                return .failure(.responseError)
            }
        }
        
        return .success(response.0)
    }
}
