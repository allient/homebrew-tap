class GitGraphTui < Formula
  desc "A Git Graph for the terminal: colored commit graph with context menus for checkout, merge, rebase, cherry-pick, reset and more."
  homepage "https://github.com/allient/git-graph-tui"
  version "0.6.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/allient/git-graph-tui/releases/download/v0.6.2/git-graph-tui-aarch64-apple-darwin.tar.xz"
      sha256 "bc2d026f6ce5b166789fb7748571a4c0ffcb8b9402a43b2cfbf1777a38eb4855"
    end
    if Hardware::CPU.intel?
      url "https://github.com/allient/git-graph-tui/releases/download/v0.6.2/git-graph-tui-x86_64-apple-darwin.tar.xz"
      sha256 "e107ae4391e19ae81ff56e4d5b68cd2f12df45f965e3e5c5b2beaf9ae8762962"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/allient/git-graph-tui/releases/download/v0.6.2/git-graph-tui-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "9ead8ad7643bfcc647aa591f5d6a5c5322cc648fdf9e3bd562f03fec637ff5e6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/allient/git-graph-tui/releases/download/v0.6.2/git-graph-tui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "485e08ab3abddefeb0254909a53a2b2556052d5a7dfcac6215c986869a6ca328"
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
