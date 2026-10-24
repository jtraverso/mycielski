# Local verification

Verified on 2026-10-23 with Lean `v4.35.0-rc3` and Mathlib
`c55e6e786f49471c72fbddbec5415808896aec1e`.

| Check | Result |
| --- | --- |
| `lake build --wfail` | Passed for the complete Solution proof libraries |
| `lake build Challenge` | Passed; eight expected statement-placeholder warnings |
| `lake env lean Audit.lean` | Passed, including empty-input and first-iteration examples |
| `lake comparator --config comparator.json` | Passed in the default bubblewrap sandbox |
| Comparator's NanoDa check | Accepted the Solution export |
| Comparator's Lean kernel check | Accepted the Solution export |
| `LEAN_NUM_THREADS=4 lake env leanchecker Mycielski` | Passed, exit code 0 |
| Solution-source scan for placeholders, custom axiom declarations and native decisions | No matches |

Comparator checked all eight declarations in `comparator.json`. Their statements
and the transitive values of their mathematical definitions agree with the
independently compiled Challenge. No definition holes are permitted. Its axiom
check excludes `sorryAx`; only `propext`, `Classical.choice` and `Quot.sound` are
permitted. `Audit.lean` prints the axiom dependencies of the same eight theorems.

The eight `sorry` placeholders occur only in `Challenge.lean`, as the Palomar
Challenge/Solution protocol expects. Solution never imports Challenge.
The compiled Solution proof library has no proof placeholders or custom axioms.
The extra bundled `leanchecker` replay uses Lean's kernel; the distinct NanoDa
check is performed by Comparator.

`verification/comparator.log` records the successful sandboxed Comparator run;
`verification/axioms.log` records the separate audit. These are local evidence,
not reports issued by Palomar.

The finite chromatic-number increment includes the empty graph. The palette
equivalence is proved for arbitrary vertex types. The explicit family starts
with `K₂`, has `3*2^n-1` vertices at step `n`, is triangle-free, and has chromatic
number `n+2`.

No result from the reserved repositories or from the author's other account is
assumed. No independent human mathematical review has been performed.

Palomar submission, automated editorial review, registration and Lean Pool
integration have not been performed. The pinned `palomar-preflight.yml` workflow
provides the same mechanical preflight interface used by earlier submissions;
it must be run against the exact public commit after publication.
