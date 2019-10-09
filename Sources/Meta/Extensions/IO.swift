import BowEffects

extension IO {
    public var env: EnvIO<Any, E, A> {
        EnvIO { _ in self }
    }
}
