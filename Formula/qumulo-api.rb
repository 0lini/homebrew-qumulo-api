class QumuloApi < Formula
  include Language::Python::Virtualenv

  desc "Python API for Qumulo Core REST API"
  homepage "https://pypi.org/project/qumulo-api/" 
  url "https://files.pythonhosted.org/packages/d3/43/cb66667f075c7d851ee38f199ca2b62dabc5d9184102a13b23a332d40da1/qumulo_api-7.7.3-py3-none-any.whl"
  sha256 "eab9b488800a3bd82a862364bb1e98331601d8c88c1d3982be47bcdae9c3e64d"
  license "Apache-2.0"

  depends_on "python@3.13"

  resource "argcomplete" do
    url "https://files.pythonhosted.org/packages/38/61/0b9ae6399dd4a58d8c1b1dc5a27d6f2808023d0b5dd3104bb99f45a33ff6/argcomplete-3.6.3.tar.gz"
    sha256 "62e8ed4fd6a45864acc8235409461b72c9a28ee785a2011cc5eb78318786c89c"
  end

  resource "marshmallow" do
    url "https://files.pythonhosted.org/packages/6d/30/14d8609f65c8aeddddd3181c06d2c9582da6278f063b27c910bbf9903441/marshmallow-3.23.1.tar.gz"
    sha256 "3a8dfda6edd8dcdbf216c0ede1d1e78d230a6dc9c5a088f58c4083b974a0d468"
  end

  resource "typing-inspect" do
    url "https://files.pythonhosted.org/packages/dc/74/1789779d91f1961fa9438e9a8710cdae6bd138c80d7303996933d117264a/typing_inspect-0.9.0.tar.gz"
    sha256 "b23fc42ff6f6ef6954e4852c1fb512cdd18dbea03134f91f856a95ccc9461f78"
  end

  resource "mypy-extensions" do
    url "https://files.pythonhosted.org/packages/a2/6e/371856a3fb9d31ca8dac321cda606860fa4548858c0cc45d9d1d4ca2628b/mypy_extensions-1.1.0.tar.gz"
    sha256 "52e68efc3284861e772bbcd66823fde5ae21fd2fdb51c62a211403730b916558"
  end

  resource "six" do
    url "https://files.pythonhosted.org/packages/94/e7/b2c673351809dca68a0e064b6af791aa332cf192da575fd474ed7d6f16a2/six-1.17.0.tar.gz"
    sha256 "ff70335d468e7eb6ec65b95b99d3a2836546063f63acc5171de367e834932a81"
  end

  resource "dataclasses-json" do
    url "https://files.pythonhosted.org/packages/64/a4/f71d9cf3a5ac257c993b5ca3f93df5f7fb395c725e7f1e6479d2514173c3/dataclasses_json-0.6.7.tar.gz"
    sha256 "b6b3e528266ea45b9535223bc53ca645f5208833c29229e847b3f26a1cc55fc0"
  end

  resource "python-dateutil" do
    url "https://files.pythonhosted.org/packages/66/c0/0c8b6ad9f17a802ee498c46e004a0eb49bc148f2fd230864601a86dcf6db/python-dateutil-2.9.0.post0.tar.gz"
    sha256 "37dd54208da7e1cd875388217d5e00ebd4179249f90fb72437e91a35459a0ad3"
  end

  resource "tqdm" do
    url "https://files.pythonhosted.org/packages/a8/4b/29b4ef32e036bb34e4ab51796dd745cdba7ed47ad142a9f4a1eb8e0c744d/tqdm-4.67.1.tar.gz"
    sha256 "f8aef9c52c08c13a65f30ea34f4e5aac3fd1a34959879d7e59e63027286627f2"
  end

  resource "typing-extensions" do
    url "https://files.pythonhosted.org/packages/72/94/1a15dd82efb362ac84269196e94cf00f187f7ed21c242792a923cdb1c61f/typing_extensions-4.15.0.tar.gz"
    sha256 "0cea48d173cc12fa28ecabc3b837ea3cf6f38c6d1136f85cbaaf598984861466"
  end

  def install
    # Create virtualenv
    venv = virtualenv_create(libexec, "python3")
    
    # Install dependencies (resources) from source
    venv.pip_install resources
    
    # Install the main package (wheel file) from the cached download
    # The wheel file is downloaded to buildpath and needs to be installed directly
    whl = buildpath.glob("*.whl").first
    raise "Wheel file not found in buildpath" if whl.nil?
    
    venv.pip_install_and_link whl

    # Generate shell completions for qq CLI
    generate_completions_from_executable(libexec/"bin/register-python-argcomplete", "qq",
                                         shell_parameter_format: :arg)

    # Build an :all bottle by replacing hardcoded paths
    site_packages = libexec/Language::Python.site_packages("python3")
    inreplace site_packages/"argcomplete-#{resource("argcomplete").version}.dist-info/METADATA",
              "/opt/homebrew/bin/bash",
              "$HOMEBREW_PREFIX/bin/bash"
  end

  test do
    output = shell_output("#{bin}/qq --help")
    assert_match "usage", output
  end
end
