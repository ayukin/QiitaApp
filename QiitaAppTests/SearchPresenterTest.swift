//
//  SearchPresenterTest.swift
//  QiitaAppTests
//
//  Created by Ayuki Nishioka on 2020/12/01.
//

import XCTest
@testable import QiitaApp

class SearchPresenterTest: XCTestCase {
    
    var router: SearchTransitionRouter!

    override func setUpWithError() throws {
        super.setUp()
        let nav = UIStoryboard(name: "Search", bundle: nil).instantiateInitialViewController() as! UINavigationController
        let vc = nav.topViewController as! SearchViewController
        router = SearchTransition(viewController: vc)
    }

    override func tearDownWithError() throws {
        super.tearDown()
    }
    
    func testSearch_Success() {
        let searchWord = ["aaa"]
        let nav = UIStoryboard(name: "Search", bundle: nil).instantiateInitialViewController() as! UINavigationController
        let view = nav.topViewController as! SearchViewController
        let model = SearchPresenterModelMock(searchList: searchWord)
        let presenter = SearchPresenter(view: view, model: model, router: router)
        presenter.getSearchListAction()
        let searchList = presenter.search(forRow: 0)
        // nilでなければ成功
        XCTAssertNotNil(searchList)
    }
    
    func testSearch_Nil() {
        let searchWord = ["aaa"]
        let nav = UIStoryboard(name: "Search", bundle: nil).instantiateInitialViewController() as! UINavigationController
        let view = nav.topViewController as! SearchViewController
        let model = SearchPresenterModelMock(searchList: searchWord)
        let presenter = SearchPresenter(view: view, model: model, router: router)
        presenter.getSearchListAction()
        let searchList = presenter.search(forRow: 2)
        // nilであれば成功
        XCTAssertNil(searchList)
    }

}


class SearchPresenterModelMock: SearchModelInput {
    
    var searchList: [String]!
    
    init(searchList: [String]) {
        self.searchList = searchList
    }

    func getSearchList() -> [String] {
        return self.searchList
    }
    
    func removeSearchList(indexPath: Int) {
    }
    
    func appendSearchList(text: String) {
    }
    
}
