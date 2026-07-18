class Typefaster < Formula
  include Language::Python::Virtualenv

  desc "Terminal-first typing game with ghosts, a coach, and live multiplayer"
  homepage "https://github.com/Anoshor/typefaster-cli"
  url "https://files.pythonhosted.org/packages/85/c6/4f4af83f79e07fde36e4f06df6e03ab30e0ee8723c9fb57fb1f4d4a7f1fd/typefaster_cli-0.2.0.tar.gz"
  sha256 "27428ae6f698f5ce001183c9c03a4560ebe1c24479d873f4766675401481b800"
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
