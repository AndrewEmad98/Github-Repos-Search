

import Foundation

protocol ErrorHandlerProtocol {
    func makeUIErrorHandler(with message: String)
}

enum AppError: LocalizedError {
    case serverError(String)
    var errorDescription: String? {
        switch self {
        case .serverError(let error):
            if error.contains("403"){
                return "Not Authorized"
            }else if error.contains("422"){
                return "There's no more items"
            }else{
                return error
            }
        }
    }
}
