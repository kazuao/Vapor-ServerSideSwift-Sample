import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.get { req async in
        "It works!"
    }

    app.get("hello") { req async -> String in
        "Hello, world!"
    }

    app.get("foo") { req async -> Foo in
        return .init(name: "Foo Bar")
    }

    // MARK: Register User
    app.post("user") { req async throws -> UserModel in
        let data = try req.content.decode(UserModel.self)
        print(data)
        let user = UserModel(id: data.id,
                             name: data.name,
                             birthday: data.birthday)
        print(user)
        try await user.save(on: req.db)
        return user
    }

    // MARK: Fetch All Users
    app.get("user") { req -> [UserModel] in
        return try await UserModel.query(on: req.db).all()
    }
}

struct Foo: Content {
    var name: String
}
