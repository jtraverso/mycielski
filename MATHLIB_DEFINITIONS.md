# Imported mathematical definitions

The following verbatim excerpts use Mathlib at the pinned revision
`c55e6e786f49471c72fbddbec5415808896aec1e` (Apache-2.0).
They record the material imported graph notions used by `Challenge.lean`.
`ℕ∞` is the extended natural numbers, with infinity `⊤`; for finite graphs the
chromatic number below is finite. `Fin n` is the type of naturals smaller than n.
`Fintype` supplies an enumeration, while `Finite` merely asserts finiteness.
`Nonempty` asserts existence without choosing an element. A set is pairwise
adjacent when every two distinct members are adjacent. Project-specific graph
and family definitions are given in full in the independent Challenge itself.

## SimpleGraph

[Mathlib/Combinatorics/SimpleGraph/Basic.lean:88](https://github.com/leanprover-community/mathlib4/blob/c55e6e786f49471c72fbddbec5415808896aec1e/Mathlib/Combinatorics/SimpleGraph/Basic.lean#L88)

```lean

/-- A simple graph is an irreflexive symmetric relation `Adj` on a vertex type `V`.
The relation describes which pairs of vertices are adjacent.
There is exactly one edge for every pair of adjacent vertices;
see `SimpleGraph.edgeSet` for the corresponding edge set.
-/
@[ext, aesop safe constructors (rule_sets := [SimpleGraph]), wikidata Q141488]
structure SimpleGraph (V : Type u) where
  /-- The adjacency relation of a simple graph. -/
  Adj : V → V → Prop
  symm : Std.Symm Adj := by aesop_graph
  loopless : Std.Irrefl Adj := by aesop_graph

initialize_simps_projections SimpleGraph (Adj → adj)
```

## Complete graph

[Mathlib/Combinatorics/SimpleGraph/Basic.lean:330](https://github.com/leanprover-community/mathlib4/blob/c55e6e786f49471c72fbddbec5415808896aec1e/Mathlib/Combinatorics/SimpleGraph/Basic.lean#L330)

```lean
/-- The complete graph on a type `V` is the simple graph with all pairs of distinct vertices. -/
@[wikidata Q45715]
abbrev completeGraph (V : Type u) : SimpleGraph V := ⊤
```

## Adjacency in the complete graph

[Mathlib/Combinatorics/SimpleGraph/Basic.lean:337](https://github.com/leanprover-community/mathlib4/blob/c55e6e786f49471c72fbddbec5415808896aec1e/Mathlib/Combinatorics/SimpleGraph/Basic.lean#L337)

```lean
@[simp]
theorem top_adj (v w : V) : (⊤ : SimpleGraph V).Adj v w ↔ v ≠ w :=
  Iff.rfl
```

## Relation homomorphism

[Mathlib/Order/RelIso/Basic.lean:44](https://github.com/leanprover-community/mathlib4/blob/c55e6e786f49471c72fbddbec5415808896aec1e/Mathlib/Order/RelIso/Basic.lean#L44)

```lean
/-- A relation homomorphism with respect to a given pair of relations `r` and `s`
is a function `f : α → β` such that `r a b → s (f a) (f b)`. -/
structure RelHom {α β : Type*} (r : α → α → Prop) (s : β → β → Prop) where
  /-- The underlying function of a `RelHom` -/
  toFun : α → β
  /-- A `RelHom` sends related elements to related elements -/
  map_rel' : ∀ {a b}, r a b → s (toFun a) (toFun b)
```

## Graph homomorphism

[Mathlib/Combinatorics/SimpleGraph/Maps.lean:290](https://github.com/leanprover-community/mathlib4/blob/c55e6e786f49471c72fbddbec5415808896aec1e/Mathlib/Combinatorics/SimpleGraph/Maps.lean#L290)

```lean
/-- A graph homomorphism is a map on vertex sets that respects adjacency relations.

The notation `G →g G'` represents the type of graph homomorphisms. -/
abbrev Hom :=
  RelHom G.Adj G'.Adj
```

## Proper coloring

[Mathlib/Combinatorics/SimpleGraph/Coloring/Vertex.lean:70](https://github.com/leanprover-community/mathlib4/blob/c55e6e786f49471c72fbddbec5415808896aec1e/Mathlib/Combinatorics/SimpleGraph/Coloring/Vertex.lean#L70)

```lean
variable {V : Type u} (G : SimpleGraph V) {n : ℕ}
/-- An `α`-coloring of a simple graph `G` is a homomorphism of `G` into the complete graph on `α`.
This is also known as a proper coloring.
-/
abbrev Coloring (α : Type v) := G →g completeGraph α
```

## Finite colorability

[Mathlib/Combinatorics/SimpleGraph/Coloring/Vertex.lean:160](https://github.com/leanprover-community/mathlib4/blob/c55e6e786f49471c72fbddbec5415808896aec1e/Mathlib/Combinatorics/SimpleGraph/Coloring/Vertex.lean#L160)

```lean

variable (G) in
/-- Whether a graph can be colored by at most `n` colors. -/
def Colorable (n : ℕ) : Prop := Nonempty (G.Coloring (Fin n))
```

## Chromatic number

[Mathlib/Combinatorics/SimpleGraph/Coloring/Vertex.lean:207](https://github.com/leanprover-community/mathlib4/blob/c55e6e786f49471c72fbddbec5415808896aec1e/Mathlib/Combinatorics/SimpleGraph/Coloring/Vertex.lean#L207)

```lean
variable (G) in
/-- The chromatic number of a graph is the minimal number of colors needed to color it.
This is `⊤` (infinity) iff `G` isn't colorable with finitely many colors.

If `G` is colorable, then `ENat.toNat G.chromaticNumber` is the `ℕ`-valued chromatic number. -/
noncomputable def chromaticNumber : ℕ∞ := ⨅ n ∈ Set.ofPred G.Colorable, (n : ℕ∞)
```

## Clique

[Mathlib/Combinatorics/SimpleGraph/Clique.lean:47](https://github.com/leanprover-community/mathlib4/blob/c55e6e786f49471c72fbddbec5415808896aec1e/Mathlib/Combinatorics/SimpleGraph/Clique.lean#L47)

```lean
/-- A clique in a graph is a set of vertices that are pairwise adjacent. -/
abbrev IsClique (s : Set α) : Prop :=
  s.Pairwise G.Adj
```

## Clique of prescribed order

[Mathlib/Combinatorics/SimpleGraph/Clique.lean:245](https://github.com/leanprover-community/mathlib4/blob/c55e6e786f49471c72fbddbec5415808896aec1e/Mathlib/Combinatorics/SimpleGraph/Clique.lean#L245)

```lean
/-- An `n`-clique in a graph is a set of `n` vertices which are pairwise connected. -/
structure IsNClique (n : ℕ) (s : Finset α) : Prop where
  isClique : G.IsClique s
  card_eq : #s = n
```

## Clique-freeness

[Mathlib/Combinatorics/SimpleGraph/Clique.lean:378](https://github.com/leanprover-community/mathlib4/blob/c55e6e786f49471c72fbddbec5415808896aec1e/Mathlib/Combinatorics/SimpleGraph/Clique.lean#L378)

```lean
/-- `G.CliqueFree n` means that `G` has no `n`-cliques. -/
def CliqueFree (n : ℕ) : Prop :=
  ∀ t, ¬G.IsNClique n t
```

## Fintype cardinality

[Mathlib/Data/Fintype/Card.lean:39](https://github.com/leanprover-community/mathlib4/blob/c55e6e786f49471c72fbddbec5415808896aec1e/Mathlib/Data/Fintype/Card.lean#L39)

```lean
/-- `card α` is the number of elements in `α`, defined when `α` is a fintype. -/
def card (α) [Fintype α] : ℕ :=
  (@univ α _).card
```

