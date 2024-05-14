-- Remove the history from 
rm -rf .git

-- recreate the repos from the current content only
git init
git add .Appveyor/.
git add .Clean/.
git commit -m "Initial commit"

-- push to the github remote repos ensuring you overwrite history
git remote add origin https://github.com/FlightControl-Master/MOOSE_MISSIONS.git
git push -u --force origin master
git push -u --force origin develop
