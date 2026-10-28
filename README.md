# Mycielski's construction in Lean 4

> **Archived (2026-10-28).** This formalization is now part of
> [jtraverso/erdos-girth-chromatic](https://github.com/jtraverso/erdos-girth-chromatic) (version 2 of
> Palomar entry PALOMAR-2026-10-17-000009), together with Erdős' girth–chromatic theorem and the
> Larsen–Propp–Ullman formula for the fractional chromatic number of Mycielski graphs. The library
> `Mycielski/` was merged there unchanged. This repository is kept read-only for reference and was
> not submitted to Palomar.

Author and maintainer: **Juan Pablo Traverso Gianini**.

This project formalizes the construction from J. Mycielski,
*Sur le coloriage des graphs*, Colloquium Mathematicum 3 (1955), 161–162,
[doi:10.4064/cm-3-2-161-162](https://doi.org/10.4064/cm-3-2-161-162).
It constructs finite triangle-free graphs of arbitrarily large chromatic number.
This classical result shows that even excluding triangles places no universal
bound on the number of colors needed to color a graph properly. It is relevant
to researchers in graph coloring and extremal graph theory. No new mathematical
result or priority among formalizations is claimed.

The vertices of `Mycielski.graph G` are the original vertices, a shadow copy,
and an apex. Original-original and original-shadow edges follow adjacency in
`G`; shadows are independent and are all adjacent to the apex.

## Statements of record

The independent `Challenge.lean` imports only pinned Mathlib modules and gives
all project-specific definitions in full. `Solution.lean` imports the actual
proof library and never imports `Challenge`. `comparator.json` selects eight
statements; their types and the transitive definitions they use must agree.

| Declaration in namespace `Mycielski` | Meaning |
| --- | --- |
| `card_vertex` | The construction has `2|V|+1` vertices. |
| `graph_cliqueFree_three_iff` | The construction is triangle-free exactly when `G` is. |
| `colorable_succ_iff` | The construction is `(k+1)`-colorable exactly when `G` is `k`-colorable. |
| `chromaticNumber_graph` | For finite `G`, its chromatic number increases by exactly one. |
| `card_familyVertex` | The family starting at `K₂` has `3*2^n-1` vertices at index `n`. |
| `family_cliqueFree_three` | Every family member is triangle-free. |
| `family_chromaticNumber` | Family member `n` has chromatic number `n+2`. |
| `exists_triangleFree_chromaticNumber_ge` | For every natural `k` there is a finite triangle-free graph with chromatic number at least `k`. |

These statements use Mathlib's standard `SimpleGraph`, `Coloring`, `Colorable`,
`CliqueFree` and `chromaticNumber`; the material imported definitions are
reproduced in `MATHLIB_DEFINITIONS.md`. Chromatic number takes values in `ℕ∞`.
The palette equivalence allows arbitrary vertex types; the stated chromatic
increment assumes only finiteness and includes the empty graph. Its image has
one vertex and chromatic number one. The size formula for the family is stated
as `card + 1 = 3 * 2^n`, avoiding truncated subtraction. The final existence
proof uses family member `k`, which has chromatic number `k+2`, then transfers
it to a vertex type `Fin n`.

The construction and unboundedness consequence formalize Mycielski's result.
Palette equivalence, triangle-freeness reflection and size formulas are proved
here as accompanying statements, without assigning them theorem numbers in the
paper. The project makes no claim to formalize every assertion in that paper.

## Proof architecture

`Mycielski/Basic.lean` defines adjacency, embeds the original layer and proves
triangle-freeness by checking the possible layers of a putative triangle.
`Mycielski/Coloring.lean` extends a coloring by giving the apex a fresh color.
Conversely, from any coloring of the construction it recolors each original
vertex carrying the apex color with its shadow's color. The resulting proper
coloring avoids the apex color. Removing that color from the palette proves
the exact equivalence and hence the finite chromatic-number increment.
`Mycielski/Family.lean` iterates the construction from `K₂` and proves the order,
triangle-freeness and chromatic-number formulas by induction. It concludes
unboundedness after relabeling vertices using Mathlib's finite equivalence.

## Build and verify

Lean `v4.35.0-rc3`; Mathlib tag `v4.35.0-rc3`, commit
`c55e6e786f49471c72fbddbec5415808896aec1e`. All dependencies are pinned in the
committed `lake-manifest.json`.

```sh
lake exe cache get
lake build --wfail
lake build Challenge
lake env lean Audit.lean
lake comparator --config comparator.json
```

On Linux, `scripts/check.sh` runs these checks except the optional cache download.
Comparator requires working `bubblewrap` sandboxing. The toolchain includes
NanoDa, which is required by `enable_nanoda: true` in `comparator.json`.
The default build checks the proof libraries with warnings treated as failures.
The separate Challenge build emits eight expected `sorry` warnings: those are
statement placeholders only. The complete Solution proofs contain no `sorry`,
custom axioms or native-decision certificates. Comparator rejects `sorryAx` in
the Solution and permits only `propext`, `Quot.sound` and `Classical.choice`.

All local checks passed, including sandboxed Comparator, the Lean kernel and
independent NanoDa checking. See `VERIFICATION.md` and the recorded logs in
`verification/`. The GitHub Actions preflight invokes a pinned Palomar verifier
for a selected full commit. A local pass or preflight is not Palomar registration.
Palomar submission, editorial review and registration remain pending.

## Provenance and review

The human author selected and directed the work in Spanish. OpenAI Codex wrote
the definitions, proofs, audit and packaging. No external prover, Aristotle run,
or work from the author's other account was used. The same session reviewed
its own work and ran the checks; no independent human mathematical review has
been performed. AI assistance and scope are recorded in `formalization.yaml`.

This repository contains the substantive development and builds on the pinned
Mathlib infrastructure. No additional formalization repository is a dependency.
No exhaustive search for earlier formalizations has been performed, and no
formalization priority is claimed. It has not been integrated into Lean Pool.

License: Apache-2.0; see `LICENSE`.
