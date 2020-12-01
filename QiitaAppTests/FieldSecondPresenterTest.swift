//
//  FieldSecondPresenterTest.swift
//  QiitaAppTests
//
//  Created by Ayuki Nishioka on 2020/12/01.
//

import XCTest
@testable import QiitaApp

class FieldSecondPresenterTest: XCTestCase {
    
    var router: FieldSecondTransitionRouter!

    override func setUpWithError() throws {
        super.setUp()
        let vc = UIStoryboard(name: "FieldSecond", bundle: nil).instantiateInitialViewController() as! FieldSecondViewController
        router = FieldSecondTransition(viewController: vc)
    }

    override func tearDownWithError() throws {
        super.tearDown()
    }
    
    func testGetArticlesAction_Success() {
        let entities = [ArticleEntity(title: "aaa",
                                      created_at: "111",
                                      url: "http://aaa.com",
                                      user: ArticleEntity.User(id: "1",
                                                               profile_image_url: "http://bbb.com"))]
        let view = View()
        let model = FieldSecondPresenterModelMock(response: .success(entities))
        let presenter = FieldSecondPresenter(view: view, model: model, router: router)
        presenter.getArticlesAction()
        class View: FieldSecondPresenterOutput {
            func completedGetArticlesAction(_ articles: [ArticleEntity]) {
                XCTAssertTrue(true)
            }
            func failedGetArticlesAction(string: String) {
                XCTFail()
            }
        }
    }
    
    func testGetArticlesAction_Failure() {
        
        let view = View()
        let model = FieldSecondPresenterModelMock(response: .failure(NSError()))
        let presenter = FieldSecondPresenter(view: view, model: model, router: router)
        presenter.getArticlesAction()
        class View: FieldSecondPresenterOutput {
            func completedGetArticlesAction(_ articles: [ArticleEntity]) {
                XCTFail()
            }
            func failedGetArticlesAction(string: String) {
                XCTAssertTrue(true)
            }
        }
    }
    
    func testGetArticlesAction_Nil() {
        
        let view = View()
        let model = FieldSecondPresenterModelMock(response: .success(nil))
        let presenter = FieldSecondPresenter(view: view, model: model, router: router)
        presenter.getArticlesAction()
        class View: FieldSecondPresenterOutput {
            func completedGetArticlesAction(_ articles: [ArticleEntity]) {
                XCTFail()
            }
            func failedGetArticlesAction(string: String) {
                XCTAssertTrue(true)
            }
        }
    }
    
    func testGetArticlesAction_None() {
        
        let view = View()
        let model = FieldSecondPresenterModelMock(response: .success([]))
        let presenter = FieldSecondPresenter(view: view, model: model, router: router)
        presenter.getArticlesAction()
        class View: FieldSecondPresenterOutput {
            func completedGetArticlesAction(_ articles: [ArticleEntity]) {
                XCTFail()
            }
            func failedGetArticlesAction(string: String) {
                XCTAssertTrue(true)
            }
        }
    }
    
    func testArticle_Success() {
        let entities = [ArticleEntity(title: "aaa",
                                      created_at: "111",
                                      url: "http://aaa.com",
                                      user: ArticleEntity.User(id: "1",
                                                               profile_image_url: "http://bbb.com"))]
        let view = View()
        let model = FieldSecondPresenterModelMock(response: .success(entities))
        let presenter = FieldSecondPresenter(view: view, model: model, router: router)
        presenter.getArticlesAction()
        class View: FieldSecondPresenterOutput {
            var articles: [ArticleEntity] = []
            func completedGetArticlesAction(_ articles: [ArticleEntity]) {
                self.articles = articles
            }
            func failedGetArticlesAction(string: String) {
                XCTFail()
            }
        }
        let article = presenter.article(forRow: 0)
        XCTAssertNotNil(article)
    }
    
    func testArticle_Nil() {
        let entities = [ArticleEntity(title: "aaa",
                                      created_at: "111",
                                      url: "http://aaa.com",
                                      user: ArticleEntity.User(id: "1",
                                                               profile_image_url: "http://bbb.com"))]
        let view = View()
        let model = FieldSecondPresenterModelMock(response: .success(entities))
        let presenter = FieldSecondPresenter(view: view, model: model, router: router)
        presenter.getArticlesAction()
        class View: FieldSecondPresenterOutput {
            var articles: [ArticleEntity] = []
            func completedGetArticlesAction(_ articles: [ArticleEntity]) {
                self.articles = articles
            }
            func failedGetArticlesAction(string: String) {
                XCTFail()
            }
        }
        let article = presenter.article(forRow: 2)
        XCTAssertNil(article)
    }

}

class FieldSecondPresenterModelMock: FieldSecondModelInput {
    var response: Result<[ArticleEntity]?, Error>!
    
    init(response: Result<[ArticleEntity]?, Error>) {
        self.response = response
    }
        
    func getAPIInformations(page: Int, completion: @escaping (Result<[ArticleEntity]?, Error>) -> Void) {
        completion(self.response)
    }
}
