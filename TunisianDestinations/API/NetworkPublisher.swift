// Publisher for API execution

import Alamofire
import Combine
import Foundation

// MARK: - NetworkPublisher

struct NetworkPublisher {
    
    // MARK: - Constants
    
    private static let successRange = 200 ..< 300
    private static let contentType = "application/json"
    private static let retryCount: Int = 1
    static let decorder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        return jsonDecoder
    }()
    
    // MARK: - Methods
    static func publish<T, V>(_ request: T) -> Future<V, Error>
        where T: BaseRequestProtocol, V: Codable, T.ResponseType == V {
            return Future { promise in
                let api = AF.request(request)
                    .validate(statusCode: self.successRange)
                    .validate(contentType: [self.contentType])
                    .cURLDescription { text in
                        print(text)
                }
                .responseJSON { response in
                    switch response.result {
                    case .success:
                        do {
                            if let data = response.data {
                                print("success")
                                let json  =  try  self.decorder.decode( V . self ,  from :  data )
                                promise ( . success ( json ))
                            } else  {
                                print ("json response is empty")
                            }
                            
                        } catch {
                            promise(.failure(error))
                        }
                    case let .failure(error):
                        //   Something went wrong, switch on the status code and return the error
                        switch response.response?.statusCode {
                        case 400:
                            print("badRequest")
                        //    observer.onError(ApiError.unAuthorized)
                        case 401:
                            //  observer.onError(ApiError.unAuthorized)
                            print("unAuthorized")
                        case 404:
                            //  observer.onError(ApiError.notFound)
                            print("notFound")
                        case 500:
                            // observer.onError(ApiError.internalServerError)
                            print("internalServerError")
                        default:
                            //  observer.onError(error)
                            print("error")
                        }
                        
                        promise(.failure(error))
                        
                    }
                }
                api.resume()
            }
    }
}
