FileBlob     ← &fras (⊡1 &args)
Coords       ← ⊜(⊜⋕⊸≠@,) ⊸≠@\n FileBlob
AllDistances ← ⊞(√/+ⁿ2-) Coords Coords
Idx          ← ⇡⧻Coords
Mask         ← ⊞(<)Idx Idx
IdxPairs     ← ∧(⊂°□)≡(□▽⊸≡(¬≍ [0 0])) × Mask ⊞(⊂)Idx Idx []
Distances    ← ∧(⊂°□) ≡(□▽⊸≠0) × Mask AllDistances []
SortedEdges  ← ⊏ ⍏Distances IdxPairs

MergeJunctionBox ← |2.2 (⍜▽(⋅∘)⊃(⊸=⊙⋅∘|⋅∘)°⊟⇌⍆˜⊸⊏⊙°⊂)

PartOneGroups ← ⊙◌ ⍥(MergeJunctionBox) ⋕⊡2&args Idx SortedEdges
&p $"Day 8 Part 1: _" /×↙¯3⍆⊕⧻ ⊛PartOneGroups PartOneGroups

PartTwo ← ⍢(MergeJunctionBox|⊸(¬≍⍥0⧻Coords))
&p $"Day 8 Part 2: _" /×≡⊢⊏(⊢↙¯(+1⧻◌PartTwo Idx SortedEdges) SortedEdges) Coords
