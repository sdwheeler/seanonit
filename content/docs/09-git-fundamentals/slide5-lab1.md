---
title: Lab 1 - Create a new repository and add files
weight: 5
navWeight: 6
featured: false
draft: false
comment: false
toc: true
pinned: false
postDate: false
date: 2025-03-12
index: true
---
<!-- markdownlint-disable MD041 -->

The goal of this lab is to create a new repository and sync it with GitHub.

Prerequisites:

- A GitHub account
- Tools installed on your local machine:
  - Visual Studio Code
  - Git and GitHub CLI - see [Setting Up Git for PowerShell][01]
  - PowerShell with the **posh-git** module - see [Installing and Using Posh-Git][02]

## Step 1 - Create a new repository

There are two ways to create a new repository when you want to host a copy of it on GitHub.

1. Create a new repository on GitHub and then clone it to your local machine. This is the easiest
   and most common way to create a new repository.
1. Create a new repository on your local machine and in GitHub, then push the local respository to
   GitHub. This method is more complicated but is useful if you have an existing project that you
   want to host on GitHub.

### Option 1 - Create a new repository on GitHub and clone it

GitHub lets you add a README file at the same time you create your new repository. GitHub also
offers other common options such as a license file, but you don't have to select any of them now.

1. In the upper-right corner of any page, select `+` , then click **New repository**.

   ![New repository][05]

1. In the **Repository name** box, type in a name for your project (no spaces or special
   characters). For this lab, choose a name that's different from your lab partner's name. For
   example, you could add your initials to create a name like `sdwGitFun`.
1. In the **Description** box, type a short description. For example, type "This repository is for
   practicing the GitHub Flow."
1. Select whether your repository to be **Public** or **Private**.
1. Select **Add a README** file.
1. Click **Create** repository.
1. Copy the URL of the repository. You need this URL to clone the repository to your local machine.

   ![Clone repository URL][04]

1. In your terminal, navigate to the directory where you want to clone the repository. For example,
   type `cd ~/Git` and press Enter.
1. Type `git clone <repository URL>` and press Enter.

   Git creates a new directory with the same name as the repository and copies all of the files from
   the remote repository to your local machine.

### Option 2 - Create a new repository on your local machine and push it to GitHub

1. In your terminal, navigate to the directory where you want to create the new repository. For
   example, type `cd ~/Git` and press Enter.
1. Type `mkdir <repository name>` and press Enter. For example, type `mkdir git-fundamentals` and
   press Enter.
1. Type `cd <repository name>` and press Enter. For example, type `cd git-fundamentals` and press
   Enter.
1. Type `git init` and press Enter.
1. Type `git status` and press Enter. You should see a message that says "On branch main" and
   "No commits yet."
1. Using Visual Studio Code, create a new file called `README.md` in the new repository
   directory. Type a short description of the project in the file and save it.
1. Type `git add README.md` and press Enter. This adds the README file to the staging area.
1. Type `git commit -m "Initial commit"` and press Enter. This creates the first commit in the
   repository.
1. Follow the instructions in the previous section to create a new repository on GitHub, but don't
   select the options to add any files. Use the same name as the local repository.
1. Copy the URL of the new repository.
1. Type `git remote add origin <repository URL>` and press Enter. This adds the remote repository
   to your local repository.
1. Type `git push -u origin main` and press Enter. This pushes the local repository to GitHub. The
   `-u` option sets the upstream branch for the local repository to the remote repository. This
   means that you can use `git push` and `git pull` without specifying the remote repository in the
   future.

## Step 2 - Add files to the repository

Now take a few minutes to add files to the repository. You can add any files you want, but here are a
few suggestions:

- Create a new file called `LICENSE.md` and add a license to the file. You can use the [ChooseALicense
  website](https://choosealicense.com/) to help you choose a license.
- Create a new file called `CONTRIBUTING.md` and add a short description of how to contribute to the
  project.
- Create a new file called `CHANGELOG.md` and add a short description of the changes made to the
  project.

Use the commands you learned in [Tracking changes][03] to add the files to the staging area
and commit.

<!-- link references -->
[01]: ../../04-github/slide3
[02]: ../../04-github/slide4
[03]: ../slide4
[04]: images/gitfundamentals/s5-github-clone-repo.png
[05]: images/gitfundamentals/s5-github-new-repo.png
