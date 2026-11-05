class GitGraphTui < Formula
  desc "A Git Graph for the terminal: colored commit graph with context menus for checkout, merge, rebase, cherry-pick, reset and more."
  homepage "https://github.com/allient/git-graph-tui"
  version "0.3.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/allient/git-graph-tui/releases/download/v0.3.4/git-graph-tui-aarch64-apple-darwin.tar.xz"
      sha256 "eefcdd39dba46628ba9b41b5ad2dc61ea56e36646acaf9aa3126315f7bf99112"
    end
    if Hardware::CPU.intel?
      url "https://github.com/allient/git-graph-tui/releases/download/v0.3.4/git-graph-tui-x86_64-apple-darwin.tar.xz"
      sha256 "7c284ee4e16a6b2cc147cef2dff7aa0147d1844e363b2ffd7f02d3a1447afb0f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/allient/git-graph-tui/releases/download/v0.3.4/git-graph-tui-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "fff54f1403ef5c2b795528bcc05e7d1e024e852cf9180fb290e6492d1eabd8d5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/allient/git-graph-tui/releases/download/v0.3.4/git-graph-tui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "0a88017520b0f36b03db8b8a749f713da4c56df86292c0d73c7f61f3a77c0ad1"
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
