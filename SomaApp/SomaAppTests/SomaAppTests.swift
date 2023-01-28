  //
  //  SomaAppTests.swift
  //  SomaAppTests
  //
  //  Created by Michael Brockman on 1/19/23.
  //

import XCTest
@testable import SomaApp
@testable import FirebaseCore
@testable import FirebaseMessaging

final class SomaAppTests: XCTestCase {
  
  var sut: Model!
  
  override func setUpWithError() throws {
    try super.setUpWithError()
    sut = Model()
  }
  
  override func tearDownWithError() throws {
    sut = nil
    try super.tearDownWithError()
  }
  
  func getListingViewController() -> ListingViewController {
    let controller = ListingViewController()
    return controller
  }
  
//  func testDownloadDataFromModel() {
//
//    let listingVC = getListingViewController()
//    listingVC.model = sut
//    sut.currentSubset = .ground
//    sut.downloadData(for: .ground)
//    dump(listingVC)
//
//    XCTAssertEqual(sut.guardVideos.count, 17)
//  }
//
  
  
}
