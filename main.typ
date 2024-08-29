#import "@preview/arkheion:0.1.0": *
#import "style.typ": *

#set math.equation(numbering: "(1)")
//==================================================
//                    DOCUMENT
//==================================================
#set text(font: mincho)
#show: arkheion.with(
  title: text(font: mincho)[動的システムの情報理論的形式: 因果関係, モデリング, 操作],
  authors: (
    (
      name: "Adrián Lozano-Durán",
      email: "",
      affiliation: "",
      orcid: "0000-0001-9306-0261"
    ),
    (
      name: "Gonzalo Arranz",
      email: "",
      affiliation: "",
      orcid: "0000-0001-6579-3791"
    ),
  ),
  abstract: [The problems of causality, modeling, and control for chaotic, high-dimensional dynamical systems are
formulated in the language of information theory. The central quantity of interest is the Shannon entropy, which
measures the amount of information in the states of the system. Within this framework, causality is quantified
by the information flux among the variables of interest in the dynamical system. Reduced-order modeling is
posed as a problem related to the conservation of information in which models aim at preserving the maximum
amount of relevant information from the original system. Similarly, control theory is cast in information-theoretic
terms by envisioning the tandem sensor-actuator as a device reducing the unknown information of the state
to be controlled. The new formulation is used to address three problems about the causality, modeling, and
control of turbulence, which stands as a primary example of a chaotic, high-dimensional dynamical system. The
applications include the causality of the energy transfer in the turbulent cascade, subgrid-scale modeling for
large-eddy simulation, and flow control for drag reduction in wall-bounded turbulence.]
)

#set text(font: mincho)

= 情報理論の基礎

== 情報量

離散化されたランダムな事象$X$が，$x$の値をとるとき，確率密度関数 $p$ は次式で表現できる．
$ p(x) = Pr{X = x} $
この時の情報量は，
$ cal(I)(x) := log_2[p(x)] $
で定義される．
一般には，事象$X$に対しての平均を取る．
$ H(X) =  ⟨cal(I)(x)⟩ = sum_x -p(x) log_2[p(x)] >= 0 $
この時，記号$⟨dot⟩$は期待値を求める操作を表す．
これはシャノンエントロピーと呼ばれる．

== 同時エントロピー

これを複数の事象$bold(X)=[X_1, X_2, dots,X_m]$に拡張すると，同時エントロピーが得られる．
$ H(bold(X)) = ⟨cal(I)(bold(x))⟩ = sum_(bold(x)) -p(x_1, x_2, dots , x_m)log_2[p(x_1, x_2, dots , x_m)] $
特に，事象が2つの場合には次のように記述できる．
$ H(X,Y) = ⟨cal(I)(x,y)⟩ = sum_(x,y) -p(x,y)log_2[p(x,y)] $
この時，確率分布の性質は利用できる．
例えば，$x$は$y$に対して規格化条件を満たす必要がある．
$ p(y) = sum_x p(x,y) $

== 条件付きエントロピー
=== 条件付きエントロピーの定義

$x$に関する$y$の条件付き確率を次式で定めることができる．
$ p(x|y) = frac(p(x,y),p(y)) $
これによって定められる条件付きエントロピーは
$ H(X|Y) = sum_(x,y) -p(x, y)log_2[p(x|y)] $
となる．

=== 条件付きエントロピーの性質

もし，$x$が$y$に対して独立であるなら，
$ p(x,y) = p(x)p(y) $
が成立するから，
$ p(x|y) = frac(p(x)p(y),p(y)) = p(x) $
となるので，
$ H(X|Y) &= sum_(x,y) -p(x)p(y)log_2[p(x)]\
         &= sum_x -p(x)log_2[p(x)]\
         &= H(X) $
となる．
逆に，$x$が$y$に対して完全に従属であるなら，
$ p(x,y) = p(y) $
となり，条件付き確率は，
$ p(x|y) = frac(p(y),p(y)) = 1 $
となる．これより，条件付きエントロピーは
$ H(X|Y) &= sum_(x,y) -p(y)log_2[1]\
         &= sum_x 0\
         &= 0 $
となる．
これらから，相互情報量は以下で定義できる．
$ I(X:Y) &= H(X) - H(X|Y)\
         &= H(Y) - H(Y|X) $

= 動的システムにおける情報

== 動的システムの準備

動的システムにおける変数を，$bold(q)$とすると，
$ bold(q) = bold(q)(bold(x),t) $
である．
この時，$bold(x)$は空間座標で，$t$は時間である．
変数$bold(q)$がベクトルであるのは，複数の変数を考慮するためである．
例えば非圧縮の流体の場合，速度場$u_1,u_2,u_3$および圧力$p$を合わせて，次のようになる．
$ bold(q) = [u_1, u_2, u_3, p]^T $
この記述を一般化すれば，自由度$N$のシステムに対して次のようになる．
$ bold(q) = [q_1, q_2, dots, q_N]^T $
このシステムにおける支配方程式は，一般化して次のように書ける．
$ frac(partial bold(q),partial t) = bold(F)(bold(q)) $
上式を，時間$t$で積分する．積分範囲は$t_n$から$t_(n+1)$とすれば，
$ integral_(t_n)^(t_(n+1)) frac(partial bold(q), partial t) d t &= integral_(t_n)^(t_(n+1)) bold(F)(bold(q)) d t\
bold(q)(bold(x),t_(n+1)) &= bold(q)(bold(x),t_n) + integral_(t_n)^(t_(n+1)) bold(F)(bold(q)) d t $
となる．
この時，$t_(n+1) - t_n$は時間幅となる．
時刻$t_n$における変数を$bold(q)^n$とすれば，
$ bold(q)^n = [q_1^n, q_2^n, dots, q_N^n]^T $
である．

== 確率変数の導入

今，このシステムの物理量を確率変数として扱う．
時刻$t_n$における物理量の確率変数を$Q^n$とすれば，
$ bold(Q)^n = [Q_1^n, Q_2^n, dots, Q_N^n]^T $
と書ける．
この時，先の式から支配方程式が存在し，
$ bold(Q)^(n+1) = bold(f)(bold(Q)^n) $<Qeq>
の関係がある．
$bold(Q)$がとりうる範囲$D$を$N_q$個に分割し，それぞれの領域を$D_i$とする．
この時，$D_i$は$D$の集合とみなせて，
$ D = {D_1, D_2, dots, D_N_q} $
と書ける．
#block(fill: red.transparentize(50%))[領域$D_i$は空間的な分割?なんの分割か?]
それぞれ$D_i$は$i!=j$において，互いに同じ領域を持たないように取る．
$ D_i and D_j = nothing $
もし，$bold(q)^n$が領域$D_i$に含まれる時，その確率は
$ p_i^q = Pr{bold(Q)^n in D_i} $
と書くことができる．
略記として，上記の記述を
$ p_i^q = p(bold(q)^n) $
と書くことにする．

== 動的システムの情報理論的視点

確率変数$bold(Q)^(n+1)$は，支配方程式@Qeq より$bold(Q)^n$によって記述できる．
これを利用すれば，$bold(Q)^(n+1)$のエントロピーは，
$ H(bold(Q)^(n+1)) = H(bold(f)(bold(Q)^n)) <= H(bold(Q)^n) $
となる．
上のような不等号が成立するのは，$bold(Q)^n$から$bold(Q)^(n+1)$を導くことはできるが，$bold(Q)^(n+1)$から$bold(Q)^n$を導けるとは限らないためである．\ \
また，支配方程式が存在するので，$t_n$の時の確率分布$p(bold(q)^n)$を知っていれば，次の時刻$t_(n+1)$での確率分布$p(bold(q)^(n+1))$を計算することも可能である．
これを，転送作用素の演算子$bb(P)$を使って，
$ p(bold(q)^(n+1)) = bb(P)[p(bold(q)^n)] $
と記述する．
#block(fill: red.transparentize(50%))[転送作用素とは?確率を求める関数という認識?]
これを用いれば，$bold(Q)^n$に対する$bold(Q)^(n+1)$の条件付きエントロピーは，
$
H(bold(Q)^(n+1)|bold(Q)^n) &= sum -p(bold(q)^(n+1),bold(q)^n) log_2[p(bold(q)^(n+1)|bold(q)^n)]\
 &= sum -p(bold(q)^(n+1)|bold(q)^n)p(bold(q)^n) log_2[p(bold(q)^(n+1)|bold(q)^n)]\
&= sum -bb(P)[p(bold(q)^n|bold(q)^n)]p(bold(q)^n) log_2{bb(P)[p(bold(q)^n|bold(q)^n)]}\
&= 0
$
となり，条件付きエントロピーは0となる．
#block(fill: red.transparentize(50%))[式(29)から，式(30)の$p(bold(q)^(n+1)|bold(q)^n) = bb(P)[p(bold(q)^n|bold(q)^n)]$が導かれるのは，数学的にどういう原理か？]
これは，$bold(Q)^n$を知っているとき，$bold(Q)^(n+1)$の不確実性は全くないことを表している．\ \
もし，逆関係
$ bold(Q)^n = bold(f)^(-1) H(bold(Q)^n) $
が成立するなら，情報はその時間内で保存される．
$ H(bold(Q)^(n+1)) = H(bold(Q)^n) $

== ノイズを含むシステム

より一般的には，$bold(Q)^n$と$bold(Q)^(n+1)$の間には，何らかノイズを含む．
つまり，ノイズの影響を考えると，$bold(Q)^n$に対する$bold(Q)^(n+1)$の条件付きエントロピーは0にならず，ある程度の値を持つ．
$ H(bold(Q)^(n+1)|bold(Q)^n) >= 0 $
このノイズを$bold(W)$とすれば，支配方程式を記述し直して，
$ bold(Q)^(n+1) = bold(f)(bold(Q)^n, bold(W)^n) $
とできる．
このノイズの影響まで考慮すれば，条件付きエントロピーは
$ H(bold(Q)^(n+1)|bold(Q)^n,bold(W)^n) = 0 $
となり，0になる．
流体のようなカオス系では，微小な初期誤差$bold(W)^n$の影響で，カオスの初期値鋭敏性によって非ゼロとなりうる．
今後は，$bold(W)^n$の影響を考えずに議論をする．

= 相関としての情報流

== 情報流
先の方程式@Qeq から，システムの確率変数の1つ$Q_j^(n+1)$に関する支配方程式は
$ Q_j^(n+1) = f_j (bold(Q)^n) $
となる．
これより，条件付きエントロピーは，
$ H(Q_j^(n+1) | bold(Q)^n) = 0 $
である．
これは，$Q_j^(n+1)$に含まれる情報は，$bold(Q)^n$に完全に含まれていることを意味する．\ \
ここで，$bold(Q)^n$のうちの一部分$bold(Q)_bold(i)^n$を考える．
この時，$bold(i)$は，$N$以下の一部分で，
$ bold(i) = [i_1, i_2, dots, i_M] $
とする．
$M$は$M<=N$を満たす．
このとき，$bold(Q)_bold(i)^n$は
$ bold(Q)_bold(i)^n = [Q_(i_1)^n, Q_(i_2)^n, dots,Q_(i_M)^n] $
となる．
また，これの反要素$bold(Q)^n and overline(bold(Q)_bold(i)^n)$を$bold(Q)_bold(cancel(i))^n$と表せば，
$ bold(Q)^n = [bold(Q)_bold(i)^n, bold(Q)_bold(cancel(i))^n] $
の関係になる．
もし，この反要素$bold(Q)_bold(cancel(i))^n$しか知らなかったとすると，一般に
$ H(Q_j^(n+1)|bold(Q)_(cancel(i))^n) >= 0 $
となり，0とならずに値を持ちうる．
これは，$bold(Q)_bold(cancel(i))^n$の情報だけ知っていても，$Q_j^(n+1)$を表現できるとは限らないことを意味する．
逆に言えば，$bold(Q)_bold(i)^n$は，$Q_j^(n+1)$を表現するのに貢献していると言える．
もし，貢献していなければ，上の条件付きエントロピーはゼロとなる．
このことから，$bold(Q)_bold(i)^n$から$Q_j^(n+1)$への情報の輸送は，条件付きエントロピー$H(Q_j^(n+1)|bold(Q)_(cancel(i))^n)$で表現できると考えられる．
実際に，移動エントロピーの一般式は
$ T_(bold(i) arrow.r j) = sum_(k=0)^(M-1) sum_(bold(i)(k) in C_k) (-1)^k H(Q_j^(n+1)|bold(Q)_(cancel(i)(k))^n) $<trans_eq1>
となる．
#block(fill: red.transparentize(50%))[式(41)から式(42)の導出は?(式(41)およびベン図から)概念は理解できるが，どのようにしてこの式が組み立てられるのかがわからない．この式の一般性を証明できない．]
ここで，$bold(i)(k)$は，$bold(i)$のうち，$k$個の要素を抜いたものである．
この集合が$C_k$である．
例えば，$bold(i) = [1,2]$であれば，次の組み合わせとなる．
$ C_0 &= {[1,2]}\
  C_1 &= {[1],[2]} $
  この移動エントロピー$T_([1,2] arrow.r 3)$では，上記の一般式に代入して
$
T_([1,2] arrow.r 3) &= sum_(k=0)^1 sum_(bold(i)(k) in C_k) (-1)^k H(Q_3^(n+1)|bold(Q)_(bold(cancel(i))(k))^n)\
&= H(Q_3^(n+1)|Q_3^n) - ( H(Q_3^(n+1)|Q_2^n,Q_3^n) + H(Q_3^(n+1)|Q_1^n,Q_3^n) )\
&= H(Q_3^(n+1)|Q_3^n) - H(Q_3^(n+1)|Q_2^n,Q_3^n) - H(Q_3^(n+1)|Q_1^n,Q_3^n)
$<trans_1_2_3>
これを図で表す．移動エントロピーは，以下の青部分である．
#figure(
  image("figs/fig1.png",width: 50%)
)
これに対し，@trans_1_2_3 のそれぞれのエントロピーは，以下の領域を表す．
#figure(
  image("figs/fig2.png",width: 100%)
)
これより，先の式が正しいことが視覚的に確認できる．\ \
性質として，それぞれの移動エントロピー$T$には重複が含まれない．
例えば，$T_([1,2] arrow.r 3)$と$T_(1 arrow.r 3)$は次のようになる．
#figure(
  image("figs/fig3.png",width: 70%)
)
上のように，それぞれの移動エントロピーは重複しない．
#block(fill: red.transparentize(50%))[一般性の証明はどのように?]
また，移動エントロピーは，条件付き相互情報量で表現することが可能である．
$ T_(bold(i) arrow.r j) = I(Q_j^(n+1):Q_(j_1)^n:Q_(j_2)^n:dots:Q_(j_M)^n|bold(Q)_(bold(cancel(i)))^n) $
この条件付き相互情報量は，以下の性質がある．
$ I(Q_j^(n+1):Q_(j_1)^n:Q_(j_2)^n:dots:Q_(j_M)^n|bold(Q)_(bold(cancel(i)))^n) = I&(Q_j^(n+1):Q_(j_1)^n:Q_(j_2)^n:dots:Q_(j_(M-1))^n|bold(Q)_(bold(cancel(i)))^n) \
&- I(Q_j^(n+1):Q_(j_1)^n:Q_(j_2)^n:dots:Q_(j_(M-1))^n|[Q_(i_M)^n,bold(Q)_(bold(cancel(i)))^n]) $
#block(fill: red.transparentize(50%))[要素が3つの場合は視覚的に確認済み．この式の一般性の証明はどのように?]
また，$Z$に対する$X$と$Y$の相互情報量は，次式になる．
$
I(X:Y|Z)
&= sum_(x,y,z) p(x,y,z) log_2 frac(p(x,y|z),p(x|z)p(y|z))\
&= sum_(x,y,z) p(x,y,z) log_2 frac(p(x,y,z)p(z),p(x,z)p(y,z))\
&= sum_(x,y,z) p(x,y,z) log_2 frac(p(z),p(x,z)) - sum_(x,y,z) p(x,y,z) log_2 frac(p(y,z),p(x,y,z))\
&=sum_(x,z)-p(x,z)log_2 p(x|z) - sum_(x,y,z) p(x,y,z) log_2 p(x|y,z)\
&= H(X|Z) - H(X|Y,Z)
$
以上の2式を用いれば，エントロピーから移動エントロピーを計算が可能である．\ \
さらに，移動エントロピーを用いて$H(Q_j^(n+1))$を計算することができる．
$ H(Q_j^(n+1)) = sum_(bold(i)' in cal(C)) T_(bold(i)' arrow.r j) $
ここで，$cal(C)$は，1から$N$までの要素を持つ$bold(i) or bold(cancel(i))$の組み合わせである．
先のベン図の例では，
$ cal(C) = {1, 2, 3, [1,2], [2,3], [1,3], [1,2,3]} $
である．これは，
#figure(
  image("figs/fig4.png",width: 50%)
)
となり，移動エントロピーの和がエントロピーとなることがわかる．
もし，$bold(Q)_(bold(i))^n$が$Q_j^(n+1)$へ与える影響がないとき，システムの支配方程式は以下の形で書ける．
$ Q_j^(n+1) = f_j (bold(Q)_(bold(cancel(i)))^n) $
これは，$bold(cancel(i))^n$の成分のみから，次の時刻の$Q_j^(n+1)$を再現できることと同義である．
この場合，$bold(i) arrow.r j$の方向の移動エントロピーは0である．
$ T_(bold(i) arrow.r j) = 0 $
これは，$bold(Q)_bold(i)$の要素が，$Q_j$に対して作用しない限り，直接的な因果関係が生じないという直感と一致する．
加えて，情報流は確率分布を基礎として構築されるので，移動や再スケール，あるいは一般の非線形$C^1$級微分同相変換に対して不変である．
もう一つ重要な性質として，移動エントロピーは中間変数を含まない直接的な相関を再現する．
例えば，相関の流れが
$ Q_i arrow.r Q_j arrow.r Q_k $
である時，$Q_i arrow.r Q_k$の移動は観測されない．この場合，
$ T_(i arrow.r k) = 0 $
である．
また，一般に情報流は非対称である．
$ T_(bold(i) arrow.r bold(j)) != T_(bold(j) arrow.r bold(i)) $

== 観測可能な量における情報流

多くの場合で，我々が興味あるもの，或いは観測可能な量は限定される．
この場合，観測可能な状態量を$bold(Y)^n$として，
$ bold(Y)^n = bold(h)(bold(Q)^n) $
と書ける．
この時，$bold(Y)$は，以下の自由度を持つ．
$ bold(Y) = [Y_1^n, Y_2^n, dots, Y_(N_Y)^n] $
$N_Y < N$であり，自由度が減少した分だけ保持する情報量は小さくなる．
$ H(bold(Y)^n) = H(bold(h)(bold(Q)^n)) <= H(bold(Q)^n) $
この場合，$bold(Y)^n$が，未来の状態$bold(Y)^(n+1)$を表現できるとは限らない．
この関係は，以下の式で明らかになる．
$ H(bold(Y)^(n+1)|bold(Y)^n) >= H(bold(Y)^(n+1)|bold(Q)^n) = 0 $
特に$Y_j^(n+1)$に注目すれば，上式は
$ H(Y_j^(n+1)|bold(Y)^n) >= 0 $
となる．
この場合，先の移動エントロピーの式は修正されて，以下の形で定義される．
$ T_(bold(i) arrow.r j)^Y = [sum_(k=0)^(M-1) sum_(bold(i)(k) in cal(P)_k) (-1)^k H(Y_j^(n+1)|bold(Y)_(cancel(i)(k))^n)] +(-1)^M H(Y_j^(n+1)|bold(Y)^n) $
この時，$M <= N_Y$となる$bold(i)$を選択する．つまり，
$ bold(i) = [i_1,i_2,dots,i_M] $
となる$bold(i)$の中から選択される．
このため，集合$cal(P)_k$は$cal(C)_k$とは異なる集合である(一般に，$cal(P)_k in cal(C)_k$が成立)．
最終項は，$H(Y_j^(n+1)|bold(Y)^n)$で表現される観測できない状態量による情報の損失を補うために追加された項である．
より上記を自然に記述するために，和の記号の中に入れることもできる．
$ T_(bold(i) arrow.r j)^Y = sum_(k=0)^(M) sum_(bold(i)(k) in cal(P)_k) (-1)^k H(Y_j^(n+1)|bold(Y)_(cancel(i)(k))^n) $<trans_eq2>
条件付き相互情報量の形で記述することもできる．
$ T_(bold(i) arrow.r j)^Y = I(Y_j^(n+1):Y_(i_1)^n:Y_(i_2)^n:dots:Y_(i_M)^n|bold(Y)_(bold(cancel(i)))^n) $
もし，$bold(Y)^n=bold(Q)^n$であれば，条件付きエントロピーは0となる．
$ H(Y_j^(n+1)|bold(Y)^n) = 0 $
これは，先のエントロピーの式@trans_eq1 と一致する．
よって式@trans_eq2 は，より一般化された形である．\ \

さらに，$bold(i) = [i]$であるとき，観測可能な状態量による情報流は，
$ T_(i arrow.r j)^Y = H(Y_j^(n+1)|bold(Y)_cancel(i)^n) - H(Y_j^(n+1)|bold(Y)^n) $
と簡単な形で書ける．\ \

また，移動エントロピーの和は未来の情報量と一致することを先に示したが，観測可能な量が限定されている場合には，"もれ"が発生する．
$ H(Y_j^(n+1)) = sum_(bold(i) in cal(P)) T_(bold(i) arrow.r j)^Y + T_(mono(l e a k),j)^Y $
この$T_(mono(l e a k),j)^Y$は，条件付きエントロピーと一致する．
$ T_(mono(l e a k),j)^Y = H(Y_j^(n+1)|bold(Y)^n) $
上記の式を，$T_(i arrow.r j)^Y$で正規化すれば，
$ T N_(bold(i) arrow.r j)^Y = frac(T_(bold(i) arrow.r j)^Y, H(Y_j^(n+1))) $
$ T N_(mono(l e a k),j)^Y = frac(T_(mono(l e a k),j)^Y, H(Y_j^(n+1))) $
となり，先の式は
$ sum_(bold(i) in cal(P)) T N_(bold(i) arrow.r j)^Y + T N_(mono(l e a k),j)^Y = 1 $
とかける．
例として，先と同じ3つの場合で考えると，図は次のようになる．
#figure(
  image("figs/fig5.png",width: 70%)
)
$bold(i)=[1],j=2$のとき，移動エントロピーの式に代入すると次のようになる．
$ T_(1 arrow.r 2)^Y = H(Y_2^(n+1)|Y_2^n,Y_3^n) - H(Y_2^(n+1)|Y_1^n,Y_2^n,Y_3^n) $
$bold(i)=[1,3],j=2$のとき，移動エントロピーの式に代入すると次のようになる．
$ T_([1,2] arrow.r 2)^Y = H&(Y_2^(n+1)|Y_2^n) - H(Y_2^(n+1)|Y_1^n,Y_2^n)\
 &- H(Y_2^(n+1)|Y_2^n,Y_3^n) + H(Y_2^(n+1)|Y_1^n,Y_2^n,Y_3^n) $
$bold(i)=[1,2,3],j=2$のとき，移動エントロピーの式に代入すると次のようになる．
$ T_([1,2,3] arrow.r 2)^Y = H&(Y_2^(n+1))\
 &- H(Y_2^(n+1)|Y_1^n) - H(Y_2^(n+1)|Y_2^n) - H(Y_2^(n+1)|Y_3^n)\
 &+ H(Y_2^(n+1)|Y_1^n,Y_2^n) + H(Y_2^(n+1)|Y_1^n,Y_3^n) + H(Y_2^(n+1)|Y_2^n,Y_3^n)\
 &+ H(Y_2^(n+1)|Y_1^n,Y_2^n,Y_3^n) $
 これらより，図から$Y_2^(n+1)$のエントロピーは，移動エントロピーの和で記述できることがわかる．
 $ H(Y_2^(n+1)) = T_(1 arrow.r 2)^Y + T_(2 arrow.r 2)^Y + T_(3 arrow.r 2)^Y + T_([1,2] arrow.r 2)^Y + T_([2,3] arrow.r 2)^Y + T_([1,3] arrow.r 2)^Y  + T_([1,2,3] arrow.r 2)^Y + T_(mono(l e a k),j)^Y $
ここで，$T_(mono(l e a k),j)^Y = H(Y_2^(n+1)|Y_1^n,Y_2^n,Y_3^n)$である．\ \

$T_(bold(i) arrow.r j)^Y$は，非負性を満たすとは限らないことに注意しなければならない．
移動エントロピーの変数の数が奇数の場合，非負性の拘束はない．
#block(fill: red.transparentize(50%))[証明方法?]

== 情報流の最適観測状態と位相空間分割

$i != j$において，それぞれの相互情報量$I(Y_i^n:Y_j^n)$が次の条件を満たすときを考える．
$ I(Y_i^n : Y_j^n) = 0 $
このとき，情報の流れは単独の流れのみを観測すれば良い．
つまり，2個以上の流れ($T_([1,2] arrow.r 2)$や$T_([1,2,3] arrow.r 2)$など)は全て0となり，それぞれ独立な流れ($T_(1 arrow.r 2)$や$T_(2 arrow.r 2)$など)のみを考えれば良い．\
しかし，一般にはこれが成立しないので，ある変換$bold(w)^*$を行う．
$ bold(Y)^(n*) = bold(w)^*(bold(Y)^n) $
この変換は，情報を失わないように，可逆であることを条件とする．
変換では，
$ bold(w)^* = arg min_(bold(w)(bold(Y)^n)) (sum_(i,j,i != j)I(Y_i^n : Y_j^n)) $
また，
$ H(bold(Y)^(n*)) = H(bold(Y)^n) $
とすることで，情報の流れを各変数に単独な流れとして観測しやすくなる．
この変換によって，各パラメータが未来の情報に与える影響を評価しやすくすることができる．
似たような議論として，位相空間における分割$D = {D_1,D_2,dots,D_(N_q)}$の方法を最適な$D^*$に変更すると，
$ D^* = arg min_D (sum_(i,j,i != j) I(Q_i^n : Q_j^n)) $
となる．
このとき，$D$の条件は$D^*$も満たす必要がある．


/*
= 等方性乱流におけるエネルギーカスケードの相関

非圧縮における流体の方程式は，次式で記述できる．
$ frac(partial u_i, partial t) + frac(partial u_i u_j, partial x_j) = -frac(1,rho)frac(partial Pi, partial x_i) + nu frac(partial^2 u_i, partial x_j partial x_j) + f_i $
$ frac(partial u_i, partial x_i) = 0 $
このとき，$u_i$は速度であり，$Pi$は圧力である．
また，$rho$は密度であり，$nu$は動粘度である．
上記のNavier-Stokes方程式に対して，$u_i$をかけて，エネルギー方程式にする．
$ underbrace(u_i frac(partial u_i, partial t), A) + underbrace(u_i frac(partial u_i u_j, partial x_j),B) = underbrace(-u_i frac(1,rho)frac(partial Pi, partial x_i),C) + underbrace(nu u_i frac(partial^2 u_i, partial x_j partial x_j),D) + underbrace(f_i u_i, E) $
それぞれの項について，変形をする．最初にA項について，
$ u_i frac(partial u_i, partial t) = frac(partial, partial t)(frac(u_i u_i, 2)) = frac(partial k, partial t) $
ここで，運動エネルギー$k = frac(u_i u_i, 2)$を定めた．
次にB項について，
$ u_i frac(partial u_i u_j, partial x_j) &= u_i u_i underbrace(frac(partial u_j, partial x_j),0) + u_i u_j frac(partial u_i, partial x_j)\
&= u_i u_j frac(partial u_i, partial x_j)\
&= u_j frac(partial,partial x_j)(frac(u_i u_i, 2))\
&= u_j frac(partial k, partial x_j) $
*/
