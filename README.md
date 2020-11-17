# BIOST 2036: Modern Methods in Data Science

Resource and demo repository for guest lecture at the University of Pittsburgh.

## Playing with Snakemake

> I am not sure if this will work on windows. It would be best to use a Linux
> terminal if it is available.

1. Install miniconda following directions [here](https://docs.conda.io/projects/conda/en/latest/user-guide/install/)
2. Clone this repository and move into the new directory.

```bash
$ git clone https://github.com/Fear-Lab/biost2036-modern-methods.git
$ cd biost2036-modern-methods
```


2. Create our class conda environment and activate

```bash
$ conda env create -f ./environment.yml
$ conda activate biost2036
```

3. Run snakemake with 2 processors/threads.

```bash
$ snakemake -p -j2 --use-conda
```

4. There should now be an `output/` folder with our alignment files.

5. Take a look at the `Snakefile` to see what we did.