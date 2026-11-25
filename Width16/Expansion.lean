module

public import Mathlib.Algebra.Polynomial.Coeff
public import Mathlib.Data.Nat.Choose.Central
import Mathlib.Tactic.Ring
import Mathlib.Tactic.NormNum

@[expose] public section

open scoped BigOperators
open Polynomial

namespace Width16

/-- One copy of the polynomial whose central coefficient defines A402341. -/
noncomputable def geom16 : Polynomial ℤ :=
  ∑ j ∈ Finset.range 16, X ^ j

/-- Coefficients of the square in the basis of shifted binomial powers. -/
def d : ℕ → ℤ
  | 0 => 1
  | 1 => -28
  | 2 => 352
  | 3 => -2624
  | 4 => 12904
  | 5 => -44064
  | 6 => 107104
  | 7 => -186880
  | 8 => 233108
  | 9 => -204528
  | 10 => 122464
  | 11 => -47616
  | 12 => 11088
  | 13 => -1344
  | 14 => 64
  | _ => 0

/-- The auxiliary coefficient includes an even binomial power. Setting b = 0
recovers the central coefficient at even index 2m. -/
noncomputable def centralCount (m b : ℕ) : ℤ :=
  (geom16 ^ (2 * m) * (1 + X) ^ (2 * b)).coeff (15 * m + b)

theorem centralCount_zero (b : ℕ) : centralCount 0 b = (Nat.centralBinom b : ℤ) := by
  simp [centralCount, Nat.centralBinom, Polynomial.coeff_one_add_X_pow]

private theorem square_expansion :
    geom16 ^ 2 = ∑ h ∈ Finset.range 15,
      C (d h) * X ^ h * (1 + X) ^ (30 - 2 * h) := by
  norm_num [geom16, Finset.sum_range_succ, d]
  ring

theorem centralCount_succ (m b : ℕ) :
    centralCount (m + 1) b =
      ∑ h ∈ Finset.range 15, d h * centralCount m (b + 15 - h) := by
  unfold centralCount
  rw [show 2 * (m + 1) = 2 * m + 2 by omega, pow_add, square_expansion,
    Finset.mul_sum, Finset.sum_mul, Polynomial.finsetSum_coeff]
  apply Finset.sum_congr rfl
  intro h hh
  have hlt : h < 15 := Finset.mem_range.mp hh
  have hpow : 2 * (b + 15 - h) = (30 - 2 * h) + 2 * b := by omega
  rw [hpow, pow_add]
  have heq :
      geom16 ^ (2 * m) * (C (d h) * X ^ h * (1 + X) ^ (30 - 2 * h)) *
        (1 + X) ^ (2 * b) =
      C (d h) * ((geom16 ^ (2 * m) *
        ((1 + X) ^ (30 - 2 * h) * (1 + X) ^ (2 * b))) * X ^ h) := by ring
  rw [heq, coeff_C_mul,
    show 15 * (m + 1) + b = (15 * m + (b + 15 - h)) + h by omega, coeff_mul_X_pow]

end Width16
