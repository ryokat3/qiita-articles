<!--
title: fp-ts 関数合成の基盤
tags:  TypeScript,関数型プログラミング
id:    d3c8f2234ea428e4563a
-->
## 関数合成

fp-tsでは関数合成を行うのに`pipe`と`flow`の２種類が用意されている。

monadがー、applicativeがー、とか面倒くさいことを言わない、本当に単純な関数。

なのでクライスリ圏での関数（射）を合成する際には、`>>=`や`>=>`みたいに勝手に関数をliftして合成してくれるわけではない。そのため`map`や`chain`を使って自分でliftして前後で型を合わせる必要がある。

### pipe

```typescript
// 引数が4つの場合
export function pipe<A, B, C, D>(
  a: A,
  ab: (a: A) => B,
  bc: (b: B) => C,
  cd: (c: C) => D
): D
```

Haskellの`>>=`演算子っぽい関数合成をしたいときに使う。

```haskell
(>>=) :: m a -> (a -> m b) -> m b
```

### flow

```typescript
// 引数が4つの場合
export function flow<A extends ReadonlyArray<unknown>, B, C, D, E>(
  ab: (...a: A) => B,
  bc: (b: B) => C,
  cd: (c: C) => D,
  de: (d: D) => E
): (...a: A) => E
```

Haskellの`>=>`演算子っぽい関数合成をしたいときに使う。

```haskell
(>=>) :: (a -> m b) -> (b -> m c) -> (a -> mc)
```

ちなみに`>=>`をfish operatorと呼ぶ、らしい。魚に見えなくもない。なるほど。ただfishを名乗るなら`><>`の方が魚っぽい。
