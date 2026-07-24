class Typefaster < Formula
  include Language::Python::Virtualenv

  desc "Terminal-first typing game with ghosts, a coach, and live multiplayer"
  homepage "https://github.com/Anoshor/typefaster-cli"
  url "https://files.pythonhosted.org/packages/73/62/e8afed8ae68df981056019476d872de9c040a05df80c29bd7a7ac3d55477/typefaster_cli-0.3.3.tar.gz"
  sha256 "47bf3ef92e8792f235d06581a64dc1b496083a7eb2c646ac30e562b771cf8bbf"
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
