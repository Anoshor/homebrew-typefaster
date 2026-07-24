class Typefaster < Formula
  include Language::Python::Virtualenv

  desc "Terminal-first typing game with ghosts, a coach, and live multiplayer"
  homepage "https://github.com/Anoshor/typefaster-cli"
  url "https://files.pythonhosted.org/packages/38/9a/a7672da775fac0da534f803b3099098b3ecefe9cb2866ffd11f83df63c02/typefaster_cli-0.3.2.tar.gz"
  sha256 "64f99305d03db69392fce45940050db4b03dfc10d28449a869bd04e03cad3c32"
  license "MIT"

  depends_on "python@3.12"

  # Fast install: Homebrew downloads + sha256-verifies the sdist above, then pip
  # installs it into an isolated venv, pulling dependencies as prebuilt wheels
  # from PyPI (seconds) instead of building 20 vendored sdists from source
  # (~1 min). Fine for a personal tap; homebrew-core would require vendoring.
  def install
    virtualenv_create(libexec, "python3.12")
    # The venv is created --without-pip; drive pip as a module via the venv's
    # python (resolved from the brewed python's site-packages).
    system libexec/"bin/python", "-m", "pip", "install",
           "--no-cache-dir", "--quiet", buildpath.to_s
    bin.install_symlink libexec/"bin/typefaster"
  end

  test do
    assert_match "typefaster", shell_output("#{bin}/typefaster version")
  end
end
