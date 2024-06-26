{ lib
, buildPythonPackage
, fetchFromGitHub
, pythonOlder
, setuptools
, requests
, pytestCheckHook
, mock
}:

buildPythonPackage rec {
  pname = "linode-api";
  version = "5.13.1";
  pyproject = true;

  disabled = pythonOlder "3.6";

  # Sources from Pypi exclude test fixtures
  src = fetchFromGitHub {
    owner = "linode";
    repo = "python-linode-api";
    rev = "refs/tags/v${version}";
    hash = "sha256-WB4CurdokRKh1eD6FZR2SeMpa3Z0BzLb0ldI7SYPEVI=";
  };

  nativeBuildInputs = [
    setuptools
  ];

  propagatedBuildInputs = [
    requests
  ];

  nativeCheckInputs = [
    mock
    pytestCheckHook
  ];

  pythonImportsCheck = [ "linode_api4" ];

  meta = with lib; {
    description = "Python library for the Linode API v4";
    homepage = "https://github.com/linode/python-linode-api";
    license = licenses.bsd3;
    maintainers = with maintainers; [ glenns ];
  };
}
