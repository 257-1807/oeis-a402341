module

public import Width16.Expansion
import Mathlib.Algebra.Polynomial.Reverse
import Mathlib.Algebra.BigOperators.Intervals
import Mathlib.Tactic

public section

namespace Width16

open Polynomial Finset
open scoped BigOperators

private theorem geom16_coeff (j : ℕ) : geom16.coeff j = if j ≤ 15 then 1 else 0 := by
  simp [geom16, coeff_X_pow, Nat.lt_succ_iff]

private theorem geom16_degree : geom16.natDegree ≤ 15 := by
  apply Polynomial.natDegree_le_iff_coeff_eq_zero.mpr
  intro i hi
  simp [geom16_coeff, not_le.mpr hi]

private theorem power_degree (m : ℕ) : (geom16^m).natDegree ≤ 15*m :=
  natDegree_pow_le.trans ((Nat.mul_le_mul_left m geom16_degree).trans_eq (Nat.mul_comm _ _))

private theorem reflect_geom16 : reflect 15 geom16 = geom16 := by
  ext i
  rw [coeff_reflect, geom16_coeff, geom16_coeff]
  by_cases hi : i ≤ 15
  · simp [revAt_le hi, hi]
  · simp [revAt_eq_self_of_lt (Nat.lt_of_not_ge hi)]

private theorem reflect_power (m : ℕ) : reflect (15*m) (geom16^m) = geom16^m := by
  induction m with
  | zero =>
    simp only [Nat.mul_zero, pow_zero]
    ext i
    cases i <;> simp
  | succ m ih =>
    rw [Nat.mul_succ, pow_succ, reflect_mul _ _ (power_degree m) geom16_degree, ih, reflect_geom16]

private theorem square_coeff_le (P : Polynomial ℤ) (N j : ℕ) (hdeg : P.natDegree ≤ N)
    (hsymm : ∀ i ≤ N, P.coeff (N-i) = P.coeff i) :
    (P*P).coeff j ≤ (P*P).coeff N := by
  let c := P.coeff
  have hcenter : (P*P).coeff N = ∑ i ∈ range (N+1), c i ^ 2 := by
    rw [coeff_mul, Finset.Nat.sum_antidiagonal_eq_sum_range_succ_mk]
    apply sum_congr rfl
    intro i hi
    simp [c, hsymm i (mem_range_succ_iff.mp hi), pow_two]
  have hbound : (∑ i ∈ range (j+1), c i ^ 2) ≤ ∑ i ∈ range (N+1), c i ^ 2 := by
    by_cases hj : j ≤ N
    · exact Finset.sum_le_sum_of_subset_of_nonneg (range_mono (by omega)) fun _ _ _ => sq_nonneg _
    · apply le_of_eq
      symm
      apply Finset.sum_subset (range_mono (by omega))
      intro i _ hi
      have hz : P.coeff i = 0 :=
        coeff_eq_zero_of_natDegree_lt (lt_of_le_of_lt hdeg (by simpa using hi))
      simp [c, hz]
  have hflip : (∑ i ∈ range (j+1), (c (j-i))^2) = ∑ i ∈ range (j+1), (c i)^2 := by
    simpa using Finset.sum_range_reflect (fun i => c i ^ 2) (j+1)
  have hadd := Finset.sum_le_sum (s := range (j+1)) (fun i _ =>
    (show 2 * (c i * c (j-i)) ≤ c i ^ 2 + c (j-i) ^ 2 by nlinarith [sq_nonneg (c i - c (j-i))]))
  rw [Finset.sum_add_distrib, hflip, ← Finset.mul_sum] at hadd
  rw [hcenter, coeff_mul, Finset.Nat.sum_antidiagonal_eq_sum_range_succ_mk]
  change ∑ i ∈ range (j+1), c i * c (j-i) ≤ ∑ i ∈ range (N+1), c i^2
  omega

/-- For every even power, the central coefficient dominates every coefficient of that polynomial. -/
theorem coeff_le_central (m j : ℕ) :
    (geom16^(2*m)).coeff j ≤ (geom16^(2*m)).coeff (15*m) := by
  rw [two_mul, pow_add]
  apply square_coeff_le _ _ _ (power_degree m)
  intro i hi
  have h := congrArg (fun P : Polynomial ℤ => P.coeff i) (reflect_power m)
  simpa only [coeff_reflect, revAt_le hi] using h

end Width16
