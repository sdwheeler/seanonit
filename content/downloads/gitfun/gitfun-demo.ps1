﻿#-------------------------------------------------------------------------------
#region Demo script for Git Fun(damentals) presentation
throw "This script is not meant to be executed. Use F8 to run selected code."
# Setup the demo environment
# Adjust the path to the demo data for your environment
Set-Location D:\Git\My-Repos
#endregion
#-------------------------------------------------------------------------------
#region Create a new Git repository
mkdir GitFunDemo
cd GitFunDemo
git init
git status
"# This is the README file for the Git Fun(damentals) demo" |
    Out-File -FilePath README.md -Encoding utf8
git add README.md
git commit -m "Initial commit with README file"
#endregion
#-------------------------------------------------------------------------------
#region Connect to a remote repository
git remote add origin https://github.com/sdwheeler/GitFunDemo.git
git remote -v
git push -u origin main
#endregion
#-------------------------------------------------------------------------------
#region Add files to the repository
git status
Import-Module -Name posh-git -Force
# Copy license file to the demo repo - https://choosealicense.com/
Copy-Item C:\Git\My-Repos\seanonit\content\downloads\gitfun\LIC*.md
git status
git add .\LICENSE.md
git add .\LICENSE-CODE.md
git add -A
git push origin main
Invoke-Item https://github.com/sdwheeler/GitFunDemo.git
#endregion
#-------------------------------------------------------------------------------
#region Branching and merging
git branch new-branch             # only creates a branch, does not switch to it
git checkout -b new-branch        # creates and switches to a new branch
git checkout main                 # Switch to a branch
git checkout new-branch           # Switch to a branch
git merge-base main new-branch    # Find the common ancestor of two branches
git checkout main
git merge new-branch              # Merge a branch into the current branch
git rebase new-feature main       # Reapply commits on top of another base tip
git branch -d new-branch          # Delete a branch
git branch -v                     # List local branches in your repository
git remote -vr                    # List remote branches in your repository
git branch -all -v                # List local and remote branches in your repository
# Tools for visualizing branches
git log --oneline --graph
gitk
tig
#endregion
#-------------------------------------------------------------------------------
