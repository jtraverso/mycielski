/-
Copyright (c) 2026 Juan Pablo Traverso Gianini. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Juan Pablo Traverso Gianini
-/
module

import Mycielski

/-! Print the actual kernel dependencies of the principal results. -/

#print axioms Mycielski.card_vertex
#print axioms Mycielski.graph_cliqueFree_three_iff
#print axioms Mycielski.colorable_succ_iff
#print axioms Mycielski.chromaticNumber_graph
#print axioms Mycielski.card_familyVertex
#print axioms Mycielski.family_cliqueFree_three
#print axioms Mycielski.family_chromaticNumber
#print axioms Mycielski.exists_triangleFree_chromaticNumber_ge

-- The empty input graph is also covered: its Mycielski graph has one vertex.
example : (Mycielski.graph (⊥ : SimpleGraph (Fin 0))).chromaticNumber = 1 := by
  rw [Mycielski.chromaticNumber_graph]
  have h : (⊥ : SimpleGraph (Fin 0)) = ⊤ := Subsingleton.elim _ _
  rw [h, SimpleGraph.chromaticNumber_top]
  simp

-- The first nontrivial iterations have the expected chromatic numbers.
example : (Mycielski.family 1).chromaticNumber = 3 := by
  simpa using Mycielski.family_chromaticNumber 1

example : (Mycielski.family 2).chromaticNumber = 4 := by
  simpa using Mycielski.family_chromaticNumber 2
