class GitGraphTui < Formula
  desc "A Git Graph for the terminal: colored commit graph with context menus for checkout, merge, rebase, cherry-pick, reset and more."
  homepage "https://github.com/allient/git-graph-tui"
  version "0.6.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/allient/git-graph-tui/releases/download/v0.6.1/git-graph-tui-aarch64-apple-darwin.tar.xz"
      sha256 "cb5ac7d3605e6cecd30f8cc2e4d78a454e6fab25f27e987a5d25694074131dbe"
    end
    if Hardware::CPU.intel?
      url "https://github.com/allient/git-graph-tui/releases/download/v0.6.1/git-graph-tui-x86_64-apple-darwin.tar.xz"
      sha256 "12e1cd4f5208443e8612153d06c457ea3d5ae2574e5b8504782eb1d10dae8111"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/allient/git-graph-tui/releases/download/v0.6.1/git-graph-tui-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "81d3f1ad4d2bfe386a56cc392f126df0c69c3d4da772049efbf1596c64feff25"
    end
    if Hardware::CPU.intel?
      url "https://github.com/allient/git-graph-tui/releases/download/v0.6.1/git-graph-tui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "8689204a0791f1c8ef2e01cba4de02b490b6d4471124c5ba71129b85f55d5975"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "ggt"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "ggt"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "ggt"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "ggt"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
