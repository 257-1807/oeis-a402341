# A402341 的原始记录与相关定理核查

检索日期为 2026-11-25。核查对象是 Sajid Khan Hussain 对偶数指数的猜想。写 $n=2m$，它断言

$$
v_2\!\left([x^{15m}](1+x+\cdots+x^{15})^{2m}\right)=s_2(15m)
$$

对每个 $m\ge0$ 成立，其中 $s_2$ 是二进制数位和。在下列公开记录中，未找到此前已经给出这个等式的全参数证明或反例。该结论限于列明的来源和检索日期，不能用来认定全球首发。

## OEIS 和作者发布的资料

- OEIS 历史页的修订 #2 载有偶数指数的估值猜想。修订 #13（2026-11-17）仍把它列为 conjecture，说明作者已检验 $n\le1500$。同一条目还给出 $a(n)$ 为奇数的充要条件及其 Lucas 定理证明。该奇偶分类决定哪些项的估值为零；这里研究的猜想给出每个偶数指数的完整估值。[早期修订](https://oeis.org/history/view?seq=A402341&v=2) · [OEIS 全部修订](https://oeis.org/history?seq=A402341) · [官方导出的不可变版本](https://raw.githubusercontent.com/oeis/oeisdata/85deec2fc1f93c9f10dee75501f7059dab264784/seq/A402/A402341.seq)
- 审阅作者仓库在 `8981e05f6880086891a13e5e663c0db36750b5fb` 的完整文件树、发布版本和两份数学说明。项目处理中央系数的奇偶、宽度 6 和 14 的情形，以及奇数乘子下的包含关系。作者把宽度 16 标为 A402341。两个 Zenodo 发布版 v1.0.0 与 v1.0.1 均以奇偶自动机和包含关系为主题。查阅其程序及证明文字，未见对偶数行任意正估值的所求断言。[不可变仓库快照](https://github.com/Sajidsaj/central-coefficient-parity/tree/8981e05f6880086891a13e5e663c0db36750b5fb) · [奇偶自动机说明](https://github.com/Sajidsaj/central-coefficient-parity/blob/8981e05f6880086891a13e5e663c0db36750b5fb/docs/PARITY_AUTOMATA.md) · [Zenodo v1.0.0](https://doi.org/10.5281/zenodo.24416401) · [Zenodo v1.0.1](https://doi.org/10.5281/zenodo.24435433)
- 另读 A077042 及 A402341 的 13 条 `Cf.` 引用，并补查宽度 4 的 A005721、A008287。检索各条目中的 `2-adic`、`valuation`、`powers of 2`、`A000120`、`binary weight`、`Kummer`、`Lucas`。A077042 给出所有宽度的阵列，A005721 给出四项式偶次的中央系数；在所查条目中未发现可直接涵盖本猜想的估值定理。[A077042](https://oeis.org/A077042) · [A005721](https://oeis.org/A005721) · [A008287](https://oeis.org/A008287)

## 三组容易混淆的相关结果

| 来源 | 适用范围以及和本问题的关系 |
|---|---|
| Atsushi Yamagami、Kazuki Taniguchi，*On a Generalization of a Lucas’ Result and an Application to the 4-Pascal’s Triangle*，2020 | 第 2 定理研究同一个 $p^e$ 项多项式，给出整行系数都为 $1\pmod p$ 的行号分类。取 $p=2,e=4$ 即包含宽度 16。第 3 定理研究宽度 4 的特定奇数行模 4 的模式。这两项结论都不决定宽度 16 每个偶数行中央系数被 2 整除的精确次数。[全文，定理 2、3](https://doi.org/10.3390/sym12020288) |
| Steffen Eger，*Some Elementary Congruences for the Number of Weighted Integer Compositions*，2015 | 其扩展二项式包括 $[x^j](1+\cdots+x^{15})^n$。第 5 定理处理奇偶。第 7、13 定理给出模 $p$ 同余，第 14 定理是带重新赋权的模 $p^2$ 同余。文中未列出对本偶数中央系数的任意精度精确估值。[Journal of Integer Sequences 18，15.4.1](https://cs.uwaterloo.ca/journals/JIS/VOL18/Eger/eger11.pdf) |
| Armin Straub、Tewodros Amdeberhan、Victor H. Moll，*The p-adic valuation of k-central binomial coefficients* | 其 $k$-central 数由单变量生成函数 $(1-k^2x)^{-1/k}$ 定义。$k=2$ 给出普通中央二项式，此时 $v_2{2j\choose j}=s_2(j)$ 是相关的经典工具。该文中 $k=16$ 的对象与 A402341 定义的十六项式中央系数不同。[arXiv:0811.2028](https://arxiv.org/abs/0811.2028) |

还查询了 `extended binomial coefficients 2-adic central`、`central quadrinomial binary weight`、`power of two Pascal triangle exact central valuation`、`central coefficient dice 2-adic valuation` 和 `ordinary multinomials Lucas theorem prime powers`，借以核对没有引用 OEIS 编号的结果。OEIS 给出的关于反链的历史文献解释了系数的组合意义，题录中的 1951 年论文未被当作估值结论。

## 数据库和形式化代码

| 平台 | 检索与观察 |
|---|---|
| arXiv / OpenAlex / DataCite / Figshare | arXiv 文字检索 `A402341` 及 `"central coefficient" "2-adic valuation"` 没有返回题名。OpenAlex 以序号及 `"central coefficient" "2-adic valuation" "power"` 搜索均报零。DataCite 和 Figshare 的精确序号查询也未返回条目；通过作者仓库仍定位到了上列两个 Zenodo 版本。Semantic Scholar 请求返回 HTTP 429，Zenodo 的直接搜索端点返回 HTTP 403。[OpenAlex](https://api.openalex.org/works?search=A402341) · [DataCite](https://api.datacite.org/dois?query=A402341) · [arXiv](https://arxiv.org/search/?query=A402341&searchtype=all) |
| MathOverflow / Math Stack Exchange | Stack Exchange 公共 API 在两个站点以 `A402341` 检索，均无结果。[MathOverflow](https://api.stackexchange.com/2.3/search/advanced?site=mathoverflow&q=A402341) · [Math Stack Exchange](https://api.stackexchange.com/2.3/search/advanced?site=math&q=A402341) |
| GitHub 仓库、议题、提交 | 读我中检索序号定位到题目的作者仓库。全站议题和提交的精确序号无相关记录。另查 `"A402341" "OEIS"` 与限定 trureturing 仓库的 `A402341`，均为零。以 `"15*n/2" "A000120"` 搜到的一则预注册问题研究 Mikhail Kurkov 的变换，正文的数位和引用未提出本题。[仓库检索](https://api.github.com/search/repositories?q=A402341+in%3Areadme) · [trureturing 议题检索](https://api.github.com/search/issues?q=A402341+repo%3Athe-omega-institute%2Ftrureturing) · [Kurkov 问题](https://github.com/the-omega-institute/trureturing/issues/29156) |
| GitHub 已授权代码检索 | `"A402341" "theorem"` 命中三份文件。所含唯一 Lean 文件把字串 `a402341` 包含在较长的十六进制数据字面量内；另外两份是 SAT 求解器文档。`"A402341" "valuation"` 的返回内容为数据或哈希字串碰撞。未找到此偶数估值猜想的 Lean 证明。[Lean 命中文件](https://github.com/jacobalansussman/wht-power-saving-lean/blob/0788bc656827ff2e7e44f5a77299eea19f0002fe/package/leverAFc/overlay/Work/XHostT/Data/H2979Fc/P1.lean) |
| Lean Zulip / Mathlib | 在所有 web-public 频道查 `A402341`、`A077042`、`quadrinomial coefficients`，各得零条；`central polynomial coefficients` 匹配十条宽泛的成果或进度消息，未见此题。四次检索均报告已到达最早记录且无历史截断。Mathlib v4.36.0 本地源码检索 `A402341`、`A077042`、`central quadrinomial`、`central polynomial coefficients` 未命中。Mathlib 对普通二项式、阶乘及素因数次数提供通用工具。[Zulip 公开检索](https://leanprover.zulipchat.com/#narrow/channels/web-public/search/A402341) · [固定 Mathlib 源码](https://github.com/leanprover-community/mathlib4/tree/fc4f59e577feb1a4956671bc04ac18aaaf8cd842) |

Google Scholar 的结果与网页检索入口的可访问性另见[逐平台记录](prior-art.md)。
