pkgmake — ferramenta simples de build e release para XBPS
======================================================

DESCRIÇÃO
---------
pkgmake é uma ferramenta no estilo makepkg (Arch) para empacotamento
de software no Void Linux usando XBPS.

Ela executa:
- build do software
- instalação em staging (pkg/)
- criação do pacote .xbps
- atualização e assinatura do repositório

USO
---
Entre em um diretório que contenha um arquivo Pkgfile e execute:

  pkgmake build
  pkgmake package
  pkgmake release

COMANDOS
--------
build
    Baixa o source e executa a função build().

package
    Executa a função package() usando PKGDIR como DESTDIR.

lint
    Verifica se o Pkgfile possui os campos e funções obrigatórias.

clean
    Remove diretórios gerados (src/, pkg/, dist/, repo/).

release
    Executa: lint → build → package → xbps-create → xbps-rindex.
    Equivalente a "makepkg --sign".

ARQUIVO Pkgfile
---------------
O Pkgfile é um script shell simples, inspirado no PKGBUILD do Arch.

Campos comuns:
  pkgname
  pkgver
  pkgrel
  pkgdesc
  license
  depends
  source

Funções reconhecidas:
  prepare()  (opcional)
  build()    (obrigatória)
  package()  (obrigatória)

EXEMPLO RÁPIDO
--------------
pkgname=hello
pkgver=1.0
pkgrel=1

build() {
  make
}

package() {
  make DESTDIR="$PKGDIR" install
}

NOTAS
-----
- pkgmake não substitui XBPS.
- A assinatura é feita no índice do repositório via xbps-rindex.
- pkgmake não instala pacotes no sistema.

LICENÇA
-------
MIT

AUTOR
-----
Projeto pkgmake
