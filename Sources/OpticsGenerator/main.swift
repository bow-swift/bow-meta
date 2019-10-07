import Meta
import Foundation
import Bow
import BowEffects

enum ArgumentsError: Error {
    case incorrectNumber
}

extension ArgumentsError: CustomStringConvertible {
    var description: String {
        switch self {
        case .incorrectNumber: return "Incorrect number of arguments. Provide path to input and output."
        }
    }
}

func getArguments() -> Task<(URL, URL)> {
    Task.invokeEither {
        let urls = CommandLine.arguments.dropFirst()
            .map(URL.init(fileURLWithPath:))
        guard urls.count == 2 else {
            return .left(ArgumentsError.incorrectNumber)
        }
        return .right((urls[0], urls[1]))
    }
}

func generateCopy(_ input: URL, _ output: URL) -> Task<Void> {
    generateCode(forFilesIn: input.path,
                 saveIn: output.appendingPathComponent("CopyGeneration.swift").path)
        .provide(CopyGenerator())
}

func main() -> Task<Void> {
    let input = Task<URL>.var()
    let output = Task<URL>.var()
    
    return binding(
        (input, output) <- getArguments(),
                        |<-generateCopy(input.get, output.get),
        yield:())^
}

main().unsafeRunSyncEither()
    .fold({ error in print("🚫 Finished with error: \(error)") },
          { print("✅ Finished successfully") })