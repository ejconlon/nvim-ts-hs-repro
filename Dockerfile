FROM archlinux:latest

RUN pacman -Syu --noconfirm \
    base-devel \
    git \
    neovim \
    tree-sitter-cli \
    util-linux \
  && pacman -Scc --noconfirm

WORKDIR /repro
COPY . .

RUN git submodule update --init --recursive || test -f vendor/tree-sitter-haskell/src/parser.c
RUN ./setup.sh

CMD ["sh", "-lc", "rm -f /tmp/nvim-ts-hs-repro.log; timeout 10s script -qfec './repro.sh' /tmp/nvim-ts-hs-repro.log; status=$?; cat /tmp/nvim-ts-hs-repro.log; exit $status"]
