# Data Versioning with DVC


## Prerequisite

- Anaconda3


## Setup

Create conda env

```
$ make env
```

Activate conda env

```
$ source init.sh
```

Install `requirementx-pip.txt`

```
$ make setup
```


## Data Versioning with DVC

Initialize dvc.

```
$ dvc init


Initialized DVC repository.

You can now commit the changes to git.

+---------------------------------------------------------------------+
|                                                                     |
|        DVC has enabled anonymous aggregate usage analytics.         |
|     Read the analytics documentation (and how to opt-out) here:     |
|             <https://dvc.org/doc/user-guide/analytics>              |
|                                                                     |
+---------------------------------------------------------------------+

What's next?
------------
- Check out the documentation: <https://dvc.org/doc>
- Get help and share ideas: <https://dvc.org/chat>
- Star us on GitHub: <https://github.com/iterative/dvc>

```

A few files are created.
```
$ tree .dvc

.dvc
├── config
└── tmp
    ├── hashes
    │   └── local
    │       └── cache.db
    └── links
        └── cache.db
```

Add remote(e.g. localstorage)

```
$ dvc remote add localstorage -d ~/remote/data

Setting 'localstroage' as a default remote.
```

Check remote list

```
$ dvc remote list

localstorage   ~/remote/data
```

Add `.dvc/config` on git

```
$ git add .dvc/config
```


## Download data


```
$ make mnist
```
Check data.

```
$ tree dataset

dataset
├── t10k-images-idx3-ubyte
├── t10k-labels-idx1-ubyte
├── train-images-idx3-ubyte
└── train-labels-idx1-ubyte
```

## Add dataset on DVC


Add datasets

```
$ dvc add dataset/

100% Adding...|██████████████████████████████████████████████████████████████████████████████|1/1 [00:00,  5.46file/s]

$ dvc data status

DVC committed changes:
  (git commit the corresponding dvc files to update the repo)
        added: dataset/
(there are other changes not tracked by dvc, use "git status" to see)

```

Commit

```
$ git add dataset.dvc
$ git commit -m "Add v1 mnist  data"

$ dvc data status

No changes.
(there are changes not tracked by dvc, use "git status" to see)
```


`dvc add` moves the data to the project's cache, and links it to the workspace.

```
$ tree .dvc/cache

.dvc/cache
├── 26
│   └── 46ac647ad5339dbf082846283269ea
├── 27
│   └── ae3e4e09519cfbb04c329615203637
├── 6b
│   └── bc9ace898e44ae57da46a324031adb
├── a2
│   └── 5bea736e30d166cdddb491f175f624
└── d0
    └── 193be11ab497254ec667a4864050d9.dir
```

`dataset.dvc` indicates the cache file path.

```
$ cat dataset.dvc

outs:
- md5: d0193be11ab497254ec667a4864050d9.dir # indicate .dvc/cache/d0/193be11ab497254ec667a4864050d9.dir
  size: 54950048
  nfiles: 4
  path: dataset
```

Push data to data remote

```
$ dvc push -r localstorage

$ tree ~/remote/data


├── 26
│   └── 46ac647ad5339dbf082846283269ea
├── 27
│   └── ae3e4e09519cfbb04c329615203637
├── 6b
│   └── bc9ace898e44ae57da46a324031adb
├── a2
│   └── 5bea736e30d166cdddb491f175f624
└── d0
    └── 193be11ab497254ec667a4864050d9.dir
```

Remove data and Retrive data

```
$ rm -r .dvc/cache dataset/

```

Check files are removed.

```
$ tree dataset
$ tree .dvc/cache
```

Pull data from `localstorage` remote
```
$ dvc pull -r localstorage
```

Check files are restored.

```
$ tree dataset
$ tree .dvc/cache
```
