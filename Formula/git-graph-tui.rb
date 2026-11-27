class GitGraphTui < Formula
  desc "A Git Graph for the terminal: colored commit graph with context menus for checkout, merge, rebase, cherry-pick, reset and more."
  homepage "https://git-graph-tui.allient.io"
  version "0.7.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/allient/git-graph-tui/releases/download/v0.7.0/git-graph-tui-aarch64-apple-darwin.tar.xz"
      sha256 "7e9cdce0937c0460cc1089b01b76ff037bc0757cb04249f3ae9aa254712ff6e7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/allient/git-graph-tui/releases/download/v0.7.0/git-graph-tui-x86_64-apple-darwin.tar.xz"
      sha256 "4a3dd29b04df751e496bd67a0982316856e1953fb26985b34dadafe219c1f93a"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/allient/git-graph-tui/releases/download/v0.7.0/git-graph-tui-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "c2973502f5882c8e3f6d4374328f21baa2b7413681c3e20d3e029d483c0ed91d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/allient/git-graph-tui/releases/download/v0.7.0/git-graph-tui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "26bf354d198c39977512013e100966b3f67f84bb6ab6029e777bff19fd01427a"
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
