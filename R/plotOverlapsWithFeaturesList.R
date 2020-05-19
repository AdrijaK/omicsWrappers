#' a wrapper function that plots promoter (GRanges) overlaps with features list (GRangesList):
#'
#' 1. count overlaps for each element in GRanges with features stored in `GRangesList_subject` using summarizeOverlapsWithFeatureList
#' 2. group the mcols of GRanges by status (DOWN/None/UP -regulated)
#' 3. normalise the counts against the number of genes per group and express that as percentage
#' 4. subset the `peaks_all`, `peaks_up`, `peaks_down` and convert to long format for ggplot
#'
#' plotFeatureOverlaps
#' @param GRanges_query GRanges object that will be used as a query
#' @param GRangesList_subject GRangesList object that will be used as a subject
#' @example
#'   CEBPa = makeFeaturesList("/localhome/bric/qlr900/analysis/02_MLL/data/chip-seq/DNA-mapping/CSAW_MACS2_CEBPa")
#'   expressedGenes =  allGenes %>% subset(baseMean > 10)
#'   find coordinates of promoters of deregulated genes:
#'    promoters_of_expressedGenes =  left_join(expressedGenes, promoters_GRCm38_M24_basic, by = c("geneID" = "gene_id")) %>% as("GRanges")
#' # use encode_GRCm38_M24_basic for to make annotation
#' txdb =
#'   makeTxDbFromGFF("/scratch/genomes/snakepipes/GRCm38_M24_basic/annotation/genes.gtf",
#'                   format=c("gtf"),
#'                   dataSource="gencode_GRCm38_M24_basic")
#'
#' promoters_GRCm38_M24_basic = genes(txdb) %>% promoters %>% as.data.frame
#' plotOverlapsWithFeaturesList (promoters_of_expressedGenes, CEBPa)

plotOverlapsWithFeaturesList = function(GRanges_query, GRangesList_subject){

  # Uncomment for troubleshooting
  # GRanges_query = promoters_of_expressedGenes
  # GRangesList_subject = CEBPa


  # 1. count overlaps with each feature in feature list and add it to mcols() of query GRanges object
  overlapSummary =
    summarizeOverlapsWithFeatureList(GRanges_query, GRangesList_subject)

  # 2. group the mcols of GRanges by status
  promoters_grouped_by_status =
    overlapSummary %>%
    mcols %>%                                   # select extra information on deregulated gene promoters
    as.data.frame() %>%                         #
    group_by(Status)                            # group by the gene status (DOWN/None/UP -regulated)

  # 3. count the number of genes per each group  (DOWN/None/UP -regulated) with at least one overlap with features
  #    (each gene is counted only once even if its promoter overlaps with several peaks/restriction fragments)
  nonzeroes_by_status =
    promoters_grouped_by_status %>%               # group by the gene status (DOWN/None/UP -regulated)
    summarise_all(list(~ sum(as.logical(.))))     # count all non-zero rows per group on all columns

  #4. normalise the counts against the number of genes per group and express that as percentage
  nonzeroes_by_status$n_of_genes_per_group =
    promoters_grouped_by_status$Status %>% table %>% as.vector

  nonzeroes_by_status_norm_to_n_of_genes =
    nonzeroes_by_status %>%
    dplyr::mutate_at(
      c("peaks_all", "peaks_up", "peaks_down"),
      funs( 100*(. / n_of_genes_per_group))
    ) # find percentage of all genes in this cathegory that overlap this feature at least once.

  # subset and convert to long format for ggplot
  nonzeroes_by_status_norm_to_n_of_genes %>%
    dplyr::select(Status, peaks_all, peaks_up, peaks_down) %>%
    reshape2::melt(id.vars = c("Status"), variable.name = "cathegory", value.name = "nonzero_features_count") %>%
    plotFeatureOverlaps

}
