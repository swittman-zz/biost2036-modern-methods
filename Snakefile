rule all:
    """This rule defines all of the outputs I want.

    I am asking for the final alignment files for two SRA runs.
    """
    input:
        expand("output/{SRR}.bam", SRR=["SRR3486651", "SRR3487136"]),


rule download_genome:
    """Download the reference genome index

    The aligner ``Hisat2`` requires an index of the reference genome. Here I
    am just using the one for their website, but I typically build my own.

    .. note::
        The index files from Hisat2's website are split into 8 parts.
    """
    output:
        "output/dm6/genome.1.ht2",
        "output/dm6/genome.2.ht2",
        "output/dm6/genome.3.ht2",
        "output/dm6/genome.4.ht2",
        "output/dm6/genome.5.ht2",
        "output/dm6/genome.6.ht2",
        "output/dm6/genome.7.ht2",
        "output/dm6/genome.8.ht2",
    shell:
        "cd output && curl -sSL https://genome-idx.s3.amazonaws.com/hisat/dm6.tar.gz | tar zxf - "


rule download_fastq:
    """Download raw data from the SRA.

    Using the accessions I am downloading the raw data from the SRA.

    .. note::
        I am using `-X 10000` to only download 10,000 reads

    .. note::
        I am pointing at a specific conda environment to use.
    """
    conda:
        "fastq_dump.yml"
    output:
        temp("output/{SRR}_1.fastq.gz"),
    shell:
        "cd output && "
        "fastq-dump {wildcards.SRR} --gzip --split-files -X 10000"


rule run_hisat2:
    input:
        fastq="output/{SRR}_1.fastq.gz",
        index_files=expand(
            "output/dm6/genome.{num}.ht2", num=[1, 2, 3, 4, 5, 6, 7, 8]
        ),
    params:
        prefix="output/dm6/genome",
    output:
        sam=temp("output/{SRR}.sam"),
    conda:
        "alignment.yml"
    shell:
        "hisat2 -x {params.prefix} -U {input.fastq} -S {output.sam}"


rule convert_sam_to_bam:
    input:
        "output/{SRR}.sam",
    output:
        "output/{SRR}.bam",
    conda:
        "alignment.yml"
    shell:
        "samtools view {input[0]} -O BAM -o {output[0]}"
