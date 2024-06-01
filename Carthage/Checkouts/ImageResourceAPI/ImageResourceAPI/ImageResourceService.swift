//
//  ImageResourceService.swift
//  ImageResourceAPI
//
//  Created by Belkhadir Anas on 1/6/2024.
//

public protocol ImageResourceService {
    typealias Result = Swift.Result<ImageProviding, Error>
    
    func retriveResouce(completion: @escaping (Result) -> Void)
}
