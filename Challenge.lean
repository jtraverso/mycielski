/-
Copyright (c) 2026 Juan Pablo Traverso Gianini. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Juan Pablo Traverso Gianini
-/
module

public import Mathlib.Combinatorics.SimpleGraph.Coloring.Vertex
public import Mathlib.Data.Fintype.Option

/-!
# Mycielski (1955): triangle-free graphs with unbounded chromatic number

This independent statement file imports only pinned Mathlib modules. It reproduces
all project definitions used in the statements, with their complete values.
The eight theorem placeholders are intentional Challenge declarations; their
proofs live in Solution, which never imports Challenge. Comparator must compare
the statements and their transitive definition dependencies, and reject sorryAx
in every Solution proof.

The graph has an original and a shadow copy of each vertex, plus an apex.
Only shadows meet the apex, shadows are independent, and the other edges follow
G. The operation preserves and reflects triangle-freeness, increases the finite
chromatic number by one, and is (k+1)-colorable exactly when G is k-colorable.
These statements include empty input graphs. Iterating from K₂ gives graphs
with 3*2^n-1 vertices and chromatic number n+2, proving unboundedness.

Source: J. Mycielski, Sur le coloriage des graphs, Colloquium Mathematicum
3 (1955), 161–162, doi:10.4064/cm-3-2-161-162. This formalizes the classical
construction and its consequences; it asserts no new mathematical result or
priority among formalizations. See README.md for scope, proof architecture,
production and review disclosures, and MATHLIB_DEFINITIONS.md for imported notions.
-/

@[expose] public section

namespace Mycielski
open SimpleGraph
universe u

/-- The two layers of vertices, together with the new apex. -/
abbrev Vertex (V : Type u) := Option (V × Bool)

/-- Adjacency in the Mycielski construction. -/
def Adj {V : Type u} (G : SimpleGraph V) : Vertex V → Vertex V → Prop
  | some (v, false), some (w, false) => G.Adj v w
  | some (v, false), some (w, true) => G.Adj v w
  | some (v, true), some (w, false) => G.Adj v w
  | none, some (_, true) => True
  | some (_, true), none => True
  | _, _ => False

/-- The Mycielski graph of `G`. -/
def graph {V : Type u} (G : SimpleGraph V) : SimpleGraph (Vertex V) where
  Adj := Adj G
  symm := ⟨by
    rintro (_ | ⟨v, bv⟩) (_ | ⟨w, bw⟩) <;>
      (try cases bv) <;> (try cases bw) <;>
      simp only [Adj] <;> first | exact id | exact G.adj_symm⟩
  loopless := ⟨by
    rintro (_ | ⟨v, b⟩)
    · simp [Adj]
    · cases b <;> simp [Adj]⟩

/-- Vertex types of the iterated construction, starting from `K₂`. -/
def FamilyVertex : ℕ → Type
  | 0 => Fin 2
  | n + 1 => Vertex (FamilyVertex n)

instance familyVertexFintype : (n : ℕ) → Fintype (FamilyVertex n)
  | 0 => inferInstanceAs (Fintype (Fin 2))
  | n + 1 => by
    letI := familyVertexFintype n
    exact inferInstanceAs (Fintype (Vertex (FamilyVertex n)))

/-- The explicit Mycielski family. -/
def family : (n : ℕ) → SimpleGraph (FamilyVertex n)
  | 0 => ⊤
  | n + 1 => graph (family n)

/-- The construction adds one shadow per vertex and one apex. -/
theorem card_vertex {V : Type u} [Fintype V] :
    Fintype.card (Vertex V) = 2 * Fintype.card V + 1 := by
  sorry

/-- Triangle-freeness is both preserved and reflected. -/
theorem graph_cliqueFree_three_iff {V : Type u} (G : SimpleGraph V) :
    (graph G).CliqueFree 3 ↔ G.CliqueFree 3 := by
  sorry

/-- Mycielski's coloring theorem, expressed using finite palettes. -/
theorem colorable_succ_iff {V : Type u} (G : SimpleGraph V) (k : ℕ) :
    (graph G).Colorable (k + 1) ↔ G.Colorable k := by
  sorry

/-- The chromatic number of a finite graph increases by exactly one. -/
theorem chromaticNumber_graph {V : Type u} [Finite V] (G : SimpleGraph V) :
    (graph G).chromaticNumber = G.chromaticNumber + 1 := by
  sorry

/-- The family has `3 * 2^n - 1` vertices, without truncated subtraction. -/
theorem card_familyVertex (n : ℕ) :
    Fintype.card (FamilyVertex n) + 1 = 3 * 2 ^ n := by
  sorry

/-- Every graph in the explicit family is triangle-free. -/
theorem family_cliqueFree_three (n : ℕ) : (family n).CliqueFree 3 := by
  sorry

/-- Exact chromatic numbers of the explicit family. -/
theorem family_chromaticNumber (n : ℕ) : (family n).chromaticNumber = (n + 2 : ℕ) := by
  sorry

/-- Finite triangle-free graphs have unbounded chromatic number. -/
theorem exists_triangleFree_chromaticNumber_ge (k : ℕ) :
    ∃ (n : ℕ) (G : SimpleGraph (Fin n)), G.CliqueFree 3 ∧ (k : ℕ∞) ≤ G.chromaticNumber := by
  sorry

end Mycielski
