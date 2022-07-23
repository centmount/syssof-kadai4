#!/bin/bash

tmp=/tmp/$$   # 変数を使って表記を短く
echo "input 2 argments" > $tmp-args      # 回答準備：引数の数
echo "input natural number" > $tmp-nat   # 回答準備：数字じゃない
echo "Greatest common divisor is 2" > $tmp-two # 回答準備:2を出力
echo "Greatest common divisor is 15" > $tmp-15 # 回答準備:15を出力

ERROR_EXIT () {
  echo "$1" >&2 # エラーメッセージ(引数1)を標準エラー出⼒に表⽰
  rm -f $tmp-* # 作ったファイルの削除
  exit 1 # エラー終了
}

# テスト開始
# test1: 引数の数が⾜りない
./gcd.sh 10 2> $tmp-ans && ERROR_EXIT "error in test1-1" # エラーメッセージを関数に渡す
diff $tmp-ans $tmp-args || ERROR_EXIT "error in test1-2"

# test2: 引数の数が多い
./gcd.sh 3 15 32 2> $tmp-ans && ERROR_EXIT "error in test2-1"
diff $tmp-ans $tmp-args || ERROR_EXIT "error in test2-2"

# test3: 文字を入力する
./gcd.sh 3 ten 2> $tmp-ans && ERROR_EXIT "error in test3-1"
diff $tmp-ans $tmp-nat || ERROR_EXIT "error in test3-2"

# test4: 2と4を入力する
./gcd.sh 2 4 > $tmp-ans || ERROR_EXIT "error in test4-1"
diff $tmp-ans $tmp-two || ERROR_EXIT "error in test4-2"

# test5: 0と4を入力する
./gcd.sh 0 4 2> $tmp-ans && ERROR_EXIT "error in test5-1"
diff $tmp-ans $tmp-nat || ERROR_EXIT "error in test5-2"

# test6: -1と-5を入力する
./gcd.sh -1 -5 2> $tmp-ans && ERROR_EXIT "error in test6-1"
diff $tmp-ans $tmp-nat || ERROR_EXIT "error in test6-2"

# test7: 45と60を入力する
./gcd.sh 45 60 > $tmp-ans || ERROR_EXIT "error in test7-1"
diff $tmp-ans $tmp-15 || ERROR_EXIT "error in test7-2"

# test8: 小数を入力する
./gcd.sh 1.3 9.8 2> $tmp-ans && ERROR_EXIT "error in test8-1"
diff $tmp-ans $tmp-nat || ERROR_EXIT "error in test8-2"

