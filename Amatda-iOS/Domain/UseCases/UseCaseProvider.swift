//
//  UseCaseProvider.swift
//  Amatda-iOS
//
//  Created by Haehyeon Jeong on 11/05/2019.
//  Copyright © 2019 JHH. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

public protocol UseCase {
    func makePostsUseCase() -> PostsUseCase
}

public final class UseCaseProvider: UseCase{
    private let configuration : Realm.Configuration
    
    public init(configuration: Realm.Configuration = Realm.Configuration()){
        self.configuration = configuration
    }
    
    public func makePostsUseCase() -> PostsUseCase {
        
    }
}
