# CLAUDE.md — MtxVec for C++Builder (examples)

Guidance for building, running, and extending these **MtxVec** C++Builder samples
in a fresh checkout. MtxVec is a fast numeric / linear-algebra / DSP library; the
flagship sample is **`MtxVecDemo`**, a VCL app with one form per API area
(vectors/matrices, optimization, FFT/DSP, statistics, scripting, charting, …).

There is **one `MtxVecDemo_BCB<NN>.cbproj` per RAD Studio version**; they all share
the **same `.cpp` / `.h` / `.dfm` sources** — edit a source once and every version
picks it up. Open the project whose suffix matches your IDE.

## Prerequisites

1. **RAD Studio with the C++Builder personality.**
2. **MtxVec for RAD Studio installed for that IDE.** The installer provides the
   generated C++ headers (`MtxVec.hpp`, `Math387.hpp`, …), the package import
   libraries, the runtime DLLs, and adds the required search paths. These samples
   **link against your MtxVec install** — they don't bundle it.
3. **TeeChart** — the charting forms use it (some series use TeeChart **Pro**
   features). RAD Studio ships TeeChart Standard; if you also have a separate
   TeeChart **Pro** installed, only one TeeChart version may be on the C++ search
   path, and it must sit **ahead of** the bundled one (see snags).

## Pick the project that matches your IDE

The suffix is the MtxVec package version; it maps to your RAD Studio install
directory `…\Embarcadero\Studio\<NN>.0\`:

`_BCB17→10.0  _BCB18→11.0  _BCB19→12.0  _BCB20→14.0 (XE6)  _BCB21→15.0  _BCB22→16.0
_BCB23→17.0  _BCB24→18.0  _BCB25→19.0  _BCB26→20.0  _BCB27→21.0  _BCB28→22.0
_BCB29→23.0 (12 Athens)  _BCB37→37.0 (latest)`

## Build & run

**In the IDE:** open `MtxVecDemo_BCB<NN>.cbproj`, choose a **Platform** (`Win32`,
`Win64`, or `Win64x`) and **Config** (`Debug`/`Release`), then Build and Run.

**Command line** — match `rsvars.bat` to the project suffix (`_BCB37` ↔ Studio 37):

```bat
call "C:\Program Files (x86)\Embarcadero\Studio\37.0\bin\rsvars.bat"
msbuild MtxVecDemo_BCB37.cbproj /t:Build /p:Config=Debug /p:Platform=Win64
```

`/t:Build` does the full compile **and link** (produces the `.exe`). `/t:MakeObjs`
only compiles units — handy as a quick syntax check, but it makes no `.exe`.

Platforms & compilers: `Win32` (`bcc32` classic / `bcc32c` modern Clang), `Win64`
(`bcc64`), `Win64x` (`bcc64x` modern Clang; RAD Studio 12 / `_BCB29` and newer).

## Running

The built `.exe` needs the **MtxVec runtime DLLs on `PATH`** (they provide the
LAPACK/MKL-backed math). The MtxVec installer normally adds its `bin` directory to
`PATH`; if the program starts and immediately exits, or Windows reports a missing
DLL, add the MtxVec runtime/bin directory to `PATH`. The demo's data files
(`*.vec`/`*.mtx`/`*.txt`) are copied next to the `.exe` by a post-build step, so run
it from its output folder.

## First-build snags (and fixes)

- **`Fatal: Unable to open file 'UNIT.OBJ'`** or **missing `MtxVec.hpp`** at build:
  MtxVec isn't installed for *this* IDE, or its packages weren't built with C++Builder
  output. Reinstall MtxVec for this RAD Studio version (or rebuild the MtxVec packages
  with C++ output enabled). Also confirm you opened the `_BCB<NN>` matching your IDE.
- **`Unresolved external 'Vcltee::…'`** (e.g. `TCustomSeries::SetColorEachLine`):
  more than one **TeeChart** version is on the C++ search path — the compiler took a
  header from one version and the linker a library from another (mangled-name
  mismatch). Put exactly **one** TeeChart version's include + library paths on the
  C++ search path, listed **ahead of** the RAD Studio default TeeChart so the bundled
  copy can't win.
- **`long long *` / pointer-size signature mismatch** at link: stale or mixed
  per-platform C++ headers (a Win32 header used against a Win64 library or vice
  versa). Rebuild the MtxVec packages so the Win32 and Win64 headers regenerate into
  their own folders, and make sure each platform build uses its own header set.
- Calling the wrong `rsvars.bat` for the project suffix: compile may appear to
  succeed but the link fails — the package libraries live only under the matching
  RAD Studio version.

## Writing your own MtxVec C++ code

Core includes:

```cpp
#include <vcl.h>
#include "MtxVec.hpp"     // TVec, TMtx
#include "Math387.hpp"    // precision types, math helpers, TCplx
#include "MtxExpr.hpp"    // sVector, sMatrix, Vector, Matrix
// domain units as needed, e.g. "Optimization.hpp"
```

Three abstraction levels — **prefer `sVector` / `sMatrix`** (stack objects, automatic
cleanup, operator overloads):

```cpp
sVector v, res;  v.Size(100); v.SetVal(1.0);  res = v; res.Sin();    // high-level (use this)
Vector  mv;                                                          // mid-level (manual lifetime)
TVec*   p = NULL; CreateIt(p); /* … */ FreeIt(p);                    // low-level, pooled alloc
```

`CreateIt`/`FreeIt` use MtxVec's per-thread object pools (faster than `new`/`delete`,
which also work). When you create your **own** C++Builder project (not just building
the demo), link the runtime/import packages the demo `.cbproj` lists under
`AllPackageLibs` — for MtxVec that's `MtxCore<NN>` (plus `MtxTools<NN>` for the visual
components).

Element access, fastest first: `double* a = v.PValues1D(0); a[i]` › `v[i]`
(`operator[]`) › `v.Values(i)` (range-checked, slow).

### Gotchas when writing code

1. **In a callback, don't index the bare `->Values[i]` *field* on a vector the
   library hands you** (optimizers, integrators, etc.). On a `TVec*`, `Values` is a
   `DynamicArray<double>` whose C++ `operator[]` is **bounds-checked in Debug *and*
   Release**, and the library may pass a **sub-range view** whose internal length is
   not a real array header → a false "range" exception, and the program disappears.
   Instead **typecast to `Mtxvec::TVector*` / `Mtxvec::TMatrix*`** (thin subclasses,
   declared in `MtxVec.h`, whose `Values[]` is plain inline pointer math) and keep the
   natural syntax:

   ```cpp
   static double __fastcall MyObjective(TVec* const x, /* … */) {
     Mtxvec::TVector* px = (Mtxvec::TVector*) x;     // qualify: Mtxvec::TVector
     double x0 = px->Values[0], x1 = px->Values[1];  // fast, safe on sub-ranges
     // single precision: px->SValues[i];  matrix: ((Mtxvec::TMatrix*)m)->Values[r][c]
     return 100*Sqr(x1 - Sqr(x0)) + Sqr(1 - x0);
   }
   ```

   Indexing **your own** full vectors (`v[i]`, `v.PValues1D(0)`) is fine — this only
   bites callback parameters. **Always qualify `Mtxvec::TVector`**: unqualified it
   clashes with `System::Math::Vectors::TVector`
   (`error E4085: reference to 'TVector' is ambiguous`). Likewise prefer
   `sVector`/`sMatrix` (or qualify `Mtxexpr::Vector`) to dodge the same clash on `Vector`.

2. **Callback signature differs by RAD Studio version:** the trailing open-array
   length parameter is `const int` before RAD Studio 12 and `const System::NativeInt`
   from RAD Studio 12 on. Guard it so one source compiles everywhere:

   ```cpp
   System::TObject* const *ObjConst,
   #if (__BORLANDC__ >= 0x0770)   // RAD Studio 12+
   const System::NativeInt ObjConst_High
   #else
   const int ObjConst_Size
   #endif
   ```

3. **`double → TVarRec is ambiguous`** with the modern Win32 compiler in
   `Format(...)`/`ARRAYOFCONST`: format the value to a `String` first
   (`FormatFloat("0.00", x)`) and pass strings, never a bare `double`.

4. **Classic `bcc32`:** call no-argument Pascal accessors with `()` —
   `if (!param->IsRealValue())`, not `…IsRealValue`. Many things that look like
   Pascal properties are emitted as methods (`HasRaisedErrors()`, `SeriesCount()`).

5. **Modern Win64 (`bcc64x`):** you cannot mix `__try/__finally` (SEH) with C++
   `try/catch` in the same function — use a pure C++ cleanup pattern
   (`catch(...) { cleanup; throw; }`).

6. **`Round` / `Abs`:** use `Math387::RoundToInt(double) -> int` and `fabs`
   (`<math.h>`); the unqualified `Round`/`Abs` are often unresolved/ambiguous.

7. **`EnsureRange` ambiguous** with mixed integer argument types: copy the operands
   into explicit `int`/`__int64` locals, or qualify `System::Math::EnsureRange`.
