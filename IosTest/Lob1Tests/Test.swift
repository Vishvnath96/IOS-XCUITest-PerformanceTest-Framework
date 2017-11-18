
import XCTest
import UIKit

@testable import MakeMyTrip
class Test: XCTestCase {
    let app = XCUIApplication()
   

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app.launch()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        var testName: String? = self.name
        guard let run = testRun else {
            return
        }
        let baseTest = BaseTest(run,testName)
        baseTest.onTestSucceed()
    }
    
    func testExample1_HTL(){
        //let app = XCUIApplication()
        let cellsQuery = app.collectionViews.cells
        cellsQuery.otherElements.containing(.image, identifier:"icHomeFlight").element.tap()
        app.navigationBars["Flight Search"].buttons["Back"].tap()
        cellsQuery.otherElements.containing(.image, identifier:"icHomeHotel").element.tap()
        app.navigationBars["Hotel Search"].buttons["Back"].tap()
        //app.tables.cells.buttons["Book Now"].tap()
        //app.navigationBars["Hotel Offer"].buttons["hp back arrow"].tap()
    }
    
    func testFlight_FLT(){
        let cellsQuery = app.collectionViews.cells
        cellsQuery.otherElements.containing(.image, identifier:"icHomeFlight").element.tap()
        app.navigationBars["Flight Search"].buttons["Back"].tap()
        //let storyBoard: UIStoryboard? = self.getStoryBoard
        
//        self.name
//        print(self.name)
    }
    
    func test_c_Delete_HTL() {
        //DeleteApp.deleteMyApp()
        XCTAssert(true)
    }
}
