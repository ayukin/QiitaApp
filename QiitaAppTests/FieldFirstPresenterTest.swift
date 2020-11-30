//
//  FieldFirstPresenterTest.swift
//  QiitaAppTests
//
//  Created by Ayuki Nishioka on 2020/11/22.
//

import XCTest
@testable import QiitaApp

class FieldFirstPresenterTest: XCTestCase {
    
    var router: FieldFirstTransitionRouter!

    override func setUpWithError() throws {
        super.setUp()
        let vc = UIStoryboard(name: "FieldFirst", bundle: nil).instantiateInitialViewController() as! FieldFirstViewController
        router = FieldFirstTransition(viewController: vc)
    }

    override func tearDownWithError() throws {
        super.tearDown()
    }
    
    func testSuccess() {
        let entities = [ArticleEntity(title: "aaa",
                                      created_at: "111",
                                      url: "http://aaa.com",
                                      user: ArticleEntity.User(id: "1",
                                                               profile_image_url: "http://bbb.com"))]
        let view = View()
        let model = FieldFirstPresenterModelMock(response: .success(entities))
        let presenter = FieldFirstPresenter(view: view, model: model, router: router)
        presenter.getArticlesAction()
        class View: FieldFirstPresenterOutput {
            func completedGetArticlesAction(_ articles: [ArticleEntity]) {
                XCTAssertTrue(true)
            }
            func failedGetArticlesAction(string: String) {
                XCTFail()
            }
        }
    }
    
    func testFailure() {
        
        let view = View()
        let model = FieldFirstPresenterModelMock(response: .failure(NSError()))
        let presenter = FieldFirstPresenter(view: view, model: model, router: router)
        presenter.getArticlesAction()
        class View: FieldFirstPresenterOutput {
            func completedGetArticlesAction(_ articles: [ArticleEntity]) {
                XCTFail()
            }
            func failedGetArticlesAction(string: String) {
                XCTAssertTrue(true)
            }
        }
    }
    
    func testNil() {
        
        let view = View()
        let model = FieldFirstPresenterModelMock(response: .success(nil))
        let presenter = FieldFirstPresenter(view: view, model: model, router: router)
        presenter.getArticlesAction()
        class View: FieldFirstPresenterOutput {
            func completedGetArticlesAction(_ articles: [ArticleEntity]) {
                XCTFail()
            }
            func failedGetArticlesAction(string: String) {
                XCTAssertTrue(true)
            }
        }
    }
    
    func testNone() {
        
        let view = View()
        let model = FieldFirstPresenterModelMock(response: .success([]))
        let presenter = FieldFirstPresenter(view: view, model: model, router: router)
        presenter.getArticlesAction()
        class View: FieldFirstPresenterOutput {
            func completedGetArticlesAction(_ articles: [ArticleEntity]) {
                XCTFail()
            }
            func failedGetArticlesAction(string: String) {
                XCTAssertTrue(true)
            }
        }
    }
    
    func testArticleSuccess() {
        let entities = [ArticleEntity(title: "aaa",
                                      created_at: "111",
                                      url: "http://aaa.com",
                                      user: ArticleEntity.User(id: "1",
                                                               profile_image_url: "http://bbb.com"))]
        let view = View()
        let model = FieldFirstPresenterModelMock(response: .success(entities))
        let presenter = FieldFirstPresenter(view: view, model: model, router: router)
        presenter.getArticlesAction()
        class View: FieldFirstPresenterOutput {
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
    
    func testArticleNil() {
        let entities = [ArticleEntity(title: "aaa",
                                      created_at: "111",
                                      url: "http://aaa.com",
                                      user: ArticleEntity.User(id: "1",
                                                               profile_image_url: "http://bbb.com"))]
        let view = View()
        let model = FieldFirstPresenterModelMock(response: .success(entities))
        let presenter = FieldFirstPresenter(view: view, model: model, router: router)
        presenter.getArticlesAction()
        class View: FieldFirstPresenterOutput {
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

class FieldFirstPresenterModelMock: FieldFirstModelInput {
    var response: Result<[ArticleEntity]?, Error>!
    
    init(response: Result<[ArticleEntity]?, Error>) {
        self.response = response
    }
        
    func getAPIInformations(page: Int, completion: @escaping (Result<[ArticleEntity]?, Error>) -> Void) {
        completion(self.response)
    }
}
