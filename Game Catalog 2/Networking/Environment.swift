import Foundation

class AppEnvironment {
    static let shared = AppEnvironment()
    private var variables: [String: String] = [:]

    private init() {
        loadEnv()
    }

    private func loadEnv() {
        guard let path = Bundle.main.path(forResource: ".env", ofType: nil) else {
            print("❌ .env file not found")
            return
        }

        do {
            let content = try String(contentsOfFile: path)
            let lines = content.components(separatedBy: .newlines)

            for line in lines {
                if line.trimmingCharacters(in: .whitespaces).isEmpty || line.hasPrefix("#") {
                    continue
                }

                let parts = line.components(separatedBy: "=")
                if parts.count == 2 {
                    let key = parts[0].trimmingCharacters(in: .whitespaces)
                    let value = parts[1].trimmingCharacters(in: .whitespaces)
                    variables[key] = value
                }
            }
        } catch {
            print("❌ Failed to load .env: \(error)")
        }
    }

    func get(_ key: String) -> String? {
        return variables[key]
    }
}
