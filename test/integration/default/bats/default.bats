@test "installs the correct version of Ruby" {
  ruby --version | grep 1.9.3p484
}
