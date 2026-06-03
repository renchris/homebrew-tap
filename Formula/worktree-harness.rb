class WorktreeHarness < Formula
  desc "Parallel coding-agent sessions in isolated git worktrees with safe merge-back"
  homepage "https://github.com/renchris/worktree-harness"
  url "https://github.com/renchris/worktree-harness/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "988a915954571e1b685bfc96a84cae021252286ffedbb26389d013dbcf2a301c"
  license "MIT"
  head "https://github.com/renchris/worktree-harness.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/renchris/homebrew-tap/releases/download/worktree-harness-0.2.0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "c52bf69662b8b6d5886318b26f4a23eddb20975264b234ccf3b8bf95349b0300"
  end

  depends_on "git"

  def install
    # The dispatcher resolves lib/ and share/ relative to its own location
    # (../lib, ../share), so keep them together under libexec and symlink the
    # entry point onto PATH.
    libexec.install "bin", "lib", "share"
    bin.install_symlink libexec/"bin/worktree-harness"

    bash_completion.install libexec/"share/completions/worktree-harness.bash" => "worktree-harness"
    zsh_completion.install libexec/"share/completions/_worktree-harness"
    fish_completion.install libexec/"share/completions/worktree-harness.fish"

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
