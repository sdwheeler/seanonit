---
title: Tracking changes
weight: 4
navWeight: 7
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

![Tracking changes][02]

The files in your working directory can be in one of two states: tracked or untracked.

- Tracked files are files that were include in the last snapshot. They can be unmodified, modified,
  or staged. By definition, these files are tracked by the Git index (staging area).
- Untracked files are any files in your working directory that were not in your last snapshot and
  are not in your staging area. When you first clone a repository, all of your files will be tracked
  and unmodified because they were in the last snapshot. As you modify files, Git sees them as
  modified because you have changed them since your last commit. You stage these modified files and
  then commit them to save the snapshot permanently in your Git directory.

## Git commands to track changes

- `git status` - Shows the status of changes as untracked, modified, or staged
- `git add` - Adds changes to the staging area
- `git commit` - Saves the snapshot permanently in your Git directory

The following screenshots show the progression of changes to the working directory and how they are
tracked by Git.

In the first screenshot, you can see that the local working directory contains one file,
`README.md`. The `git status` command shows the working tree is clean. Next, the `README.md` files
is edited and two license files are copied from another location. The `git status` command shows one
modified file and two untracked files. Notice how the prompt changes with each command.

![Step 1 - Create and update files](images/gitfundamentals/s4-git-cmd-01.png)

The `git add` command is used to add a license file to the staging area. The `git status` command
shows that `LICENSE-CODE.md` is now staged.

![Step 2 - Add a file to the index](images/gitfundamentals/s4-git-cmd-02.png)

The `git add -A` command adds all files to the staging area. The `git status` command shows that all
three files are now staged.

![Step 3 - Add all files to the index and commit](images/gitfundamentals/s4-git-cmd-03.png)

The `git commit` command is used to save the changes to the local repository. Finally, the
`git push` command is used to push the changes to GitHub.

![Step 4 - Push changes to GitHub](images/gitfundamentals/s4-git-cmd-04.png)

Now we can see the changes in GitHub. The `README.md` file is shown with the changes and the two
license files are shown as new files.

![Step 5 - Show file in GitHub](images/gitfundamentals/s4-git-cmd-05.png)

<!-- link references -->
[02]: images/gitfundamentals/slide4.png
