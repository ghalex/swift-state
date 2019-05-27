//
//  RxState.swift
//  RxState
//
//  Created by Alexandru Ghiura on 27/05/2019.
//  Copyright © 2019 Alexandru Ghiura. All rights reserved.
//

import Foundation

public func createStore<T>(state: T) -> Store<T> where T: Any {
    return Store<T>(initialState: state)
}
