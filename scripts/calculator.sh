#!/bin/bash
# calculator.sh - Basic calculator in Bash

echo "Enter first number:"
read num1

echo "Enter second number:"
read num2

echo "Choose an operation: + - * /"
read op

case $op in
  +)
    result=$((num1 + num2))
    ;;
  -)
    result=$((num1 - num2))
    ;;
  \*)
    result=$((num1 * num2))
    ;;
  /)
    if [ "$num2" -eq 0 ]; then
      echo "🚫 Error: Division by zero!"
      exit 1
    fi
    result=$((num1 / num2))
    ;;
  *)
    echo "❌ Invalid operator"
    exit 1
    ;;
esac

echo "Result: $result"
