//
//  CreateUserTable.swift
//  
//
//  Created by kazunori.aoki on 2022/08/29.
//

import Fluent

struct CreateUserTable: AsyncMigration {

    // MARK: Table Name
    static let user: String = "user"

    // MARK: Column Name
    static let name: FieldKey = "name"
    static let birthday: FieldKey = "birthday"


    // MARK: Prepare
    func prepare(on database: Database) async throws {
        try await database.schema(CreateUserTable.user)
            .id()
            .field(CreateUserTable.name, .string, .required)
            .field(CreateUserTable.birthday, .string)
            .create()
    }

    // MARK: Revert
    func revert(on database: Database) async throws {
        try await database.schema(CreateUserTable.user).delete()
    }
}
