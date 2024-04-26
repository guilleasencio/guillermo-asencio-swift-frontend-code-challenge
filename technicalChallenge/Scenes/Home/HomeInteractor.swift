//
//  HomeInteractor.swift
//  technicalChallenge
//
//  Created by Guillermo Asencio Sanchez on 25/4/24.
//
import Domain

protocol HomeBusinessLogic {
    func doGetUserDetails(request: Home.UserDetails.Request)
}

protocol HomeDataStore {
    var user: User? { get }
}

class HomeInteractor: HomeBusinessLogic, HomeDataStore {
    
    var presenter: HomePresentationLogic?
    private let getUserDetailsUseCase: GetUserDetailsUseCase
    
    private(set) var user: User?
    
    init(getUserDetailsUseCase: GetUserDetailsUseCase) {
        self.getUserDetailsUseCase = getUserDetailsUseCase
    }
    
    // MARK: Public
    
    func doGetUserDetails(request: Home.UserDetails.Request) {
        Task { @MainActor in
            var errorMessage: String?
            do {
                user = try await getUserDetailsUseCase(username: request.term)
            } catch let error as CustomError {
                errorMessage = error.errorMessage
            } catch {
                errorMessage = error.localizedDescription
            }
            let response = Home.UserDetails.Response(errorMessage: errorMessage)
            presenter?.presentUserDetails(response: response)
        }
    }
}
