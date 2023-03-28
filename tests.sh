source bashtest.sh

test_assert() {
  assert "test assert" "*st ass*"
}

# shellcheck disable=SC2116
test_mock() {
  result=$(echo param1 param2)
  assert_result=$(assert "$result" "Mocked echo###params=param1 param2###")
  assert "$assert_result" "*tests.sh failed in function 'test_mock' at line 10*"
  mock echo
  result=$(echo param1 param2)
  assert "$result" "Mocked echo###params=param1 param2###"
}

test_run_tests() {
  for test_function in $(declare -F); do
    if [[ "$test_function" = "test"* ]]; then
      unset -f "$test_function"
    fi
  done
  test_ok() {
    assert "OK" "OK"
  }
  test_error() {
    assert "ERROR" "OK"
  }
  result=$(run_tests)
  assert "$result" "*tests.sh failed in function 'test_error' at line 27.*test_error*ERROR*test_ok*OK*"
}

run_tests