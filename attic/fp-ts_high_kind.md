<!--
title: fp-ts 高カインド多相
tags:  TypeScript
id:    0a05f4799e30ad505f20
-->
TypeScriptに型はあるけど、高カインド多相やら型クラスやらはないので、fp-tsは自前でなんとかしている。

## 高カインド多相

### やりたいけどできないこと

```typescript
// こんなことしたいけどできません。
//
function hehe<K[],A>(a:A) {
  const ka:K[A] = ...
  ...
}
```

しかたないのでこんな風にする。

### 高カインド型の登録（宣言）

```typescript
// HKT.tsで定義されている interface URItoKind に Option とか IO とかを多相型として登録する
// 実質以下のような宣言をしていることになる。
//
// interface URItoKind<A> {
//   readonly Option: Option<A>
//   readonly IO: IO<A>
//   ...
// }
// 
// 以下はOptionの例

export const URI = 'Option'

export type URI = typeof URI

declare module './HKT' {
  interface URItoKind<A> {
    readonly [URI]: Option<A>
  }
}
```

### 型クラスのインスタンスの作成

型クラスFunctorのインスタンス。

```typescript
export const Functor: Functor1<URI> = {
  URI,
  map: _map
}
```

高カインド型を利用するための型関数（Kind）とその用意。

```typescript
export type URIS = keyof URItoKind<any>

export type Kind<URI extends URIS, A> = URI extends URIS ? URItoKind<A>[URI] : any
```


