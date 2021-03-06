% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plotOverlapsWithFeaturesList.R
\name{plotOverlapsWithFeaturesList}
\alias{plotOverlapsWithFeaturesList}
\title{a wrapper function that plots promoter (GRanges) overlaps with features list (GRangesList):}
\usage{
plotOverlapsWithFeaturesList(GRanges_query, GRangesList_subject)
}
\arguments{
\item{GRanges_query}{GRanges object that will be used as a query}

\item{GRangesList_subject}{GRangesList object that will be used as a subject}
}
\description{
\enumerate{
\item count overlaps for each element in GRanges with features stored in \code{GRangesList_subject} using summarizeOverlapsWithFeatureList
\item group the mcols of GRanges by status (DOWN/None/UP -regulated)
\item normalise the counts against the number of genes per group and express that as percentage
\item subset the \code{peaks_none}, \code{peaks_up}, \code{peaks_down} and convert to long format for ggplot
}
}
\details{
plotFeatureOverlaps
}
\examples{
  CEBPa = makeFeaturesList("/localhome/bric/qlr900/analysis/02_MLL/data/chip-seq/DNA-mapping/CSAW_MACS2_CEBPa")
  expressedGenes =  allGenes \%>\% subset(baseMean > 10)
  find coordinates of promoters of deregulated genes:
   promoters_of_expressedGenes =  left_join(expressedGenes, promoters_GRCm38_M24_basic, by = c("geneID" = "gene_id")) \%>\% as("GRanges")
# use encode_GRCm38_M24_basic for to make annotation
txdb =
  makeTxDbFromGFF("/scratch/genomes/snakepipes/GRCm38_M24_basic/annotation/genes.gtf",
                  format=c("gtf"),
                  dataSource="gencode_GRCm38_M24_basic")

promoters_GRCm38_M24_basic = genes(txdb) \%>\% promoters \%>\% as.data.frame
plotOverlapsWithFeaturesList (promoters_of_expressedGenes, CEBPa)
}
