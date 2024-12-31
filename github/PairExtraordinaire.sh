for i in {1..10}
do
    git checkout rileyho
    echo "Riley" > Riley.uwu
    git add Riley.uwu
    git commit -m "Create Riley" -m "" -m "Co-authored-by: Riley Ho <riley@rileychh.dev>"
    git push --set-upstream origin rileyho
    # create pull request
    gh pr create --title "Create Riley" --body "Create Riley" --base main --head rileyho
    gh pr merge --squash --auto
    rm Riley.uwu
    git add Riley.uwu
    git commit -m "Delete Riley" -m "" -m "Co-authored-by: Riley Ho <riley@rileychh.dev>"
    git push
    # create pull request
    gh pr create --title "Delete Riley" --body "Delete Riley" --base main --head rileyho
    gh pr merge --squash --auto
done
