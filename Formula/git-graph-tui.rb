class GitGraphTui < Formula
  desc "A Git Graph for the terminal: colored commit graph with context menus for checkout, merge, rebase, cherry-pick, reset and more."
  homepage "https://github.com/allient/git-graph-tui"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/allient/git-graph-tui/releases/download/v0.1.0/git-graph-tui-aarch64-apple-darwin.tar.xz"
      sha256 "6f144eace61fb5370e21cb1ccfddb5035af926af74ec0ec3cbdab0c8679565df"
    end
    if Hardware::CPU.intel?
      url "https://github.com/allient/git-graph-tui/releases/download/v0.1.0/git-graph-tui-x86_64-apple-darwin.tar.xz"
      sha256 "c39aafc74f3cf01404b74a2b757c16f904c4a7c8c19b77f2d9ad36d2504269a2"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/allient/git-graph-tui/releases/download/v0.1.0/git-graph-tui-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "7c94b230515352395a4a153978156902ef1e5cd8a1e7f65d21a18dddd34d8ec4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/allient/git-graph-tui/releases/download/v0.1.0/git-graph-tui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "513bc9a16ad2d65152796afed50eadbf2001b15fb39c54a3e8f5afb64cb4a070"
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
