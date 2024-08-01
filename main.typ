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
  abstract: lorem(55)
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
