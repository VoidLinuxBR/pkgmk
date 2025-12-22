#!/usr/bin/env bash
set -e

# pkgmake installer
# Instalação direta via GitHub
#
# Uso:
#   curl -fsSL https://raw.githubusercontent.com/<usuario>/pkgmake/main/install.sh | sudo sh
#
# Ou:
#   git clone https://github.com/<usuario>/pkgmake.git
#   cd pkgmake
#   sudo ./install.sh

PKGNAME="pkgmake"
BIN_DEST="/usr/bin"
SHARE_DEST="/usr/share/pkgmake"
CONF_DEST="/etc/pkgmake.conf"

die() {
  echo "erro: $*" >&2
  exit 1
}

need_cmd() {
  command -v "$1" >/dev/null 2>&1 || die "comando '$1' não encontrado"
}

info() {
  echo "==> $*"
}

# Checagens básicas
need_cmd install
need_cmd mkdir
need_cmd cp

if [[ $EUID -ne 0 ]]; then
  die "execute este instalador como root (sudo)"
fi

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

[[ -f "$SCRIPT_DIR/pkgmake" ]] || die "arquivo 'pkgmake' não encontrado"

info "Iniciando instalação do $PKGNAME..."

# Instala binário
info "Instalando binário em $BIN_DEST"
install -Dm755 "$SCRIPT_DIR/pkgmake" "$BIN_DEST/pkgmake"

# Instala arquivos auxiliares, se existirem
if [[ -d "$SCRIPT_DIR/share" ]]; then
  info "Instalando arquivos auxiliares em $SHARE_DEST"
  mkdir -p "$SHARE_DEST"
  cp -av "$SCRIPT_DIR/share/." "$SHARE_DEST/"
fi

# Instala configuração (estilo pacnew)
if [[ -f "$SCRIPT_DIR/pkgmake.conf" ]]; then
  if [[ -f "$CONF_DEST" ]]; then
    info "Configuração existente encontrada em $CONF_DEST"
    info "Instalando nova configuração como ${CONF_DEST}.pacnew"
    install -Dm644 "$SCRIPT_DIR/pkgmake.conf" "${CONF_DEST}.pacnew"
  else
    info "Instalando configuração padrão em $CONF_DEST"
    install -Dm644 "$SCRIPT_DIR/pkgmake.conf" "$CONF_DEST"
  fi
fi

info "Instalação concluída com sucesso."
info "Execute 'pkgmake --help' para começar."
