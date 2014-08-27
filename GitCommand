#Git Commands

### Unstage changes
	git reset [file]
### Clean up previous commits before sending upstream
	git rebase -i HEAD~n
	git rebase -i master mybranch
### Undoes all changes
	git reset --hard [commit]
### Pull requests/tracking branches
	[git remote add -f foobar git://github...] # set up remote
	git branch --track newbranch foobar/whichbranch
### Revert a single file
	git checkout -- [file]
### Revert to a commit
	revert -n [commit]
### Push to remote branch
	git push [remote] HEAD:[remote-branch]
	git push origin HEAD
	git push origin :branch (delete remote branch)
### Diff options

```
git diff [commit] [commit]
git diff master:file branch:file
git diff HEAD^ HEAD
git diff master..branch
git diff --cached
git diff --summary
git diff --name-only
git diff --name-status
git diff -w # ignore all whitespace
git diff --relative[=path] (run from subdir or set path)
```

### Stashing
```
git stash list
git stash show -p stash@{2}
git stash [pop|apply] stash@{@2}
git stash drop stash@{2}
```
### Log|Shortlog options
### --author=jenny, --pretty=oneline, --abbrev-commit,
### --no- merges, --stat, --since, --topo-order|--date-order
```
git log -- <filename> # history of a file, deleted too
git log dir/ # commits that modify any file under dir/
git log test..master # commits on master but not test
git log master..test # commits on test but not master
git log master...test # commits on either test or master
```
### Merge files from another branch
```
git checkout master
git checkout feature path/to/file
into master
path/to/another/file
                      # but not both
git log -S'foo()' # commits that add or remove any file data
```
### Branching
```
git branch [-a | -r]
git checkout -b newbranch
git branch -d oldbranch
git branch -m oldbranch newbranch
                    # matching the string 'foo()'
git show :/fix # last commit w/"fix" in msg
```
### Compare master vs branch
```
git diff master..branch
git diff master..branch | grep "^diff" # changed files only
git shortlog master..branch
git show-branch
git whatchanged master..mybranch
git cherry –v <upstream> [<head>] #commits not merged upstream
```
### Interrupt WIP with quick fix
```
git stash save "Log msg."
vi file;
git commit -a
git config core.autocrlf input
git config core.safecrlf true
git config --global push.default tracking # only push current
```
### Sync branch to master
```
git checkout master
git pull
```
### Test incremental changes to a single file
```
git add --patch [file]
git stash save --keep-index "Log msg."
[test patch]
```
### Merge upstream changes with WIP
```
git stash save "Log msg."
git [pull|rebase master]
git stash apply
```
### Copy commit from another branch

```
git cherry-pick –x [commit] # -x appends orig commit message
git stash pop
git commit
git stash pop
...repeat...
Git Basics
```
### Edit file

```
vi joke.txt
git diff
git commit –a
git status
```
## Daily workflow
### Add new file
```
vi new.txt
git add new.txt
git commit
git status
```
### Create a new workspace
```
git checkout –b bug1234
```

### Remove file
```
git rm new.txt
git commit
git status
```


### Back to master to sync with origin
```
git checkout master
git pull
```
### Move file
```
git mv old.txt new.txt
git commit
git status
```
### Back to workspace to fold in latest code
### Rebase upstream changes into my downstream branch
```
git checkout bug1234
git rebase master
```
### Get latest and greatest code from origin
```
git checkout master
git pull
```
### Fix bug 1234 and commit changes
```
vi bugfix.txt
git commit –a
```
### Validate my change against latest stable code
	run unittest.txt
### Ready to send downstream changes to master
### Merge my workspace and master so they have identical commits
```
git checkout master
git merge bug1234
```
### Push my downstream changes up to origin
	git push
### Delete my workspace
	git branch –d bug1234
