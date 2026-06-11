FROM archlinux:latest

RUN pacman -Syu --noconfirm \
    base-devel \
    git \
    neovim \
    tree-sitter-cli \
    util-linux \
  && pacman -Scc --noconfirm

ENV TERM=xterm-256color

WORKDIR /repro
COPY . .

RUN git submodule update --init --recursive || test -f vendor/tree-sitter-haskell/src/parser.c
RUN ./setup.sh

CMD ["./repro.sh"]
