//
//  CardsTests.swift
//  CardsTests
//
//  Created by Valerio2 on 19/06/14.
//  Copyright (c) 2014 Valerio2. All rights reserved.
//

import XCTest

class CardsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        XCTAssert(true, "Pass")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testCompare() {
        
        // necessario aggiungere le classi usate qui al target CardTest
        var card1 = FrenchCard(rank: FrenchCard.Rank(1), suit: FrenchCard.Suit(rawValue: 1)!)
        var card2 = FrenchCard(rank: FrenchCard.Rank(12), suit: FrenchCard.Suit(rawValue: 1)!)
        var result = card1 > card2 // comparable
        XCTAssertTrue(result == true, "Compare cards K > A!!!!")
        
        card1 = FrenchCard(rank: FrenchCard.Rank(1), suit: FrenchCard.Suit(rawValue: 1)!)
        card2 = FrenchCard(rank: FrenchCard.Rank(12), suit: FrenchCard.Suit(rawValue: 2)!)
        result = card1 > card2 // comparable
        XCTAssertTrue(result == true, "Compare cards K > A!!!!")

    }
}
