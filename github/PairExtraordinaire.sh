for i in {1..10}
do
    # Ensure you're on rileyho branch
    git checkout rileyho

    # Pull latest changes from main to keep rileyho up-to-date
    git fetch origin main
    git merge origin/main --no-ff --no-commit
    
    # Create Riley file, commit and push
    echo "Riley" > Riley.uwu
    git add Riley.uwu
    git commit -m "Create Riley" -m "" -m "Co-authored-by: Riley Ho <riley@rileychh.dev>"
    git push --set-upstream origin rileyho

    # Create pull request
    gh pr create --title "Create Riley" --body "Create Riley" --base main --head rileyho
    gh pr merge --squash --auto

    # Remove Riley file, commit and push
    rm Riley.uwu
    git add Riley.uwu
    git commit -m "Delete Riley" -m "" -m "Co-authored-by: Riley Ho <riley@rileychh.dev>"
    git push

    # Create pull request for deletion
    gh pr create --title "Delete Riley" --body "Delete Riley" --base main --head rileyho
    gh pr merge --squash --auto
done
