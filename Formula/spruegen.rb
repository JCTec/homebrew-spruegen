class Spruegen < Formula
  include Language::Python::Virtualenv

  desc "Deterministic sprue-tree generator for lost-wax ring casting"
  homepage "https://github.com/JCTec/spruegen"
  url "https://github.com/JCTec/spruegen/archive/refs/tags/v0.4.0.tar.gz"
  sha256 "8ae0bf8a7962ffede91ee8f321dcc9d32cf814474a17cdf22ccb9d7fd406c87b"
  license all_of: ["MIT", "CC-BY-4.0"]

  depends_on "python@3.12"

  def install
    virtualenv_create(libexec, "python3.12")
    # Prebuilt wheels for manifold3d/scipy/shapely/rtree instead of source builds.
    system libexec/"bin/pip", "install", "--no-cache-dir", "#{buildpath}[gui]"
    bin.install_symlink libexec/"bin/spruegen"
  end

  test do
    assert_match "Usage", shell_output("#{bin}/spruegen --help")
    assert_match "925", shell_output("#{bin}/spruegen materials list")
  end
end
