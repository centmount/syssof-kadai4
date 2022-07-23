#!/bin/bash

if [ $# -ne 2 ]; then # 引数の数が2でない場合(not equal)
  echo "input 2 argments" 1>&2 # エラーメッセージ
  exit 1 # 終了ステータス
fi

expr $1 + $2 > /dev/null 2>&1 # exprに数字以外を渡すと終了ステータスが2以上
if [ $? -ge 2 ]; then # その場合
  echo "input natural number" 1>&2 # エラーメッセージ
  exit 1 # 終了ステータス
fi

if [[ "$1" =~ ^[0-9]+$ && "$2" =~ ^[0-9]+$ ]] # 2つの引数に整数
then
  if [ "$1" -gt "0" -a "$2" -gt "0" ] # 0より大きい自然数
  then
    if [ $1 -lt $2 ]
    then
      a=$2
      b=$1
    else
      a=$1
      b=$2
    fi
    r=`expr $a % $b`
    while [ ! $r -eq "0" ] # 余りrが0になるまで繰り返す
    do
      a=$b
      b=$r
      r=`expr $a % $b`
    done
    echo "Greatest common divisor is $b"  # 最大公約数
    exit 0
  else
    echo "input natural number" 1>&2
    exit 1
  fi
else
  echo "input natural number" 1>&2
  exit 1
fi

