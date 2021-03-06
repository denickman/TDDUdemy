//
//  MockURLProtocol.swift
//  TDDUdemyTests
//
//  Created by Denis Yaremenko on 3/25/21.
//

import Foundation

class MockURLProtocol: URLProtocol {
    
    static var stubResponseData: Data?
    static var error: Error?
    
    override class func canInit(with request: URLRequest) -> Bool {
        // determine whether or not the implementation can perform a load with that request
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        if let signUpError = MockURLProtocol.error {
            self.client?.urlProtocol(self, didFailWithError: signUpError)
        } else {
            self.client?.urlProtocol(self, didLoad: MockURLProtocol.stubResponseData ?? Data())
        }
        
        self.client?.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() {
        // required to override here
    }
}
