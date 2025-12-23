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
- Executar build e empacotamento a partir de um `PKGFILE`
- Criar pacotes `.xbps`
- Instalar o pacote gerado (opcional)
- Assinar pacotes ou repositórios
- Gerenciar diretório de saída dos pacotes
- Operar de forma silenciosa ou verbosa

DOWNLOAD E INSTALAÇÃO
---------------------

### 1. Via git clone

```bash
# Clone o repositório
git clone --depth=1 https://github.com/<usuario>/pkgmake.git

# entre no diretório
cd pkgmake

# Instale via Makefile
sudo make install
```

Instala por padrão:
- `/usr/bin/pkgmake`
- `/usr/share/pkgmake`
- `/etc/pkgmake.conf` (se não existir)

Remoção:

```bash
sudo make uninstall
```

### 2. Via wget ou curl (instalação direta)

Instalação rápida executando o script diretamente do GitHub.

#### Usando curl
```sh
curl -fsSL https://raw.githubusercontent.com/voidlinuxbr/pkgmake/main/install.sh | sudo bash
```

#### Usando wget
```sh
wget -qO- https://raw.githubusercontent.com/voidlinuxbr/pkgmake/main/install.sh | sudo bash
```

Este método:
- não requer git
- instala os mesmos arquivos do método via Makefile
- **não sobrescreve** configurações existentes
- cria `/etc/pkgmake.conf.pacnew` quando necessário

---

#### Execução manual do instalador (alternativa)

```sh
wget https://raw.githubusercontent.com/voidlinuxbr/pkgmake/main/install.sh
chmod +x install.sh
sudo ./install.sh
```
---

USO
---
```
pkgmake — utilitário de build para pacotes XBPS

Uso:
  pkgmake [opções]

Opções:
  -s, --syncdeps               Instalar depends e makedepends
  -i, --install                Instalar pacote após o build
  -f, --force                  Forçar reinstalação do pacote
  -q, --quiet                  Silenciar saída dos comandos
  -v, --verbose                Mostrar saída dos comandos
      --sign                   Assinar pacote após o build
      --sign-only              Somente assinar pacotes existentes no repo
      --privkey <path>         Caminho da chave privada PEM (autodetecta se omitido)
      --gen-key                Gerar chave RSA 4096 em formato PEM
  -c|--clean                   Limpar diretórios de trabalho
  -p|--print-config            Imprimir configuracao do /etc/pkgmake.conf
  -k|--pkgdest <path>          Diretório local onde os pacotes (.xbps) e o repodata serão gerados
  -h, --help                   Mostrar este ajuda

Exemplos:
  pkgmake
  pkgmake -s -i
  pkgmake --sign
  pkgmake --sign-only --privkey minha-chave.pem
  pkgmake -q
```

ARQUIVO DE CONFIGURAÇÃO
-----------------------
O pkgmake carrega automaticamente:

```
/etc/pkgmake.conf
```

Valores definidos via **linha de comando sobrescrevem**
o arquivo de configuração.

---

ARQUIVO PKGFILE
---------------
O **PKGFILE** é um script shell simples, inspirado diretamente no
**PKGBUILD do Arch Linux** e compatível com o **template de pacotes do Void Linux**.

A sintaxe, os campos e a estrutura seguem o padrão tradicional usado por
sistemas de empacotamento baseados em shell, permitindo reaproveitamento
e adaptação de receitas existentes com o mínimo de ajustes.

Na prática:
- Um **PKGBUILD do Arch** pode ser adaptado facilmente para um **PKGFILE**
- Um **template do Void Linux** pode ser usado quase sem modificações

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
---

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
- pkgmake **não substitui** o XBPS, ele usa as ferramentas!
- Deve ser executado como **usuário comum**
- Apenas a instalação de dependências requer privilégios
- O fluxo segue estritamente o que está definido no `PKGFILE`

LICENÇA
-------
MIT

AUTOR
-----
Vilmar Catafesta <vcatafesta@gmail.com>  
Projeto VoidLinuxBr
