class QumuloApi < Formula
  include Language::PYTHON::Virtualenv

  desc
  homepage 
  url "https://files.pythonhosted.org/packages/d3/43/cb66667f075c7d851ee38f199ca2b62dabc5d9184102a13b23a332d40da1/qumulo_api-7.7.3-py3-none-any.whl"
  sha256 "eab9b488800a3bd82a862364bb1e98331601d8c88c1d3982be47bcdae9c3e64d"
  license "Apache-2.0"

  depends_on "python@3.14"

  def install
    virtualedv_install_with_resources
  end

  test do
    output = shell_output("#{bin}/qq --help")
    assert_match "usage", output
  end
end
