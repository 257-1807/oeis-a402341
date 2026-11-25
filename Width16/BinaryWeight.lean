module

public import Mathlib.Data.Nat.Choose.Factorization
import Mathlib.Tactic

public section

namespace Width16

/-- The Hamming weight of the base-two expansion (the number of one bits). -/
@[expose] def pop (n : ℕ) : ℕ := (Nat.digits 2 n).sum

@[simp] theorem pop_zero : pop 0 = 0 := by simp [pop]

@[simp] theorem pop_two_mul (n : ℕ) : pop (2 * n) = pop n := by
  rcases n.eq_zero_or_pos with rfl | hn
  · simp
  · simp [pop, Nat.digits_base_mul (by decide : 1 < 2) hn]

private theorem factorial_weight (n : ℕ) : n.factorial.factorization 2 + pop n = n := by
  have h := Nat.sub_one_mul_factorization_factorial (n := n) Nat.prime_two
  have hle := Nat.digit_sum_le 2 n
  simp only [Nat.reduceSub, one_mul] at h
  unfold pop
  omega

/-- A subtraction-free binary Kummer identity. -/
theorem choose_weight (a b : ℕ) :
    ((a + b).choose b).factorization 2 + pop (a + b) = pop a + pop b := by
  have hc : (a + b).choose b ≠ 0 := Nat.choose_ne_zero (by omega)
  have h := congrArg (fun t : ℕ => t.factorization 2)
    (Nat.add_choose_mul_factorial_mul_factorial a b)
  simp only [Nat.factorization_mul (mul_ne_zero hc a.factorial_ne_zero) b.factorial_ne_zero,
    Nat.factorization_mul hc a.factorial_ne_zero, Finsupp.add_apply] at h
  have ha := factorial_weight a
  have hb := factorial_weight b
  have hab := factorial_weight (a+b)
  omega

theorem pop_add_le (a b : ℕ) : pop (a+b) ≤ pop a + pop b := by
  have h := choose_weight a b
  omega

/-- The exact exponent of 2 in the central binomial coefficient is the binary weight. -/
theorem central_choose_exact (n : ℕ) :
    2 ^ pop n ∣ (2*n).choose n ∧ ¬ 2 ^ (pop n+1) ∣ (2*n).choose n := by
  have h := choose_weight n n
  rw [← two_mul, pop_two_mul] at h
  have hc : (2*n).choose n ≠ 0 := Nat.choose_ne_zero (by omega)
  simp only [Nat.prime_two.pow_dvd_iff_le_factorization hc]
  omega

end Width16
