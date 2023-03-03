import os

# variables
scriptpath = 'archsetup.sh'
target_directory = '/home/mike/mathbike.github.io/_posts/'
mdpath = target_directory + '2022-10-01-arch_install.md'
commit_message = 'updated archsetup.sh'
# get scriptpath file extension
extension = scriptpath.split(".")[1]

# load script into memory as variable called script
with open(scriptpath, 'r') as file:
    script = file.read().rstrip()

# load each line of markdown file into memory as list called mdlist
with open(mdpath, 'r') as file:
    mdlist = file.readlines()

# search mdlist for index matching scriptpath
i  = [index for (index, item) in enumerate(mdlist) if item == '`'+scriptpath+'`\n']
i = i[0]

# search mdlist for first codeblocks opening tag after scriptpath
i2  = [index for (index, item) in enumerate(mdlist) if (index > i) and (item == '```'+extension+'\n')]
i2 = i2[0]

# search mdlist for first codeblocks closing tag after scriptpath
i3  = [index for (index, item) in enumerate(mdlist) if (index > i) and (item == '```\n')]
i3 = i3[0]

# delete everything between codeblocks
mdlist = mdlist[0:i2+2] + mdlist[i3:]

# replace codeblocks with updated script
mdlist[i2+1] = script+'\n'

# write updated markdown file
f = open(mdpath, "w")
for i in mdlist:
    f.write(i)
f.close()

# push to github
os.chdir(target_directory)
os.system('git add .;git commit -m '+commit_message+';git push')