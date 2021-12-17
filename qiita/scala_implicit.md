<!--
title: 暗黙的でない implicit の使用法
tags:  Scala
id:    52424ab5cb375c9b41d6
-->
# implicit 探索の優先順位

1. まずスコープを探索
    a. 現在のスコープ内のimplicit
    b. 明示的にimportされたimplicit
    c. ワイルドカードでimportされたimplicit

2. 関連する型を探索
    a. 型のコンパニオンオブジェクト
    b. Implicit scope of an argument's type (2.9.1)
    c. Implicit scope of type arguments (2.8.0)
    d. Outer objects for nested types
    e. Other dimensions

[出典](https://stackoverflow.com/questions/5598085/where-does-scala-look-for-implicits)


# implicitの曖昧さの回避

上記の各ステージ(1.スコープでの探索、2.型定義での探索）でimplicitに曖昧さ、
要は複数のimplicit parameterがあった場合は、下記の用に、当たり前だけど、
エラーになる。


- implicit class A: Int に hehe というメソッドを追加
- implicit class B: Int に hoho というメソッドを追加
- implicit class C: Int に hehe というメソッドを追加

`10.hehe`は compile time error。


```
scala> implicit class A(i:Int) {
     | def hehe():Unit = println("A")
     | }
defined class A

scala> implicit class B(i:Int) {
     | def hoho():Unit = println("B")
     | }
defined class B

scala> 10.hehe
A

scala> 10.hoho
B

scala> implicit class C(i:Int) {
     | def hehe():Unit = println("C")
     | }
defined class C

scala> 10.hehe
<console>:11: error: type mismatch;
 found   : Int(10)
 required: ?{def hehe: ?}
Note that implicit conversions are not applicable because they are ambiguous:
 both method A of type (i: Int)A
 and method C of type (i: Int)C
 are possible conversion functions from Int(10) to ?{def hehe: ?}
              10.hehe
              ^
<console>:11: error: value hehe is not a member of Int
              10.hehe
                 ^

```
