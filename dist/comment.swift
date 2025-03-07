import Foundation

struct BuildReport: Codable {
    var buildInfo: BuildInfo
    var warnings: [Warning]
    var errors: [Error]
    var testCoverage: TestCoverage
}

struct BuildInfo: Codable {
    let appName: String
    let version: String
    let number: String
}

struct TestCoverage: Codable {
    let overall: Double
}

struct Error: Codable {
    let description: String
    let path: String?
    let lineNumber: String?
}

struct Warning: Codable {
    let description: String
    let path: String?
    let lineNumber: String?
}

extension BuildReport {
    func toMarkdown() -> String {
        var markdown = "## Verdict ⚖️\n\n"

        // Test Coverage
        markdown += "### 🧪 Test Coverage: **`\((testCoverage.overall))%`**\n\n"

        markdown += "![keanu](\(keanuGif(for: testCoverage.overall)))"

        // Errors Section
        markdown += "---\n\n"
        if !errors.isEmpty {
            markdown += "### 🚨 Errors: **\(errors.count) Found**\n\n"
            markdown += "| 🗂️ Path           | 📝 Description             |\n"
            markdown += "| :---------------- | :------------------------ |\n"
            for error in errors {
                markdown += "| `\(error.path ?? "")` | 💥 \(error.description) |\n"
            }
            markdown += "\n---\n\n"
        }

        // Warnings Section
        if !warnings.isEmpty {
            markdown += "### ⚠️ Warnings: **\(warnings.count) Found**\n\n"
            markdown += "| 🗂️ Path           | 📝 Description                  |\n"
            markdown += "| :---------------- | :----------------------------- |\n"
            for warning in warnings {
                markdown += "| `\(warning.path ?? "")` | ⚠️ \(warning.description) |\n"
            }
            markdown += "\n---\n\n"
        }

        // Automated Scan Completion
        markdown += "🚀 _Automated Scan Complete_\n"

        return markdown
    }

    static var mockBuildReport: BuildReport {
        return BuildReport(
            buildInfo: BuildInfo(
                appName: "MockApp",
                version: "1.0.0",
                number: "100"
            ),
            warnings: [
                Warning(
                    description: "Mock warning",
                    path: "/mock/path/file.swift",
                    lineNumber: "42"
                )
            ],
            errors: [
                Error(
                    description: "Mock error",
                    path: "/mock/path/error.swift",
                    lineNumber: "13"
                )
            ],
            testCoverage: TestCoverage(overall: 95.5)
        )
    }
}

let output = BuildReport.mockBuildReport.toMarkdown()

//print(output)




struct Comment: Codable {
    typealias ID = String

    let token: String
    let repository: String
    let issueNumber: String
    let owner: String
    let body: String
    var id: ID?
}

enum KeanuHappy: String, CaseIterable {
    case wink = "https://media3.giphy.com/media/v1.Y2lkPTc5MGI3NjExNTVoMnViNDQ2MWViYnJpeDIycnNnNHZoeDFjdXd6Znk4aGY4dWt0NCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/NUwoRZzHc2Bws/giphy.gif"
    case thumbsUp = "https://media1.giphy.com/media/v1.Y2lkPTc5MGI3NjExbjlsbjBpbjQ4eDBsdnNncmFlZ3lzY3Rta21mZ3A1MnUzYWdvdTR1cCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/TJrS7r0f6SOthGTiPe/giphy.gif"
    case puppies = "https://media4.giphy.com/media/v1.Y2lkPTc5MGI3NjExbHR1c2VtcGY5aGhrN3JweG52bWN1eGNzN3lwNnl1ZHFra2JjeGpyZiZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/8rFNes6jllJQRnHTsF/giphy.gif"
    case breathtaking = "https://media4.giphy.com/media/v1.Y2lkPTc5MGI3NjExY2k0dnh4OTJ2ZG10aXQ4cjFnaTFwM3NmNjJsb2xnNzZ1cDRhYWNzZCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/hv4TC2Ide8rDoXy0iK/giphy.gif"
    case checkThisOut = "https://media0.giphy.com/media/v1.Y2lkPTc5MGI3NjExanFxZDJ6NnIxcTZwcjRtNmx3azZrczdxbWZ2azc3cWJxZWo2cnM3MSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/kC9Kveaw468cPLxpYE/giphy.gif"

    static var random: Self {
        Self.allCases.randomElement()!
    }
}

enum KeanuMiddle: String, CaseIterable {
    case maybeNot = "https://media0.giphy.com/media/v1.Y2lkPTc5MGI3NjExMWl1NTV0cDBrcGIwMGFiajU5dmMybzRodTlnbWF1NXI4ZnN3Nnh5MSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/TzFul3viUIjMBCpDxb/giphy.gif"
    case dontKnow = "https://media1.giphy.com/media/v1.Y2lkPTc5MGI3NjExZnU5Y28xZ3ZsaTc2bWdwYnNiYW11czk1MTl1MjdpbWpwbHdlbDFycSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/Uiw3z8GpHgHmYRHlSI/giphy.gif"
    case punk = "https://media1.giphy.com/media/v1.Y2lkPTc5MGI3NjExd2IxemU1Y3htNWZueHlvZmRqNTNtdXV6bTgxbDBuY3o3ZW83ZzdmOSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/SsScqzkuGaEqVDJtVJ/giphy.gif"

    static var random: Self {
        Self.allCases.randomElement()!
    }
}

enum KeanuMad: String, CaseIterable {
    case pistol = "https://media1.giphy.com/media/v1.Y2lkPTc5MGI3NjExZ3J2dmNxYjl4anE5cHlrMGFjaXVueXlpdGxkeWFwNGc4aW1lNWVzNyZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/l3q2A93zxqHnFDkuQ/giphy.gif"
    case needAGun = "https://media3.giphy.com/media/v1.Y2lkPTc5MGI3NjExbzIyOG9iejk2cWxvNXp4aHBrbTRjcjNtcjJyOXRoa2ptdXZxcTZ5MiZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/WnMOl2Ogz2x35sPJMk/giphy.gif"

    static var random: Self {
        Self.allCases.randomElement()!
    }
}

func keanuGif(for coveragePercent: Double) -> String {
    if coveragePercent < 50 {
        KeanuMad.random.rawValue
    } else if coveragePercent < 80 {
        KeanuMiddle.random.rawValue
    } else {
        KeanuHappy.random.rawValue
    }
}

func postNew(comment: Comment) async throws -> (Data, URLResponse) {
    let url = URL(string: "https://api.github.com/repos/\(comment.owner)/\(comment.repository)/issues/\(comment.issueNumber)/comments")
    var urlRequest = URLRequest(url: url!)

    urlRequest.setValue("application/vnd.github+json", forHTTPHeaderField: "Accept")
    urlRequest.setValue("Bearer \(comment.token)", forHTTPHeaderField: "Authorization")
    urlRequest.setValue("2022-11-28", forHTTPHeaderField: "X-GitHub-Api-Version")

    urlRequest.httpMethod = "POST"

    let body =
        """
        {
            "body":"\(comment.body)"
        }
        """

    urlRequest.httpBody = Data(body.utf8)

    let data = try await URLSession.shared.data(for: urlRequest)
    return data
}

func update(comment: Comment) async throws -> (Data, URLResponse) {
    let url = URL(string: "https://api.github.com/repos/\(comment.owner)/\(comment.repository)/issues/comments/\(comment.id ?? "")")
    var urlRequest = URLRequest(url: url!)

    urlRequest.setValue("application/vnd.github+json", forHTTPHeaderField: "Accept")
    urlRequest.setValue("Bearer \(comment.token)", forHTTPHeaderField: "Authorization")
    urlRequest.setValue("2022-11-28", forHTTPHeaderField: "X-GitHub-Api-Version")

    urlRequest.httpMethod = "PATCH"

    let body =
        """
        {
            "body":"\(comment.body)"
        }
        """
    urlRequest.httpBody = Data(body.utf8)

    print(urlRequest)

    let data = try await URLSession.shared.data(for: urlRequest)
    return data
}

func getCommentID(for comment: Comment) async throws -> Comment.ID? {
    let url = URL(string: "https://api.github.com/repos/\(comment.owner)/\(comment.repository)/issues/\(comment.issueNumber)/comments")
    var urlRequest = URLRequest(url: url!)

    urlRequest.setValue("application/vnd.github+json", forHTTPHeaderField: "Accept")
    urlRequest.setValue("Bearer: \(comment.token)", forHTTPHeaderField: "Authorization")
    urlRequest.setValue("2022-11-28", forHTTPHeaderField: "X-GitHub-Api-Version")

    urlRequest.httpMethod = "GET"

    let data = try await URLSession.shared.data(for: urlRequest)

    let comments = try JSONDecoder().decode([GitHubComment].self, from: data.0)
    for comment in comments {
        print(comment)
        if comment.body.contains("## Verdict") {
            return "\(comment.id)"
        }
    }
    return nil
}

struct GitHubComment: Decodable {
    let id: Int
    let body: String
}

var coverage: Double = 96

func createComment(token: String, repository: String, issueNumber: String, owner: String) -> Comment {
    return Comment(
        token: token,
        repository: repository,
        issueNumber: issueNumber,
        owner: owner,
        body: output.replacingOccurrences(of: "\n", with: "\\n"),
        id: nil
    )
}

let arguments = CommandLine.arguments
guard arguments.count == 5 else {
    fatalError("Usage: swift comment.swift <token> <repository> <issueNumber> <owner>")
}

let token = arguments[1]
let repository = arguments[2]
let issueNumber = arguments[3]
let owner = arguments[4]

var comment = createComment(token: token, repository: repository, issueNumber: issueNumber, owner: owner)

// Task {
    if let id = try! await getCommentID(for: comment) {
        print("FOUND ID: \(id)")
        comment.id = "\(id)"
    }
    if comment.id != nil {
        let response = try! await update(comment: comment)
        print("DATA: \(String(data: response.0, encoding: .utf8)!)")
    } else {
        let response = try! await postNew(comment: comment)
        print("DATA: \(String(data: response.0, encoding: .utf8)!)")
    }
// }