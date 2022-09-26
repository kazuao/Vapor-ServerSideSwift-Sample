import Fluent
import FluentPostgresDriver
import Vapor

// configures your application
public func configure(_ app: Application) throws {
    
    // MARK: Configure Database
    app.databases.use(.postgres(
        hostname: Environment.get("DATABASE_HOST") ?? "localhost",
        port: Environment.get("DATABASE_PORT").flatMap(Int.init(_:)) ?? PostgresConfiguration.ianaPortNumber,
        username: Environment.get("DATABASE_USERNAME") ?? "sample_user",
        password: Environment.get("DATABASE_PASSWORD") ?? "password",
        database: Environment.get("DATABASE_NAME") ?? "sample_db"
    ), as: .psql)


    // MARK: Migration
    app.migrations.add(CreateUserTable())

    // portを変えたい場合
//    app.http.server.configuration.port = 5000

    // register routes
    try routes(app)
}
