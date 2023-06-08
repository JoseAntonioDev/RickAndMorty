//
//  ListOfCharactersViewModel.swift
//  RickAndMortyApp
//
//  Created by Jose Antonio Alvarez Vazquez on 6/6/23.
//

import Foundation

// We define these protocols in order to keep Dependency Inversion SOLID PRINCIPLE using abstractions
protocol ListOfCharactersViewModelInput {
    func getAllCharacters() async
}

protocol ListOfCharactersViewModelOuput {
    var items: Observable<[Character]> { get }
    var cells: Observable<[(CharacterCell, Int)]> { get set }
    var isLoading: Observable<Bool> { get }
    var characterSelected: Observable<(Character?, Any?)> { get set }
    var error: Observable<Errors?> { get set }
}

typealias ListOfCharactersViewModelProtocol = ListOfCharactersViewModelInput & ListOfCharactersViewModelOuput

class ListOfCharactersViewModel: ListOfCharactersViewModelProtocol {
    //MARK: - Properties
    var cells: Observable<[(CharacterCell, Int)]> = Observable([])
    var characterSelected: Observable<(Character?, Any?)> = Observable((nil, nil))
    var items: Observable<[Character]> = Observable([])
    var isLoading: Observable<Bool> = Observable(false)
    var error: Observable<Errors?> = Observable(nil)
    
    //MARK: - Methods
    func getAllCharacters() async {
        DispatchQueue.main.async {
            self.isLoading.value = true
        }
        do {
            let result = try await CharacterClient.getFirstResult()
            items.value = result.results
        } catch {
            self.error.value = Errors.unknownError
        }
        DispatchQueue.main.async {
            self.isLoading.value = false
        }
    }

}
