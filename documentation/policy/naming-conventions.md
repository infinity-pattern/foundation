# Infinity Pattern — Naming Convention Policy (Libraries & Public ABI)

This document defines the naming conventions Infinity Pattern projects should follow for static/shared libraries, 
public symbols, C/C++ namespaces, build artifacts, and packaging. 

---

## High-level Overview

### Versioning:
- Follow Semantic Versioning (SemVer) for library versions: MAJOR.MINOR.PATCH.TWEAK

### Files / packages: 
- lowercase, hyphen-separated, prefixed with `lib` for archive names on Unix. Example:
- libinfinity-pattern-<project>.so
- libinfinity-pattern-<project>.a
- Packaged artifact: infinity-pattern-<project>-1.2.3.tar.gz

### Public API conventions:
- Public C symbol prefix: `ip_` 
  - Examples: ip_init(), ip_context_t
- Public C Macros / header guards: `IP_<PROJECT>_<PATH>_<FILE>_H`
  - Example: `IP_FOUNDATION_ENVIRONMENT_CONTEXT_H` for include/infinity-pattern/foundation/environment/context.hpp
- C++ namespace: `infinity_pattern::<project>`. Use `namespace ip = infinity_pattern;` for brevity.
- CMake target name (exported): `InfinityPattern::<project>`
- pkg-config name: `infinity-pattern-<project>`

### Headers:
- Header include layout: `#include <infinity-pattern/<project>>/<file>.hpp>` (maps to include/infinity-pattern/<project>/<file>.hpp)
- Header guards / macros : all-uppercase with `IP_` prefix. e.g.
    - `IP_<PROJECT>_<SUBDIR**>_<FILE>_H` for a header guard 
    - `IP_<SYMBOL` for macros.

---

## Library filenames (on Unix-like systems)
Format:
- Shared: lib<org>-<project>[-component].so[.<major>[.<minor>[.<patch>]]]
  - Example: libinfinity-pattern-foundation.so.1.2.3
  - Public SONAME symlink: libinfinity-pattern-foundation.so.1 → libinfinity-pattern-foundation.so.1.2.3
  - Build symlink: libinfinity-pattern-foundation.so → libinfinity-pattern-foundation.so.1
- Static: lib<org>-<project>[-component].a
  - Example: libinfinity-pattern-foundation.a

Rules:
- Always lowercase; use hyphens to separate org/project/component.
- Include the org prefix (`infinity-pattern`) to avoid collisions.
- Keep component optional for mono-repo libraries; use it when a single repo builds multiple logical libs 
  (e.g., libinfinity-pattern-crypto-sha.so and libinfinity-pattern-crypto-aes.so).

---

## Library filenames (on Windows)

- Use canonical project name without the `lib` prefix for DLLs (e.g., infinity-pattern-foundation.dll) 
- Use the component name if applicable (e.g., infinity-pattern-crypto-sha.dll).

---

## Executables
- Use the `ip` abbreviation and lowercase + hyphen: `ip-toolname` (e.g., `ip-build-helper`).

---

## Public C API
- Prefix: ip_ 
  - Functions: ip_do_work()
  - Types: ip_Context
  - Enums: ip_Error, IP_ERROR_OK
- Header guards and macro names:
  - Example guard: `#ifndef IP_FOUNDATION_FOO_H` / `#define IP_FOUNDATION_FOO_H`
  - Export macros: `IP_PUBLIC`, `IP_PRIVATE`, `IP_API`, `IP_EXPORT`, `IP_IMPORT` (see visibility below).
- Reasons:
  - Short prefix keeps symbol names readable while avoiding collisions.
  - The prefix is part of the public API — don't change it across major rewrites without aliasing.

Symbol visibility:
- Compile with hidden default visibility and explicitly mark API symbols:
  - Provide macros in a single header (e.g., include/ip/foundation/visibility.hpp):
    - IP_EXPORT / IP_IMPORT (platform detect)
    - IP_PUBLIC for exported API
    - IP_LOCAL for internal-only symbols
- Example:
  - IP_PUBLIC void ip_do_work(ip_context_t *ctx);

---

## Public C++ API
- Namespace: `infinity_pattern::foundation`. e.g. `namespace infinity_pattern::foundation { class Context; }`
- Use `namespace ip = infinity_pattern;` in implementation files for brevity.
- CMake exported target: `InfinityPattern::Foundation`
  - Use `install(TARGETS ... EXPORT InfinityPatternTargets ...)` and provide `InfinityPatternFoundationConfig.cmake`.
- Header layout -> namespaces:
  - include/infinity-pattern/<project>/<file>.hpp → declares infinity_pattern::foundation::Foo
- Template and inline functions must respect the same visibility rules as C symbols when part of the public ABI.

---

## Public Python API (if applicable)

- PyPI name: infinity-pattern-<project>[-<component>] (lowercase hyphenated)
- Import name: `import infinity_pattern_foundation` (use snake_case for imports)
- Map packaging name ↔ import name in README.

---

## Build-system and packaging names
- CMake target: `InfinityPattern::<project>` (CamelCase, namespaced)
- pkg-config name: `infinity-pattern-<project>` (no `lib` prefix)
- CMake config file: `InfinityPattern<Project>Config.cmake` and export set `InfinityPattern<Project>Targets`
- Systemd-style or packaging names: `infinity-pattern-<project>` (lowercase hyphenated)

---

## Versioning & SONAME policy
- Keep a single source of truth for the library version (CMake `project(... VERSION x.y.z.w)`).
- Map semantic-major to SONAME-major. When ABI breaks (change to public headers, symbol removal, incompatible signature changes), increment major → new SONAME.
- Minor/patch changes do not change SONAME major.
- Examples:
  - v1.2.3 → libinfinity-pattern-foundation.so.1.2.3 (SONAME libinfinity-pattern-foundation.so.1)
  - v2.0.0 → libinfinity-pattern-foundation.so.2.0.0 (SONAME libinfinity-pattern-foundation.so.2)

---

## Internal vs public libraries
- Public libs: follow the naming and version policy above.
- Internal/non-installed libs:
  - Add `-internal` suffix or place in an internal namespace: libinfinity-pattern-<project>-internal.a
  - Prefer not to install these to system prefixes; keep them for repo-local use.
- If internal headers are used by multiple components in the repo, place them under `include/ip/foundation/internal/` and mark as "internal" in docs.

---

## Header include paths
- Public headers: install into include/ip/foundation/<headers>
  - Example: `#include <ip/foundation/context.hpp>`
- Internal headers: include/ip/foundation/internal/<headers> and do not install.

---

## Header guards, macro names, and pkg names
- Header guard style: `IP_<COMPONENT>_<FILE>_H` (uppercase with underscores)
  - example: `IP_FOUNDATION_CONTEXT_H`
- CMake target vs package: CMake target `InfinityPattern::Foundation` maps to pkg-config `infinity-pattern-foundation`.

---

## Migration notes (if you already have other names)
- Add compatibility shim symbols with the `ip_` prefix where practical.
- Provide documentation mapping old names → new names and deprecate old sonames over one release cycle.
- Add pkg-config and CMake aliases to ease migration.

---

## Mapping checklist for new repositories
When creating a new library repo, do these steps and document them in the repo README:
- [ ] Set org prefix for filenames and symbols (`infinity-pattern` and `ip_`).
- [ ] Implement visibility header with IP_PUBLIC/IP_LOCAL.
- [ ] Use CMake project version and map major to SONAME.
- [ ] Export `InfinityPattern::ProjectName` CMake target and install config.
- [ ] Put public headers in include/infinity-pattern/<project>/...
- [ ] Name artifacts: libinfinity-pattern-<project>.so / .a
- [ ] Create pkg-config `.pc` file with name `infinity-pattern-<project>` (if applicable).
- [ ] Add a short section in README showing how to link the library and which symbol prefix and namespaces to use.
