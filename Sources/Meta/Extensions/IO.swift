import BowEffects

extension IO {
    var env: EnvIO<Any, E, A> {
        EnvIO { _ in self }
    }
}
