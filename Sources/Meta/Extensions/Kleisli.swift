import Bow
import BowEffects

extension Kleisli {
    func widen<DD, E: Error>() -> EnvIO<DD, E, A> where D == Any, F == IOPartial<E> {
        self.contramap(id)
    }
    
    func unsafeRunSync<E: Error>() throws -> A where D == Any, F == IOPartial<E> {
        try self.provide(()).unsafeRunSync()
    }
    
    func unsafeRunSyncEither<E: Error>() -> Either<E, A> where D == Any, F == IOPartial<E> {
        self.provide(()).unsafeRunSyncEither()
    }
    
    func unsafeRunAsync<E: Error>(_ callback: @escaping Callback<E, A>) where D == Any, F == IOPartial<E> {
        self.provide(()).unsafeRunAsync(callback)
    }
}
