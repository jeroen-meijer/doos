# Doos

> /doːs/ ("dose")

A type-safe local storage library for Dart and Flutter with reactive change streams. Values are serialized to JSON and stored via a configurable storage adapter.

## Tech Stack

- **Dart 3.10+**
- **RxDart** — BehaviorSubject for reactive streams
- **Equatable** — value equality
- **checks** — assertions in tests
- **mocktail** — mocking in tests
- **very_good_analysis** — lint rules

## Key Directories

```
lib/
├── doos.dart              # Main export
└── src/
    ├── doos.dart          # Doos class, DoosStorageEntry, DoosResult
    ├── storage_adapter.dart   # DoosStorageAdapter mixin (write, read, delete, clear)
    ├── json_storage_adapter.dart  # JSON file adapter with in-memory cache
    ├── result.dart       # DoosOk / DoosErr result types
    └── storage_error.dart # Storage error types
test/                      # doos_test, storage_adapter_test, etc.
example/                   # example.dart usage
```

## How It Works

- **Storage adapter pattern** — `DoosStorageAdapter` abstracts the backing store.
- **JSON serialization** — Supported types: `String`, `int`, `double`, `bool`, `List`, `Map`, `null`. Custom types need a `deserializer`.
- **Reactive entries** — `entry.onChange()` returns a stream that emits on value change; uses RxDart `BehaviorSubject`.

## Common Commands

```bash
dart pub get
dart test
```

## Code Standards

- Use `dart` (not `fvm dart`).
- Public API: `Doos`, `DoosStorageEntry`, `DoosStorageAdapter`, `DoosJsonStorageAdapter`.
- Result types: `DoosOk`, `DoosErr` (oxidized-style).
- `@visibleForTesting` used for internal methods exposed for tests only.

## Documentation

- [README.md](README.md) — getting started, usage, storage adapters

## Changelog

`CHANGELOG.md` → `## Upcoming` is the **user-facing draft for the next release**, not a commit diary.

- Write for someone who gets the next package version. Conventional prefixes are fine.
- Lead with what the user can do or notice, not how it was built.
- No implementation jargon (internal names, token ids, patch details) unless the product exposes that name.
- One distinct surface or capability per bullet when they are separate. Do not semicolon-stack unrelated polish onto one feat.
- Fix lines name the symptom the user sees, not the patch mechanism.
- Simplify for end users: short, concrete, scannable.
- **Unshipped work:** edit or merge existing Upcoming bullets. Do not add `fix(X)` under a `feat(X)` that never left Upcoming.
- **After a release:** only then does a later bug fix get its own Upcoming line.
- Prefer fewer, broader bullets. Skip internal-only churn unless consumers notice it.
- Run `/humanize` (or match that skill) on every new or edited Upcoming bullet before you commit. Keep conventional prefixes; the rest should read like a short product note, not a session diary.
- Keep the `## Upcoming` heading forever. On release, move its bullets into `## {version}` (or `## {version} - {YYYY-MM-DD}`) under it.
