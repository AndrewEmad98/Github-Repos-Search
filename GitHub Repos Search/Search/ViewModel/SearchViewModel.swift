
import Foundation
import RxSwift
import RxCocoa

class SearchViewModel<T>{
    let searchText = PublishSubject<T>()
    
    private func fetchData(){
        // fetch Data from the API
    }
}
