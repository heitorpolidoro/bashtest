#!/bin/bash
# Enable expanding aliases in this script
shopt -s expand_aliases

assert() {
	# shellcheck disable=SC2053
	if [[ $1 = $2 ]]; then
		true
	else
		echo "${BASH_SOURCE[1]} failed in function '${FUNCNAME[1]}' at line ${BASH_LINENO[0]}."
		echo -e "EXPECTED:\n$2\nACTUAL:\n$1\n"
		false
	fi
}

run_tests() {
	error_code=0
	for test_function in $(declare -F); do
		if [[ "$test_function" = "test"* ]]; then
			if $test_function; then
				result="OK"
			else
				result="ERROR"
				error_code=1
			fi
			echo -e "$test_function\t$result"
		fi
	done
	exit $error_code
}

mock() {
	mocked_return() {
		echo "###params=$*###"
	}

	# shellcheck disable=SC2139
	# shellcheck disable=SC2140
	alias "$1"="echo -n Mocked $1; mocked_return"
}
