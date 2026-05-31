# CLAUDE.md — DSP Master for C++Builder (examples)

Guidance for building, running, and extending these **DSP Master** (Dew Signal)
C++Builder samples in a fresh checkout. DSP Master is a signal-processing / DSP
library built on **MtxVec**; the flagship sample is **`BasicDemoW32`**, a VCL app
with one form per area (signal generation, FFT/spectral analysis, filtering,
envelopes, higher-order spectra, playback, scopes, …).

There is **one `BasicDemoW32_CB<NN>.cbproj` per RAD Studio version**; they all share
the **same `.cpp` / `.h` / `.dfm` sources** — edit a source once and every version
picks it up. Open the project whose suffix matches your IDE.

## Prerequisites

1. **RAD Studio with the C++Builder personality.**
2. **DSP Master installed for that IDE.** DSP Master is built on **MtxVec** — the
   samples (and the Signal runtime packages) statically link the MtxVec core
   packages (`MtxCore<NN>`) alongside the Signal ones, so a working DSP Master install
   necessarily provides MtxVec too. The install provides the generated C++ headers
   (`SignalTools.hpp`, `MtxVec.hpp`, …), the package import libraries, the runtime
   DLLs, and the search paths. These samples **link against your install** — they
   don't bundle it.
3. **TeeChart** — the charting / scope forms use it (some series use TeeChart **Pro**
   features). RAD Studio ships TeeChart Standard; if you also have a separate
   TeeChart **Pro** installed, only one TeeChart version may be on the C++ search
   path, and it must sit **ahead of** the bundled one (see snags).

## Pick the project that matches your IDE

The suffix is the package version; it maps to your RAD Studio install directory
`…\Embarcadero\Studio\<NN>.0\`:

`_CB17→10.0  _CB18→11.0  _CB19→12.0  _CB20→14.0 (XE6)  _CB21→15.0  _CB22→16.0
_CB23→17.0  _CB24→18.0  _CB25→19.0  _CB26→20.0  _CB27→21.0  _CB28→22.0
_CB29→23.0 (12 Athens)  _CB37→37.0 (latest)`

## Build & run

**In the IDE:** open `BasicDemoW32_CB<NN>.cbproj`, choose a **Platform** (`Win32`,
`Win64`, or `Win64x`) and **Config** (`Debug`/`Release`), then Build and Run.

**Command line** — match `rsvars.bat` to the project suffix (`_CB37` ↔ Studio 37):

```bat
call "C:\Program Files (x86)\Embarcadero\Studio\37.0\bin\rsvars.bat"
msbuild BasicDemoW32_CB37.cbproj /t:Build /p:Config=Debug /p:Platform=Win64
```

`/t:Build` does the full compile **and link** (produces the `.exe`). `/t:MakeObjs`
only compiles units — handy as a quick syntax check, but it makes no `.exe`.

Platforms & compilers: `Win32` (`bcc32` classic / `bcc32c` modern Clang), `Win64`
(`bcc64`), `Win64x` (`bcc64x` modern Clang; RAD Studio 12 / `_CB29` and newer).

## Running

The built `.exe` needs the **runtime DLLs on `PATH`** (DSP Master + the MtxVec
LAPACK/MKL math). The installer normally adds its `bin` directory to `PATH`; if the
program starts and immediately exits, or Windows reports a missing DLL, add the
install's runtime/bin directory to `PATH`. Demo data files are copied next to the
`.exe` by a post-build step, so run it from its output folder.

## First-build snags (and fixes)

- **`Fatal: Unable to open file 'UNIT.OBJ'`** or **missing `SignalTools.hpp` /
  `MtxVec.hpp`** at build: DSP Master isn't installed for *this* IDE, or its packages
  weren't built with C++Builder output. Reinstall for this RAD Studio version (or
  rebuild the packages with C++ output enabled). Confirm you opened the `_CB<NN>`
  matching your IDE.
- **`Unresolved external 'Vcltee::…'`** (e.g. `TCustomSeries::SetColorEachLine`):
  more than one **TeeChart** version is on the C++ search path — the compiler took a
  header from one version and the linker a library from another (mangled-name
  mismatch). Put exactly **one** TeeChart version's include + library paths on the
  C++ search path, listed **ahead of** the RAD Studio default TeeChart so the bundled
  copy can't win.
- **`long long *` / pointer-size signature mismatch** at link: stale or mixed
  per-platform C++ headers (a Win32 header used against a Win64 library or vice
  versa). Rebuild the packages so the Win32/Win64 headers regenerate into their own
  folders, and make sure each platform build uses its own header set.
- Calling the wrong `rsvars.bat` for the suffix: compile may appear to succeed but
  the link fails — the package libraries live only under the matching RAD Studio
  version.

## Writing your own DSP Master / MtxVec C++ code

Core includes:

```cpp
#include <vcl.h>
#include "MtxVec.hpp"            // TVec, TMtx (MtxVec core)
#include "Math387.hpp"           // precision types, math helpers, TCplx
#include "MtxExpr.hpp"           // sVector, sMatrix, Vector, Matrix
#include "SignalTools.hpp"       // TSignal, TSignalGenerator, …
#include "SignalProcessing.hpp"  // filtering / processing
#include "SignalAnalysis.hpp"    // spectral / analysis
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
`AllPackageLibs` — for DSP Master that's `MtxCore<NN>`, `SignalCore<NN>`,
`SignalTool<NN>` (plus `MtxTools<NN>` for the visual components).

Element access, fastest first: `double* a = v.PValues1D(0); a[i]` › `v[i]`
(`operator[]`) › `v.Values(i)` (range-checked, slow).

### Gotchas when writing code

1. **In a callback, don't index the bare `->Values[i]` *field* on a vector the
   library hands you** (analysis/optimization callbacks, etc.). On a `TVec*`,
   `Values` is a `DynamicArray<double>` whose C++ `operator[]` is **bounds-checked in
   Debug *and* Release**, and the library may pass a **sub-range view** whose internal
   length is not a real array header → a false "range" exception, and the program
   disappears. Instead **typecast to `Mtxvec::TVector*` / `Mtxvec::TMatrix*`** (thin
   subclasses, declared in `MtxVec.h`, whose `Values[]` is plain inline pointer math)
   and keep the natural syntax:

   ```cpp
   Mtxvec::TVector* px = (Mtxvec::TVector*) x;     // qualify: Mtxvec::TVector
   double x0 = px->Values[0], x1 = px->Values[1];  // fast, safe on sub-ranges
   // single precision: px->SValues[i];  matrix: ((Mtxvec::TMatrix*)m)->Values[r][c]
   ```

   Indexing **your own** full vectors (`v[i]`, `v.PValues1D(0)`) is fine — this only
   bites callback parameters. **Always qualify `Mtxvec::TVector`**: unqualified it
   clashes with `System::Math::Vectors::TVector`
   (`error E4085: reference to 'TVector' is ambiguous`). Likewise prefer
   `sVector`/`sMatrix` (or qualify `Mtxexpr::Vector`) to dodge the same clash on `Vector`.

2. **Callback signature differs by RAD Studio version:** a trailing open-array length
   parameter is `const int` before RAD Studio 12 and `const System::NativeInt` from
   RAD Studio 12 on. Guard it so one source compiles everywhere:

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
