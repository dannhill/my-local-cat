#create folder ./cat/plugins and copy folder ./my_plugin to ./cat/plugins
import os
import shutil
import subprocess

#copy "default_cat" in the same directory and change the name of the copy to "cat"
if not os.path.exists('./cat'):
    shutil.copytree('./default_cat', './cat')

#execute the command "docker compose up -d" in the current directory
subprocess.run(['docker','compose', 'up', '-d', '--build'], check=True)