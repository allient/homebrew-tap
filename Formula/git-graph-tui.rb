class GitGraphTui < Formula
  desc "A Git Graph for the terminal: colored commit graph with context menus for checkout, merge, rebase, cherry-pick, reset and more."
  homepage "https://github.com/allient/git-graph-tui"
  version "0.4.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/allient/git-graph-tui/releases/download/v0.4.0/git-graph-tui-aarch64-apple-darwin.tar.xz"
      sha256 "be48379257e0385950b8a095c38f5a1f577b82caea289170e51aec0742eb78d5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/allient/git-graph-tui/releases/download/v0.4.0/git-graph-tui-x86_64-apple-darwin.tar.xz"
      sha256 "fc2ece1dbd741e3893e8b18b39c3aa30634a87d10263b7982be22ea7d57a89c8"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/allient/git-graph-tui/releases/download/v0.4.0/git-graph-tui-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "c5bad6b20aa91ec2b8ee02f34766fe252355aa1944b9f08a3cf648fd3c8853ed"
    end
    if Hardware::CPU.intel?
      url "https://github.com/allient/git-graph-tui/releases/download/v0.4.0/git-graph-tui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "7c055f3f6f27854517395a4c9cb5e2a7c5bc44ca7b5c14ee2cb19c27d2e26c5a"
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
