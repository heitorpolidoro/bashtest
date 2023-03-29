#!/bin/bash
# Set of functions to allow create tests for bash/shell scripts

# Enable expanding aliases in this script
shopt -s expand_aliases
# Array of ENV vars. Used to unset ENV vars after each test
TEMP_ENVS=()
###################################################################################################
# Return true if 2 strings are equals or false otherwise printing the values, actual and expected,
# the file and the line the assert was called
# ARGUMENTS:
#   actual: The string you are checking
#   expected: The string, or regex, you expected that match equals with actual
# OUTPUTS:
#   If the 2 string doesn't match, print the file, function name and line where the assert was
#   called, and the expected and actual parameters
# RETURN:
#   true if the 2 strings have a match, false otherwise
###################################################################################################
assert() {
	actual=$1
	expected=$2
	# shellcheck disable=SC2053
	if [[ $actual = $expected ]]; then
		true
	else
		echo "${BASH_SOURCE[1]} failed in function '${FUNCNAME[1]}' at line ${BASH_LINENO[0]}."
		echo -e "EXPECTED:\n${expected}\nACTUAL:\n${actual}\n"
		false
	fi
}
###################################################################################################
# Mock a command or a function printing the received parameters
# ARGUMENTS:
#   function_name: The of the function, or command, to mock
# OUTPUTS:
#   The parameters to the function
###################################################################################################
mock() {
	function_name=$1
	mocked_return() {
		echo "###params=$*###"
	}

	# shellcheck disable=SC2139
	# shellcheck disable=SC2140
	alias "$function_name"="echo -n Mocked $function_name; mocked_return"
}

###################################################################################################
# Set an environment variable to use only in the test case.
# ARGUMENTS:
#   name: The name of the environment variable
#   value: The value of the variable
###################################################################################################
set_env() {
	env_name=$1
	env_value=$2

	export "$env_name"="$env_value"
	TEMP_ENVS+=("$env_name")
}

###################################################################################################
# Run all the functions starting with "test_"
# OUTPUTS:
#   The result of each test
# RETURN:
#   0 if all the tests results is "OK", 1 otherwise
###################################################################################################
run_tests() {
	error_code=0
	for test_function in $(declare -F); do
		if [[ "$test_function" = "test_"* ]]; then
			if $test_function; then
				result="OK"
			else
				result="ERROR"
				error_code=1
			fi
			for t_env in "${TEMP_ENVS[@]}"; do
				unset "$t_env"
			done
			TEMP_ENVS=()
			echo -e "$test_function\t$result"
		fi
	done
	exit $error_code
}
