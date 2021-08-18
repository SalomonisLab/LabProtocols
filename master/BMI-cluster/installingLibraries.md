

1. install anaconda or miniconda depending on if you want the full version of conda or mini version from main website
https://www.anaconda.com/products/individual
https://docs.conda.io/en/latest/miniconda.html

2. Follow instructions for installing
```bash bash Miniconda3-latest-Linux-x86_64.sh
```

3. Create conda enviornment and set python verison where the name of conda environment is referenced after -–name option and version of python after python=

```bash conda create --name python3 python=3
```


Output from command line:

Collecting package metadata (current_repodata.json): done
Solving environment: done

## Package Plan ##

  environment location: /Users/username/miniconda3/envs/python3



Proceed ([y]/n)?

```bash y
```


Output from command line:

Preparing transaction: done
Verifying transaction: done
Executing transaction: done


#
# To activate this environment, use
#
#     $ conda activate python3
#
# To deactivate an active environment, use
#
#     $ conda deactivate

Do you wish the installer to initialize Miniconda3
by running conda init? [yes|no]
[no]
#type no if you do not want conda initialized every time run shell command
```bash no
```

3.activate python environment just created which is called python3
```bash conda activate python3
```

#you should notice that in front of your username there is now the name of the conda environment in parenthesis
Ex. (python3) computerName:~ username$


#now you can install any library you would like

4. To install conda libraries in conda use the following command
```bash conda install pip
```
#output:
Collecting package metadata (current_repodata.json): done
Solving environment: done

# All requested packages already installed.







# to install pip libraries in use pip install
```bash pip install Biopython
```

#output:
Collecting Biopython
  Downloading biopython-1.79-cp39-cp39-macosx_10_9_x86_64.whl (2.3 MB)
     |████████████████████████████████| 2.3 MB 2.5 MB/s
Collecting numpy
  Downloading numpy-1.21.2-cp39-cp39-macosx_10_9_x86_64.whl (17.0 MB)
     |████████████████████████████████| 17.0 MB 95.8 MB/s
Installing collected packages: numpy, Biopython
Successfully installed Biopython-1.79 numpy-1.21.2




For running on cluster with latest download follow steps 1 to install
1. Install miniconda or anaconda
>bash /data/salomonis2/LabFiles/Katrina/Miniconda3-latest-Linux-x86_64.sh


2. you need to set proxy_on on command line in order to download conda packages

```bash proxy_on
```
#follow prompts to type in your username and password
#now you can conda create to create a conda environment and conda install to install libraries as above in steps 3-4
