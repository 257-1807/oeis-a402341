# A402341 文献与形式化查重

核查日期为 2026-11-25。原题是 Sajid Khan Hussain 于 2026-11-17 发表在 OEIS A402341 的偶数指标猜想。它在第 2 次修订出现，第 13 次修订时仍标为 conjecture。查阅了全部 13 次修订及其公开讨论。在这些修订中，宽 16 的奇偶判据已有证明，中心系数的 Chebyshev 展开及有限数值验证也已给出。在本次检索可见资料中，未发现偶数指标下完整的 2-adic 赋值公式已有证明或反例。[当前词条](https://oeis.org/A402341) · [2026-11-25 仓库快照](https://github.com/oeis/oeisdata/blob/be2f360122f661bddebad22b15440935d21ac598/seq/A402/A402341.seq) · [修订 4 至 13](https://oeis.org/history?seq=A402341) · [修订 1 至 3](https://oeis.org/history?seq=A402341&start=10)

## 同作者的相关工作

Hussain 的 *Parity of central coefficients of (1+x+...+x^(w-1))^n: explicit automata and an inclusion theorem* 于 11 月 21 日发布第一版，11 月 22 日更新。作者证明宽度为 2 的幂时的奇性判据，并给出一般偶宽度的奇偶自动机。奇偶判据可识别 2-adic 赋值为零的情况。作者列出的成果和其源文件均未给出这里偶数指标上每一个赋值的精确数值。OEIS 自带的中心二项式基展开是相关先行工作；本项目用的是该展开平方后的十五个整数权重。[作者工作记录](https://doi.org/10.5281/zenodo.24416400) · [作者 GitHub 快照](https://github.com/Sajidsaj/central-coefficient-parity/tree/8981e05f6880086891a13e5e663c0db36750b5fb)

## 查询记录

| 范围 | 查询和结果 |
|---|---|
| arXiv | 分别查询 `A402341` 和 `"central coefficient" "2-adic valuation"`，未得到匹配的预印本。另用作者名、`(1+x+...+x^15)^n`、`central quadrinomial`、`extended binomial coefficients`、`even n`、`popcount`、`15n/2` 和 `width 16` 组合检索。关于 $k$-central binomial coefficients 的论文使用另一种定义。[arXiv 题号检索](https://arxiv.org/search/?query=A402341&searchtype=all) · [相关术语的原论文](https://arminstraub.com/downloads/pub/centralbinomials.pdf) |
| Google Scholar | 直接请求 `"A402341"` 和 `"central coefficients" "2-adic valuation" width 16` 均返回人机验证页面。随后使用桌面浏览器复核：精确查询 `"A402341"` 得一篇与数学无关的韩文消费选择论文；`"central coefficients" "2-adic valuation" "width 16"` 返回没有匹配文章。[Google Scholar 查询](https://scholar.google.com/scholar?q=%22A402341%22) |
| OpenAlex、DataCite 与引文链 | 以题号检索均返回 0。OpenAlex 以作者相关成果题名检索则能查到 W7237349755，其引文记录为 0。DataCite 记录了两个 Zenodo 版本，两者的 citationCount 均为 0。OEIS 词条没有对应的 arXiv 号。Semantic Scholar 的题号检索受 HTTP 429 限流。[OpenAlex 相关成果](https://openalex.org/W7237349755) · [OpenAlex 反向引文](https://api.openalex.org/works?filter=cites:W7237349755) · [第 1 版](https://doi.org/10.5281/zenodo.24416401) · [第 2 版](https://doi.org/10.5281/zenodo.24435433) |
| 研究存档 | Figshare 的原生检索以 `A402341` 查询返回空。Zenodo 直接检索接口返回 HTTP 403。作者的 Zenodo 存档经 DataCite、OpenAlex 和其 GitHub 发布记录核对。[Figshare 接口](https://api.figshare.com/v2/articles/search) · [Zenodo DOI 元数据](https://api.datacite.org/dois/10.5281/zenodo.24416400) |
| MathOverflow、Math Stack Exchange | 两站的公开检索接口以题号查询均为空。使用不带题号的数学表述另检索了中心系数的 2-adic 赋值、二元数位和及 Chebyshev 关键词，未发现直接解答。[MathOverflow 查询](https://api.stackexchange.com/2.3/search/advanced?site=mathoverflow&q=A402341) · [Math Stack Exchange 查询](https://api.stackexchange.com/2.3/search/advanced?site=math&q=A402341) |
| GitHub | 题号检索公开 issues、PR 与提交信息均未命中。README 检索只找到上列 Hussain 本人的 Python 项目。原生全站代码搜索 API 需要认证，返回 401；另用已授权的 GitHub 全站代码搜索和网页索引检索题号与 `theorem`、`Lean`、`central coefficient`。带 `theorem` 的 Lean 命中来自十六进制串中的题号子串；核对详情见 [补充记录](prior-research.md)。[仓库查询](https://api.github.com/search/repositories?q=A402341+in:readme) · [issues 与 PR](https://api.github.com/search/issues?q=A402341) |
| Lean Zulip、Mathlib | 在公开的 Zulip 归档网页索引检索 `A402341`、作者、`central coefficient` 和 `valuation`。在本机 Mathlib 快照 `fc4f59e5` 检索题号及十六项中心系数的英语写法。未找到本题的完成声明。中央二项式、质因数分解、进位等基础结论属于已有理论。[Zulip 公开归档](https://leanprover-community.github.io/archive/) · [Mathlib 二项式分解的源文件](https://github.com/leanprover-community/mathlib4/blob/v4.36.0/Mathlib/Data/Nat/Choose/Factorization.lean) |

词条距本次核查仅八日，数据库更新可能滞后。关键词检索也可能漏掉使用另一套术语的工作。这份查重记录用于判断已知公开证据的范围，不作全球首证保证。

## 2026-11-25 发布后的独立复核

直接访问 OEIS 的内部格式页面，修订号仍为 #13（11 月 17 日），COMMENTS 仍保留 Hussain 提出的偶数行赋值猜想。GitHub 再查 `"A402341" in:readme` 返回两个仓库。Hussain 的仓库给出先前的奇偶性结果，本项目的提交给出所有偶数行的精确赋值。两份公开记录的作者、时间和结论均可分别核对。[OEIS 修订 #13](https://oeis.org/A402341/internal) · [Hussain 的代码](https://github.com/Sajidsaj/central-coefficient-parity/tree/8981e05f6880086891a13e5e663c0db36750b5fb) · [本项目的证明提交](https://github.com/257-1807/oeis-a402341/commit/f07d8cb7d7c393197206bb4351bd2360d0c86c8e)

独立复核下载了 Hussain 的 OEIS 系数表，对 $n=0,1,\ldots,829$ 的全部 **830 个中央系数**逐项比较。各项均与从 $F^0=1$ 开始的宽度 16 滑动卷积一致，比较涵盖奇数行和偶数行。下载表的 SHA-256 为 `d102a8cfaec73d152be40dfa750447adc72621947740997ba7d1c2d73cb5cbd2`。另行重跑仓库自带的离线脚本，核对了前十个已发表系数及 $0\le n\le1600$ 的 801 个偶数行的赋值。[OEIS 完整系数表](https://oeis.org/A402341/b402341.txt) · [仓库离线脚本](../scripts/check_coefficients.py)
