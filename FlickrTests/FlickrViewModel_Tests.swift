//
//  FlickrViewModel_Tests.swift
//  Flickr
//
//  Created by meekam okeke on 2/6/25.
//

import XCTest
@testable import Flickr

@MainActor
final class FlickrViewModel_Tests: XCTestCase {
    var viewModel: FlickrViewModel?
    
    override func setUpWithError() throws {
        viewModel = FlickrViewModel(isLoading: Bool.random())
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
    }
    
    func test_FlickrViewModel_isLoading_shouldBeTrue() {
        //Given
        let isLoading: Bool = true
        
        //When
        let vm = FlickrViewModel(isLoading: isLoading)
        
        //Then
        XCTAssertTrue(vm.isLoading)
    }
}
