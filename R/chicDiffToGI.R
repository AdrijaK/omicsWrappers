#' chicDiffToGI
#' converts ChicDiff resultsMatrix to a GInteractions object
#' @param ChicDiffResultsDataFrame ChicDiff results data frame
#' @returns GInteractions object with baitchr, baitstart, baitend forming anchorOne and OEchr, OEstart, OEend forming anchorTwo. The remaining columns are stored in mcols().
#' @export

chicDiffToGI = function(ChicDiffResultsDataFrame){

    anchor1 =
    GenomicRanges::makeGRangesFromDataFrame(ChicDiffResultsDataFrame, seqnames.field = "baitchr", start.field = "baitstart", end.field = "baitend")

    anchor2 =
    GenomicRanges::makeGRangesFromDataFrame(ChicDiffResultsDataFrame, seqnames.field = "OEchr", start.field = "OEstart", end.field = "OEend")

  mcols =
    ChicDiffResultsDataFrame %>%
    dplyr::select(group, baseMean, log2FoldChange, baitID, maxOE, minOE, regionID, avgLogDist, avWeights, weighted_pvalue, weighted_padj)

  output =
    InteractionSet::GInteractions(anchor1 , anchor2)

  mcols(output) =
    mcols

  return(output)

}
