//
//  HomeViewModel.swift
//  tellingMe
//
//  Created by KYUBO A. SHIM on 2023/09/23.
//

import UIKit

import Moya
import RxCocoa
import RxSwift

protocol HomeViewModelInputs {
    func getMainComponentData()
//    func
}

protocol HomeViewModelOutputs {
    
}

protocol HomeViewModelType {
    var inputs: HomeViewModelInputs { get }
    var outputs: HomeViewModelOutputs { get }
}

final class HHomeViewModel: HomeViewModelInputs, HomeViewModelOutputs, HomeViewModelType {
    func getMainComponentData() {
        
    }
    
    var inputs: HomeViewModelInputs { return self }
    
    var outputs: HomeViewModelOutputs { return self }
    
    
}
