//
//  KeychainWrapperTests.swift
//  KeychainWrapperTests
//
//  Created by Débora Oliveira on 11/10/19.
//  Copyright © 2019 Alysson Moreira. All rights reserved.
//

import XCTest
@testable import KeychainWrapper

var keychainWrapperWithGenericPwd: KeychainWrapper!

class KeychainWrapperTests: XCTestCase {

  override func setUp() {
    super.setUp()
    
    let genericPwdQueryable =
      GenericPasswordQueryable(service: "someService")
    keychainWrapperWithGenericPwd =
      KeychainWrapper(keychainWrapperQueryable: genericPwdQueryable)
  }

  override func tearDown() {
    try? keychainWrapperWithGenericPwd.removeAllValues()
    
    super.tearDown()
  }

  // Verifies whether it can save a password correctly.
  func testSaveGenericPassword() {
    do {
      try keychainWrapperWithGenericPwd.setValue("pwd_1234", for: "genericPassword")
    } catch {
      XCTFail("Saving generic password failed with \(error.localizedDescription).")
    }
  }

  // First saves the password then retrieves the password, checking if it’s equal to the expected one.
  func testReadGenericPassword() {
    do {
      try keychainWrapperWithGenericPwd.setValue("pwd_1234", for: "genericPassword")
      let password = try keychainWrapperWithGenericPwd.getValue(for: "genericPassword")
      XCTAssertEqual("pwd_1234", password)
    } catch {
      XCTFail("Reading generic password failed with \(error.localizedDescription).")
    }
  }

  // Verifies when saving a different password for the same account, the latest password is the one expected after its retrieval.
  func testUpdateGenericPassword() {
    do {
      try keychainWrapperWithGenericPwd.setValue("pwd_1234", for: "genericPassword")
      try keychainWrapperWithGenericPwd.setValue("pwd_1235", for: "genericPassword")
      let password = try keychainWrapperWithGenericPwd.getValue(for: "genericPassword")
      XCTAssertEqual("pwd_1235", password)
    } catch {
      XCTFail("Updating generic password failed with \(error.localizedDescription).")
    }
  }

  // Tests that it can remove a password for a specific account.
  func testRemoveGenericPassword() {
    do {
      try keychainWrapperWithGenericPwd.setValue("pwd_1234", for: "genericPassword")
      try keychainWrapperWithGenericPwd.removeValue(for: "genericPassword")
      XCTAssertNil(try keychainWrapperWithGenericPwd.getValue(for: "genericPassword"))
    } catch {
      XCTFail("Saving generic password failed with \(error.localizedDescription).")
    }
  }

  // Checks that all the passwords related to a specific service are deleted from the Keychain.
  func testRemoveAllGenericPasswords() {
    do {
      try keychainWrapperWithGenericPwd.setValue("pwd_1234", for: "genericPassword")
      try keychainWrapperWithGenericPwd.setValue("pwd_1235", for: "genericPassword2")
      try keychainWrapperWithGenericPwd.removeAllValues()
      XCTAssertNil(try keychainWrapperWithGenericPwd.getValue(for: "genericPassword"))
      XCTAssertNil(try keychainWrapperWithGenericPwd.getValue(for: "genericPassword2"))
    } catch {
      XCTFail("Removing generic passwords failed with \(error.localizedDescription).")
    }
  }
  
}
