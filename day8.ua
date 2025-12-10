FileBlob     ← &fras (⊡1 &args)
Coords       ← ⊜(⊜⋕⊸≠@,) ⊸≠@\n FileBlob
AllDistances ← ⊞(√/+ⁿ2-) Coords Coords

Idx         ← ⇡⧻Coords
Mask        ← ⊞(<)Idx Idx
IdxPairs    ← ∧(⊂°□)≡(□▽⊸≡(¬≍ [0 0])) ⇌× Mask ⊞(⊂)Idx Idx []
Distances   ← ∧(⊂°□) ≡(□▽⊸≠0) ⇌× Mask AllDistances []
SortedEdges ← ⊏ ⍏Distances IdxPairs

PartOne ← ⍢(
  ⊃(°⊂⋅⋅∘|⋅∘|∘)
  ⊃(⟜⋅⋅∘|⋅⋅⋅∘|⋅∘)
  ⊸⊏
  ⊃(⊣⍆|⋅∘|⊢⍆|+1⋅⋅∘)
  ⊸=
  ⍜▽(⋅∘)
  ⊃(⋅∘|∘)
| ⊸<⋕⊡2 &args)

PartOneGroups ← ⊙(◌)◌PartOne 0 Idx SortedEdges
&p $"Day 8 Part 1: _" /×↙¯3⍆⊕⧻ ⊛PartOneGroups PartOneGroups

PartTwo ← ⍢(
  ⊃(°⊂⋅∘|∘)
  ⊃(∘|⋅⋅∘|⋅∘)
  ⊸⊏
  ⊃(⊣⍆|⋅∘|⊢⍆)
  ⊸=
  ⍜▽(⋅∘)
| ⊸(¬≍⍥0⧻Coords))

&p $"Day 8 Part 2: _" /×≡⊢ ⊏ (⊢↙ ¯(+1⧻◌PartTwo Idx SortedEdges) SortedEdges) Coords
