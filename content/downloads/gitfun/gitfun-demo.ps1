﻿#-------------------------------------------------------------------------------
#region Demo script for Git Fun(damentals) presentation
throw "This script is not meant to be executed. Use F8 to run selected code."
# Setup the demo environment
# Adjust the path to the demo data for your environment
Set-Location C:\Git\My-Repos
#endregion
#-------------------------------------------------------------------------------
#region Install Git and posh-git
Write-Host '1. Download and install Git if it is not already installed'
Write-Host '2. Install posh-git from the PowerShell Gallery'
Write-Host '3. Read the documentation in the GitHub repository'
Install-PSResource -Name posh-git -Reinstall -PassThru
Import-Module -Name posh-git -Force -PassThru
Write-Host 'Add the Import-Module command to your PowerShell profile'
Start-Process 'https://git-scm.com/install/windows'
Start-Process 'https://www.powershellgallery.com/packages/posh-git/'
Start-Process 'https://github.com/dahlbyk/posh-git'
Pause
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
Write-Host "Create an empty repository in GitHub before proceeding"
# There are 2 ways to create a repository on GitHub:
Pause
# 1. Using the GitHub web interface, then
     git remote add origin https://github.com/sdwheeler/GitFunDemo.git
     git remote -v
# 2. Using the GitHub CLI
     gh repo create GitFunDemo --public --source=. --remote=origin
# Then push the initial commit to the remote repository
git push -u origin main
Pause
#endregion
#-------------------------------------------------------------------------------
#region Branching and merging
Start-Process 'https://git-school.github.io/visualizing-git/'
Pause
#endregion
#-------------------------------------------------------------------------------
#region Create a branch and add files to the repository
git checkout -b add-license-files
# Copy license file to the demo repo - https://choosealicense.com/
Copy-Item C:\Git\Hugo\seanonit\content\downloads\gitfun\LIC*.md

git status
git add .\LICENSE.md
git add .\LICENSE-CODE.md
git add -A
git push origin add-license-files
Write-Host 'Open the repository in the browser to verify the changes'
Invoke-Item https://github.com/sdwheeler/GitFunDemo
Pause
Write-Host 'Create a pull request to merge the add-license-files branch into main'
#endregion
#-------------------------------------------------------------------------------
#region Explore Git command
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
git branch -vr                    # List remote branches in your repository
git branch --all -v               # List local and remote branches in your repository
# Tools for visualizing branches
git log --oneline --graph
gitk
tig
#endregion
#-------------------------------------------------------------------------------
