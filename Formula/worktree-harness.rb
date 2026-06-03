class WorktreeHarness < Formula
  desc "Parallel coding-agent sessions in isolated git worktrees with safe merge-back"
  homepage "https://github.com/renchris/worktree-harness"
  url "https://github.com/renchris/worktree-harness/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "be0a041fcfb57ac91a3fe697556323cfb0fb5e2b42d8d31c531c7c88a16be070"
  license "MIT"
  head "https://github.com/renchris/worktree-harness.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on "git"

  def install
    # The dispatcher resolves lib/ and share/ relative to its own location
    # (../lib, ../share), so keep them together under libexec and symlink the
    # entry point onto PATH.
    libexec.install "bin", "lib", "share"
    bin.install_symlink libexec/"bin/worktree-harness"
    doc.install "README.md", "CHANGELOG.md"
  end

  test do
    assert_match "worktree-harness #{version}", shell_output("#{bin}/worktree-harness --version")

    # `init` scaffolds a .harnessrc in a fresh repo.
    system "git", "-C", testpath, "init", "-q"
    system bin/"worktree-harness", "-C", testpath, "init"
    assert_path_exists testpath/".harnessrc"
  end
end
