module

public import Width16.Expansion
public import Width16.BinaryWeight
public import Mathlib.RingTheory.Multiplicity
import Mathlib.Tactic

public section

open Finset Polynomial

namespace Width16

/-- Exact 2-divisibility of an integer; all coefficients in the induction may be signed. -/
def ExactTwo (e : ℕ) (z : ℤ) : Prop :=
  (2 : ℤ) ^ e ∣ z ∧ ¬ (2 : ℤ) ^ (e + 1) ∣ z

private theorem correction_dvd :
    ∀ h : Fin 15, h.val ≠ 0 → (2 : ℤ) ^ (pop h.val + 1) ∣ d h.val := by
  decide

private theorem exact_add_correction {e : ℕ} {head tail : ℤ} (hx : ExactTwo e head)
    (ht : (2 : ℤ) ^ (e+1) ∣ tail) : ExactTwo e (tail+head) := by
  constructor
  · exact dvd_add ((pow_dvd_pow (2 : ℤ) (Nat.le_succ e)).trans ht) hx.1
  · intro h
    apply hx.2
    simpa using dvd_sub h ht

/-- Multiplying by any even power of (1+X) preserves the exact central valuation
predicted by the half-degree. This is the induction invariant. -/
theorem centralCount_exact (m b : ℕ) : ExactTwo (pop (15*m+b)) (centralCount m b) := by
  induction m generalizing b with
  | zero =>
    rw [centralCount_zero, Nat.mul_zero, Nat.zero_add, Nat.centralBinom_eq_two_mul_choose]
    obtain ⟨hl, hu⟩ := central_choose_exact b
    constructor
    · exact_mod_cast hl
    · exact_mod_cast hu
  | succ m ih =>
    let k := 15 * (m+1) + b
    have main : ExactTwo (pop k) (centralCount m (b+15)) := by
      have eqn : k = 15*m + (b+15) := by dsimp [k]; omega
      rw [eqn]
      exact ih (b+15)
    let S := (range 15).erase 0
    have tail : (2 : ℤ) ^ (pop k + 1) ∣ ∑ h ∈ S, d h * centralCount m (b+15-h) := by
      apply Finset.dvd_sum
      intro h hh
      obtain ⟨hpos, hr⟩ := mem_erase.mp hh
      have hlt : h < 15 := mem_range.mp hr
      have wh := correction_dvd ⟨h,hlt⟩ hpos
      have wc := (ih (b+15-h)).1
      have hs : h + (15*m+(b+15-h)) = k := by dsimp [k]; omega
      have hweight := pop_add_le h (15*m+(b+15-h))
      rw [hs] at hweight
      have hexp : pop k + 1 ≤ (pop h + 1) + pop (15*m+(b+15-h)) := by omega
      apply (pow_dvd_pow (2 : ℤ) hexp).trans
      rw [pow_add]
      exact mul_dvd_mul wh wc
    rw [centralCount_succ, ← sum_erase_add _ _ (by decide : 0 ∈ range 15)]
    simpa [d, S, k] using exact_add_correction main tail

/-- The lower of the two middle indices is chosen in odd rows, as in the OEIS formula.
In an even row this is the unique middle index. -/
noncomputable def a (n : ℕ) : ℕ :=
  ((∑ i ∈ range 16, (X : Polynomial ℕ)^i)^n).coeff (15*n/2)

private theorem cast_a_even (m : ℕ) : (a (2*m) : ℤ) = centralCount m 0 := by
  let F : Polynomial ℕ := ∑ i ∈ range 16, X^i
  let f := Nat.castRingHom ℤ
  have hf : F.map f = geom16 := by simp [F, f, geom16, Polynomial.map_sum, Polynomial.map_pow]
  have hidx : 15 * (2*m) / 2 = 15*m := by omega
  change ((F^(2*m)).coeff (15*(2*m)/2) : ℤ) = _
  rw [hidx]
  simpa [centralCount, hf, Polynomial.map_pow] using
    (Polynomial.coeff_map (p := F^(2*m)) f (15*m)).symm

/-- In particular the ordinary finite 2-adic valuation is defined at every even row. -/
theorem positive_even (m : ℕ) : 0 < a (2*m) := by
  have h := (centralCount_exact m 0).2
  rw [← cast_a_even] at h
  by_contra! hz
  simp [Nat.eq_zero_of_le_zero hz] at h

/-- OEIS A402341: the 2-adic valuation in every even row equals the Hamming weight of 15n/2. -/
theorem conjecture_A402341 (n : ℕ) (hn : Even n) :
    multiplicity 2 (a n) = pop (15*n/2) := by
  obtain ⟨m, hm⟩ := hn
  have he : n = 2*m := by omega
  rw [he]
  have h := centralCount_exact m 0
  rw [Nat.add_zero, ← cast_a_even] at h
  rw [show 15*(2*m)/2 = 15*m by omega]
  apply multiplicity_eq_of_dvd_of_not_dvd
  · exact_mod_cast h.1
  · exact_mod_cast h.2

end Width16

#print axioms Width16.centralCount_exact
#print axioms Width16.conjecture_A402341
