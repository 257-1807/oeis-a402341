# A402341：宽度 16 的中央系数含多少个因子 2？

设 $F(x)=1+x+\cdots+x^{15}$，$a(n)$ 为 $F(x)^n$ 的中央系数。设 $s_2(t)$ 为 $t$ 的二进制表示中 1 的个数。对所有非负偶数 $n$，本项目在 Lean 4 中证明了

$$
\boxed{\nu_2(a(n))=s_2(15n/2)}.
$$

例如 $n=4$ 时，中央系数为 $2736=16\cdot171$，其 2-adic 赋值为 4。另一方面，$15n/2=30=(11110)_2$ 恰有四个 1。[Lean 主定理](Width16/Valuation.lean) · [公理输出](audit/axioms.log)

## 来源与查重

Sajid Khan Hussain 于 2026 年 11 月 17 日在公开问题来源 OEIS A402341 的 COMMENTS 栏提出这个猜想。该条目没有 arXiv 号或独立定理编号。固定快照中第 8 行逐字写道：

> Conjecture: for even n, the 2-adic valuation of a(n) equals A000120(15*n/2). Verified for n <= 1500.

[OEIS 原文](https://oeis.org/A402341) · [固定版本及原句](https://github.com/oeis/oeisdata/blob/be2f360122f661bddebad22b15440935d21ac598/seq/A402/A402341.seq#L8) · [A000120 的定义](https://oeis.org/A000120)

原作者已经给出一般奇偶判据、一个 Chebyshev 展开式和数值数据。本项目使用同一多项式的平方展开，追踪各项能被 2 的哪些幂整除。核查日期为 **2026-11-25**。检索覆盖全部 13 次 OEIS 修订、作者的 GitHub 代码与两次 Zenodo 发布、Google Scholar、arXiv、前向引文、GitHub 代码和议题、MathOverflow、Lean Zulip、Mathlib，并核对了关于广义二项式系数的同余定理。在已核查的公开材料中未找到这一精确赋值猜想的完整先行解答；此判断不确立全球优先权。[原作者项目](https://github.com/Sajidsaj/central-coefficient-parity/tree/8981e05f6880086891a13e5e663c0db36750b5fb) · [检索词与结果](audit/prior-art.md) · [与已有定理的对照](audit/prior-research.md)

## 证明

**辅助系数。** 写 $n=2m$。同时研究一族整数

$$
C(m,b)=[x^{15m+b}]\,F(x)^{2m}(1+x)^{2b},\qquad m,b\ge0.
$$

目标是 $C(m,0)$ 的赋值。引入 $b$ 使展开 $F^2$ 后的每一项仍是同类问题。我们将证明 $\nu_2(C(m,b))=s_2(15m+b)$。

**起点。** $C(0,b)=\binom{2b}{b}$。由 Legendre 公式 $\nu_2(t!)=t-s_2(t)$ 及 $s_2(2b)=s_2(b)$，得到 $\nu_2\binom{2b}{b}=s_2(b)$。同理，$\nu_2\binom{u+v}{u}\ge0$ 给出 $s_2(u+v)\le s_2(u)+s_2(v)$：二进制加法的进位只会减少 1 的个数。[Lean 中的二进制引理](Width16/BinaryWeight.lean)

**平方展开。** 下式是一个次数为 30 的整数多项式恒等式，展开两边即可逐项核对：

$$
F(x)^2=\sum_{h=0}^{14} d_h x^h(1+x)^{30-2h}.
$$

| $h$ | $d_h$ | $\nu_2(d_h)$ | $s_2(h)$ |
|---:|---:|---:|---:|
| 0 | 1 | 0 | 0 |
| 1 | −28 | 2 | 1 |
| 2 | 352 | 5 | 1 |
| 3 | −2624 | 6 | 2 |
| 4 | 12904 | 3 | 1 |
| 5 | −44064 | 5 | 2 |
| 6 | 107104 | 5 | 2 |
| 7 | −186880 | 9 | 3 |
| 8 | 233108 | 2 | 1 |
| 9 | −204528 | 4 | 2 |
| 10 | 122464 | 5 | 2 |
| 11 | −47616 | 9 | 3 |
| 12 | 11088 | 4 | 2 |
| 13 | −1344 | 6 | 3 |
| 14 | 64 | 6 | 3 |

特别地，$d_0=1$，而 $h>0$ 时有 $2^{s_2(h)+1}\mid d_h$。Lean 以整数多项式运算核对展开，再用有限整数运算核查这 14 个整除条件。[展开与系数递推](Width16/Expansion.lean)

**归纳。** 把平方展开代入 $C(m+1,b)$ 并提取相应系数，得到

$$
C(m+1,b)=\sum_{h=0}^{14}d_h C(m,b+15-h).
$$

假定结论对 $m$ 和所有 $b\ge0$ 成立。置 $k=15(m+1)+b$，$e=s_2(k)$。首项 $C(m,b+15)$ 被 $2^e$ 整除而不能被 $2^{e+1}$ 整除。对于每个 $h=1,\ldots,14$，都有 $b+15-h\ge0$，且
$$
(s_2(h)+1)+s_2(k-h)\ \ge\ e+1.
$$
表中的整除条件和归纳假设说明，每一个这样的修正项都被 $2^{e+1}$ 整除。整式相加后，结果模 $2^{e+1}$ 与首项相同，故赋值恰为 $e$。令 $b=0$ 即得原猜想。特别地，$m=b=0$ 时 $C(0,0)=1$，赋值与 $s_2(0)$ 都为零。

## 忠实性与边界

| 原文对象 | Lean 4 对应 | 核对细节 |
|---|---|---|
| 十六个系数全为 1 的多项式 | `geom16` 和 `a` 中的 `∑ i ∈ range 16, X^i` | 指数从 0 到 15。最终函数在自然数系数环中计算；证明通过环同态转入整数系数环，以容纳负数 $d_h$。 |
| 中央（最大）系数 | `a n` 取 `coeff (15*n/2)`；`coeff_le_central` | 指数使用自然数整除。在偶数行中央指数恰为 $15m$。另有 Lean 定理对每个 $m,j$ 证明 $[x^j]F^{2m}\le[x^{15m}]F^{2m}$。 |
| 所有偶数指标，含零 | `conjecture_A402341 (n : ℕ) (hn : Even n)` | 没有行数上限或其他算术假设。`positive_even` 证明这些中央系数严格为正。 |
| 2-adic 赋值 | `multiplicity 2 (a n)` | 核心引理 `centralCount_exact` 同时证明 $2^e$ 整除和 $2^{e+1}$ 不整除；最后调用 Mathlib 的重数刻画。 |
| OEIS A000120 | `pop t = (Nat.digits 2 t).sum` | 以二进制数位和实现，零也有定义。 |

最大性证明利用 $F^m$ 的系数对称性。设 $c_i=[x^i]F^m$，并在支持之外取零。平方后的中央系数为 $\sum_i c_i^2$，任意系数为 $\sum_i c_i c_{j-i}$，由 $2uv\le u^2+v^2$ 即得所需比较。[最大性的完整证明](Width16/Maximum.lean)

## 选题记录

| 检查过的公开候选 | 选择依据与处理 |
|---|---|
| R. J. Mathar，OEIS A401159（三列的多项式公式，2026） | 容斥适合形式化。检索发现两个公开项目已经给出同题证明，因此排除。[在先 Lean 项目](https://github.com/Cameron-Lyons/formal-math-lab/tree/main/three-column-matrices) · [另一份独立工作](https://github.com/nktkt/math/tree/main/research/mathar_three_columns) |
| V. Manto、J. C. McMahon，OEIS A400113（2026，第一条比值观察） | 六个同余类上的仿射公式易于核验。不过 Alper Ferudun 已在第 24 次修订讨论中指出步长为六的二阶递推，这直接给出同一证明路线，故排除。[原文及历史](https://oeis.org/history?seq=A400113) |
| S. K. Hussain，OEIS A402341（2026，偶数行的精确赋值） | 选定。已知展开提示可把中心系数与中央二项式相连，有限平方恒等式和二进制权重的归纳可以在 Mathlib 中完整验证。[原始记录](https://oeis.org/A402341) |

## 复现

Elan 会读取 `lean-toolchain` 并选择 Lean 4.36.0；Mathlib 的固定提交为 `fc4f59e577feb1a4956671bc04ac18aaaf8cd842`。在项目根目录运行下列命令。[Elan 安装说明](https://github.com/leanprover/elan)

```sh
lake exe cache get Mathlib.Tactic Mathlib.Algebra.Polynomial.Reverse Mathlib.Data.Nat.Choose.Factorization Mathlib.Data.Nat.Choose.Central Mathlib.RingTheory.Multiplicity Mathlib.Algebra.BigOperators.Intervals
lake build
lake --wfail build
lake env lean -DwarningAsError=true Width16.lean
for m in BinaryWeight Expansion Maximum Valuation; do
  lake env leanchecker --verbose "Width16.$m" || exit 1
done
python3 scripts/check_coefficients.py
```

Python 独立地从 $F^0=1$ 开始，每次用宽为 16 的滑动窗口求下一行，使用精确整数运算。程序核查了 $n=0,2,\ldots,1600$ 的 801 个偶数指标，并与 OEIS 开头的十项逐项比较。[测试程序](scripts/check_coefficients.py) · [实际输出](audit/numeric.log)

严格构建零错误、零警告。主文件末尾的 `#print axioms` 输出包括

```text
'Width16.conjecture_A402341' depends on axioms: [propext, Classical.choice, Quot.sound]
```

源码审计未发现 `sorry`、`admit` 或自定义公理。所有含证明模块又分别通过编译产物的内核重放。[构建](audit/build.log) · [完整公理清单](audit/axioms.log) · [内核重放](audit/kernel-replay.log)

原创代码和说明采用 Apache-2.0 许可证，OEIS 原题及文献保留出处。[许可证](LICENSE)
