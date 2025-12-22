pkgmake — utilitário de build para pacotes XBPS
==============================================

DESCRIÇÃO
---------
**pkgmake** é uma ferramenta estilo *makepkg* para **Void Linux / XBPS**.

Ela automatiza o processo de:
- build
- empacotamento
- instalação opcional
- assinatura de pacotes
- gerenciamento de repositório local

O funcionamento é **totalmente controlado por flags**.  
Não existem subcomandos.

FUNCIONALIDADES
----------------
O pkgmake pode:

- Resolver e instalar dependências (`depends` e `makedepends`)
- Executar build e empacotamento a partir de um `Pkgfile`
- Criar pacotes `.xbps`
- Instalar o pacote gerado (opcional)
- Assinar pacotes ou repositórios
- Gerenciar diretório de saída dos pacotes
- Operar de forma silenciosa ou verbosa

DOWNLOAD E INSTALAÇÃO
---------------------

### Via git clone

```sh
git clone --depth=1 https://github.com/<usuario>/pkgmake.git
cd pkgmake
```

### Instalação via Makefile

```sh
sudo make install
```

Instala por padrão:
- `/usr/bin/pkgmake`
- `/usr/share/pkgmake`
- `/etc/pkgmake.conf` (se não existir)

Remoção:

```sh
sudo make uninstall
```

---

USO
Executar diretamente:

```sh
pkgmake --help
```
Execute o comando **dentro de um diretório que contenha um `Pkgfile`**.

```sh
pkgmake [opções]
```

EXEMPLOS COMUNS
----------------

Resolver dependências, buildar e empacotar:
```sh
pkgmake -s
```

Buildar e instalar o pacote:
```sh
pkgmake -s -i
```

Forçar reinstalação do pacote:
```sh
pkgmake -s -i -f
```

Modo verboso:
```sh
pkgmake -s -v
```

Modo silencioso:
```sh
pkgmake -s -q
```

Assinar pacote após o build:
```sh
pkgmake -s --sign
```

Assinar apenas pacotes já existentes no repositório:
```sh
pkgmake --sign-only
```

Gerar chave RSA 4096 (PEM):
```sh
pkgmake --gen-key
```

Usar chave privada específica:
```sh
pkgmake --privkey /caminho/da/chave.pem
```

Limpar diretórios de trabalho:
```sh
pkgmake -c
```

Imprimir configuração carregada:
```sh
pkgmake -p
```

Definir diretório de saída dos pacotes:
```sh
pkgmake -k /caminho/do/repo
```

OPÇÕES (FLAGS)
--------------
-s, --syncdeps  
    Instala `depends` e `makedepends`.

-i, --install  
    Instala o pacote após o build.

-f, --force  
    Força reinstalação do pacote.

-q, --quiet  
    Silencia a saída dos comandos.

-v, --verbose  
    Mostra a saída completa dos comandos.

--sign  
    Assina o pacote após o build.

--sign-only  
    Assina apenas pacotes já existentes no repositório.

--privkey <path>  
    Caminho para chave privada PEM.
    Se omitido, tenta autodetectar.

--gen-key  
    Gera uma chave RSA 4096 em formato PEM.

-c, --clean  
    Remove diretórios de trabalho.

-p, --print-config  
    Imprime a configuração carregada de `/etc/pkgmake.conf`.

-k, --pkgdest <path>  
    Diretório local onde os pacotes `.xbps`
    e os dados do repositório serão gerados.

-h, --help  
    Mostra a ajuda.

ARQUIVO DE CONFIGURAÇÃO
-----------------------
O pkgmake carrega automaticamente:

```
/etc/pkgmake.conf
```

Valores definidos via **linha de comando sobrescrevem**
o arquivo de configuração.

ARQUIVO Pkgfile
---------------
O **Pkgfile** é um script shell simples.

Campos comuns:
- pkgname
- version
- revision
- short_desc
- license
- homepage
- distfiles
- checksum
- depends
- makedepends

Funções reconhecidas:
- prepare()   (opcional)
- build()     (obrigatória)
- package()   (obrigatória)

EXEMPLO RÁPIDO
--------------
```sh
pkgname=hello
version=1.0
revision=1

build() {
    make
}

package() {
    make DESTDIR="$PKGDIR" install
}
```

REQUISITOS
----------
- Void Linux
- bash
- git
- xbps
- xbps-install
- xbps-create
- xbps-rindex

NOTAS IMPORTANTES
-----------------
- pkgmake **não substitui** o XBPS
- Deve ser executado como **usuário comum**
- Apenas a instalação de dependências requer privilégios
- O fluxo segue estritamente o que está definido no `Pkgfile`

LICENÇA
-------
MIT

AUTOR
-----
Vilmar Catafesta <vcatafesta@gmail.com>  
Projeto VoidLinuxBr
