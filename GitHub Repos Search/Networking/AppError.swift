

import Foundation

enum AppError: LocalizedError {
    case errorDecoding
    case unknownError
    case invalidURL
    case serverError(String)
    var errorDescription: String? {
        switch self {
        case .errorDecoding:
            return "Response could not decoded"
        case .unknownError:
            return "Don't know why the error occured"
        case .invalidURL:
            return "invalid URL"
        case .serverError(let error):
            return error
        }
    }
}
