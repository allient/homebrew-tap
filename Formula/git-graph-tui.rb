class GitGraphTui < Formula
  desc "A Git Graph for the terminal: colored commit graph with context menus for checkout, merge, rebase, cherry-pick, reset and more."
  homepage "https://github.com/allient/git-graph-tui"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/allient/git-graph-tui/releases/download/v0.2.0/git-graph-tui-aarch64-apple-darwin.tar.xz"
      sha256 "b1fc1f06615433f66137f3f221d3519bf5dfa2cf7a520852406e5908cbb6908b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/allient/git-graph-tui/releases/download/v0.2.0/git-graph-tui-x86_64-apple-darwin.tar.xz"
      sha256 "65b5e9f37a70a611168ccbf25418a7efaef1a91ad45e305677bafcad1793ceaf"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/allient/git-graph-tui/releases/download/v0.2.0/git-graph-tui-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "5fa4af581880ba8ecac36733bf772f5df70f68ef7fbeddbc32257477f28d0edb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/allient/git-graph-tui/releases/download/v0.2.0/git-graph-tui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "d56f65ab9a9c7cc1affc0faa7f767a44ed82294fa105213b0c3551cd89fafbb5"
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
      bin.install "git-graph-tui"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "git-graph-tui"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "git-graph-tui"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "git-graph-tui"
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
