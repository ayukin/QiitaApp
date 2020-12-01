//
//  FieldThirdPresenterTest.swift
//  QiitaAppTests
//
//  Created by Ayuki Nishioka on 2020/12/01.
//

import XCTest
@testable import QiitaApp

class FieldThirdPresenterTest: XCTestCase {
    
    var router: FieldThirdTransitionRouter!

    override func setUpWithError() throws {
        super.setUp()
        let vc = UIStoryboard(name: "FieldThird", bundle: nil).instantiateInitialViewController() as! FieldThirdViewController
        router = FieldThirdTransition(viewController: vc)
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
        let model = FieldThirdPresenterModelMock(response: .success(entities))
        let presenter = FieldThirdPresenter(view: view, model: model, router: router)
        presenter.getArticlesAction()
        class View: FieldThirdPresenterOutput {
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
        let model = FieldThirdPresenterModelMock(response: .failure(NSError()))
        let presenter = FieldThirdPresenter(view: view, model: model, router: router)
        presenter.getArticlesAction()
        class View: FieldThirdPresenterOutput {
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
        let model = FieldThirdPresenterModelMock(response: .success(nil))
        let presenter = FieldThirdPresenter(view: view, model: model, router: router)
        presenter.getArticlesAction()
        class View: FieldThirdPresenterOutput {
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
        let model = FieldThirdPresenterModelMock(response: .success([]))
        let presenter = FieldThirdPresenter(view: view, model: model, router: router)
        presenter.getArticlesAction()
        class View: FieldThirdPresenterOutput {
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
        let model = FieldThirdPresenterModelMock(response: .success(entities))
        let presenter = FieldThirdPresenter(view: view, model: model, router: router)
        presenter.getArticlesAction()
        class View: FieldThirdPresenterOutput {
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
        let model = FieldThirdPresenterModelMock(response: .success(entities))
        let presenter = FieldThirdPresenter(view: view, model: model, router: router)
        presenter.getArticlesAction()
        class View: FieldThirdPresenterOutput {
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

class FieldThirdPresenterModelMock: FieldThirdModelInput {
    var response: Result<[ArticleEntity]?, Error>!
    
    init(response: Result<[ArticleEntity]?, Error>) {
        self.response = response
    }
        
    func getAPIInformations(page: Int, completion: @escaping (Result<[ArticleEntity]?, Error>) -> Void) {
        completion(self.response)
    }
}
