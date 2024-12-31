git checkout -b elvismao
for i in {1..10}
do
    git checkout elvismao
    git fetch origin main
    git merge origin/main --no-ff --no-commit
    echo "" > emtech.cc
    git add emtech.cc
    git commit -m "Create EM" -m "" -m "Co-authored-by: Elvis Mao <info@elvismao.com>"
    git push --set-upstream origin elvismao
    gh pr create --title "Create EM" --body "Create EM" --base main --head elvismao
    gh pr merge --squash --auto

    rm emtech.cc
    git add emtech.cc
    git commit -m "Delete EM" -m "" -m "Co-authored-by: Elvis Mao <info@elvismao.com>"
    git push
    gh pr create --title "Delete EM" --body "Delete EM" --base main --head elvismao
    gh pr merge --squash --auto
done
