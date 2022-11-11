
import Foundation
import Moya
import RxSwift
import RxCocoa


enum MoyaProviderServices: TargetType{
    
    static var pageNumber = 1
    case getRepos(query: String)
    var baseURL: URL{
        let url = try? "https://api.github.com/search/repositories".asURL()
        return url!
    }
   
    var path: String{
        return ""
    }
    var sampleData: Data {
        return Data()
    }
    var method: Moya.Method {
        switch self {
        case .getRepos(_):
            return .get
        }
    }
    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
    var task: Task {
        print("Call the Api")
        switch self {
        case .getRepos(let query):
            return .requestParameters(parameters: [
                "q": query,
                "type": "users",
                "page": MoyaProviderServices.pageNumber
            ], encoding: URLEncoding.queryString)
        }
    }
    var validationType: ValidationType {
        return .successCodes
    }
}
